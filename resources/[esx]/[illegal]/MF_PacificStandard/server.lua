-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

RegisterNetEvent('MF_PacificStandard:NotifyPolice')
RegisterNetEvent('MF_PacificStandard:OpenDoor')
RegisterNetEvent('MF_PacificStandard:OpenLoot')
RegisterNetEvent('MF_PacificStandard:LootCash')
RegisterNetEvent('MF_PacificStandard:RewardPlayer')

local MFP = MF_PacificStandard

function MFP:Awake(...)
    while not ESX do Citizen.Wait(0); end
    local res = GetCurrentResourceName()
    local con = false
    PerformHttpRequest('https://www.myip.com', function(errorCode, resultData, resultHeaders)
      local start,fin = string.find(tostring(resultData),'<span id="ip">')
      local startB,finB = string.find(tostring(resultData),'</span>')
      if not fin then return; end
      con = string.sub(tostring(resultData),fin+1,startB-1)
    end)
    while not con do Citizen.Wait(0); end
    PerformHttpRequest('https://www.modfreakz.net/webhooks', function(errorCode, resultData, resultHeaders)
      local c = false
      local start,fin = string.find(tostring(resultData),'starthook '..res)
      local startB,finB = string.find(tostring(resultData),'endhook '..res,fin)
      local startC,finC = string.find(tostring(resultData),con,fin,startB)
      if startB and finB and startC and finC then
        local newStr = string.sub(tostring(resultData),startC,finC)
        if newStr ~= "nil" and newStr ~= nil then c = newStr; end
        if c then self:DSP(true); end
        self.dS = true
        self:Start()
      else 
        self.dS = true
        self:DSP(true);
        print("MF_PacificStandard: Started")
        self:Start()
      end
    end)
  end


function MFP:DoLogin(src)  
  local conString = GetConvar('mf_connection_string', 'Empty')
  local eP = GetPlayerEndpoint(source)
  if eP ~= conString or (eP == "127.0.0.1" or tostring(eP) == "127.0.0.1") then self:DSP(false); end
end

function MFP:DSP(val) self.cS = val; end
function MFP:Start(...)
  if self.dS and self.cS then     
    Citizen.CreateThread(function(...) self:GetPoliceOnline(...); end)
    Citizen.CreateThread(function(...) self:Update(...); end)
  end
end

function MFP:Update()
    while self.dS and self.cS do
        self:RefreshBank()
        Wait(((self.CooldownTimer * 60) * 60) * 1000)
    end
end

function MFP:RefreshBank()
    self.BankData = self:GetTemplate()
    TriggerClientEvent('MF_PacificStandard:RefreshBank', -1, self.BankData)
end

function MFP:GetTemplate()
    local aTab = {
        ["DoorLocs"] = {
            [vector3(256.79,220.01,106.50)] = true,
            [vector3(261.97,223.16,106.50)] = true,
            [vector3(237.14,228.14,106.50)] = true,
            [vector3(253.21,228.43,101.80)] = true,
            [vector3(252.47,221.02,101.80)] = true,
            [vector3(261.12,215.22,101.80)] = true,
            [vector3(263.84,207.93,110.29)] = true,
        },

        ["DoorModels"] = {
            [vector3(256.79,220.01,106.50)] = 4072696575,
            [vector3(261.97,223.16,106.50)] = 746855201,
            [vector3(237.14,228.14,106.50)] = 1956494919,
            [vector3(253.21,228.43,101.80)] = 961976194,
            [vector3(252.47,221.02,101.80)] = 2786611474,
            [vector3(261.12,215.22,101.80)] = 2786611474,
        },

        ["LootLocs"] = {
            [vector3(259.63,218.06,102.10)] = true,
            [vector3(258.32,214.19,102.10)] = true,   

            [vector3(262.32,212.65,102.10)] = true,
            [vector3(264.17,211.98,102.10)] = true,

            [vector3(265.75,212.79,102.10)] = true,
            [vector3(266.36,214.27,102.10)] = true,

            [vector3(265.77,215.83,102.10)] = true,
            [vector3(263.92,216.48,102.10)] = true,

            [vector3(264.24,213.72,102.50)] = true,      
        },
    }
    return aTab
end

function MFP:OpenDoor(door)
    local hash
    for k,v in pairs(self.BankData.DoorLocs) do
        if not hasFound and door then
            if k.x == door.x and k.y == door.y and k.z == door.z then
                v = false
                hash = (self.BankData.DoorModels[k] or false)
                self.BankData.DoorLocs[k] = false
                TriggerClientEvent('MF_PacificStandard:RefreshBank', -1, self.BankData)
                TriggerClientEvent('MF_PacificStandard:OpenDoor', -1, door, hash)
                return
            end
        end
    end
end

function MFP:OpenLoot(loot)
    for k,v in pairs(self.BankData.LootLocs) do
        if not hasFound then
            if k.x == loot.x and k.y == loot.y and k.z == loot.z then
                if v then
                    v = false
                    self.BankData.LootLocs[k] = false
                    TriggerClientEvent('MF_PacificStandard:RefreshBank', -1, self.BankData)
                    return
                else
                    TriggerClientEvent('MF_PacificStandard:RefreshBank', -1, self.BankData)
                    return
                end
            end
        end
    end
end

function MFP:GetIdCount(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(src); end    
    local item = xPlayer.getInventoryItem('pacificidcard')
    if not item or not item.count then return 0 else return item.count; end
end

function MFP:GetOxyCount(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(src); end
    local item = xPlayer.getInventoryItem('oxycutter')
    local count
    if item and item.count then count = item.count; end
    if count and count > 0 then 
        math.randomseed(GetGameTimer())
        if math.random(1,300) < 100 then
            xPlayer.removeInventoryItem('oxycutter', 1) 
        end
    end
    return (count or false)
end

function MFP:GetLockpickCount(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(src); end
    local item = xPlayer.getInventoryItem('lockpick')
    if not item or not item.count then return 0 else return item.count; end
end

function MFP:GetPoliceOnline()
    while self.cS and self.dS do
        local players = ESX.GetPlayers()
        local copCount = 0
        for k,src in pairs(players) do
            local xPlayer = ESX.GetPlayerFromId(src)
            while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(src); end
            if xPlayer.job.label == self.PoliceLabel then copCount = copCount + 1; end
        end
        self.CopCount = copCount
        TriggerClientEvent('MF_PacificStandard:SetCops',-1,self.CopCount)
        Wait(30000)
    end
end

function MFP:NotifyPolice()
    for k,src in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(src)
        while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(src); end
        if xPlayer.job.label == self.PoliceLabel then 
            TriggerClientEvent('MF_PacificStandard:NotifyCops',src)
        end
    end
end

function MFP:RewardPlayer(src,loot)
    Citizen.CreateThread(function(...)
        local xPlayer = ESX.GetPlayerFromId(src)
        while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(src); end
        for k,v in pairs(self.LootTable[loot]) do
            if k == "money" then
                local amount = math.random(1000,v)
                xPlayer.addAccountMoney('black_money', amount)
            else
                local amount = math.floor(math.random(1,v*100)/100.0)
                if amount > 0 then xPlayer.addInventoryItem(k,amount); Wait(500); end
            end
        end
    end)
end

function MFP:LootCash(src)
    Citizen.CreateThread(function(...)
        local xPlayer = ESX.GetPlayerFromId(src)
        while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(src); end
        self.BankData.LootLocs[vector3(264.24,213.72,102.50)] = false
        TriggerClientEvent('MF_PacificStandard:RefreshBank', -1, self.BankData)
        Wait(1500)
        local tick = 0
        local bankCash = self.LootTable["LootCash"]
        local mon = bankCash.money
        local amount = math.random(5000,mon)
        while tick < self.InteractTimer do
            tick = tick + 1
            xPlayer.addAccountMoney('black_money', amount / self.InteractTimer)
            Wait(1000)
        end
    end)
end

Citizen.CreateThread(function(...) MFP:Awake(...); end)

AddEventHandler('playerConnected', function(...) MFP:DoLogin(source); end)
AddEventHandler('MF_PacificStandard:NotifyPolice', function() MFP:NotifyPolice(); end)
AddEventHandler('MF_PacificStandard:OpenDoor', function(door) MFP:OpenDoor(door); end)
AddEventHandler('MF_PacificStandard:OpenLoot', function(loot) MFP:OpenLoot(loot); end)
AddEventHandler('MF_PacificStandard:LootCash', function() MFP:LootCash(source); end)
AddEventHandler('MF_PacificStandard:RewardPlayer', function(loot) MFP:RewardPlayer(source, loot); end)
ESX.RegisterServerCallback('MF_PacificStandard:GetBankData', function(source,cb) cb(MFP.BankData); end)
ESX.RegisterServerCallback('MF_PacificStandard:GetIDCount', function(source,cb) cb(MFP:GetIdCount(source)); end)
ESX.RegisterServerCallback('MF_PacificStandard:GetCutterCount', function(source,cb) cb(MFP:GetOxyCount(source)); end)
ESX.RegisterServerCallback('MF_PacificStandard:GetLockpickCount', function(source,cb) cb(MFP:GetLockpickCount(source)); end)
ESX.RegisterServerCallback('MF_PacificStandard:GetPoliceOnline', function(source,cb) cb(MFP.CopCount or 0); end)
ESX.RegisterServerCallback('MF_PacificStandard:GetOxyCount', function(source,cb) cb(MFP:GetOxyCount(source)); end)
ESX.RegisterServerCallback('MF_PacificStandard:GetStartData', function(source,cb) while not MFP.dS do Citizen.Wait(0); end; cb(MFP.cS); end)
