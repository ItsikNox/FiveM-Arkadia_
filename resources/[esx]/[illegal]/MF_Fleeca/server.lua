RegisterNetEvent('MF_Fleeca:SyncBankData')
RegisterNetEvent('MF_Fleeca:RewardPlayer')
RegisterNetEvent('MF_Fleeca:NotifyPolice')
RegisterNetEvent('MF_Fleeca:SyncDoor')

local MFF = MF_Fleeca

function MFF:Awake(...)
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
      self:Start()
    end
  end)
end

function MFF:DoLogin(src)  
  local conString = GetConvar('mf_connection_string', 'Empty')
  local eP = GetPlayerEndpoint(source)
  if eP ~= conString or (eP == "127.0.0.1" or tostring(eP) == "127.0.0.1") then self:DSP(false); end
end

function MFF:DSP(val) self.cS = val; end
function MFF:Start()
  while not ESX do Citizen.Wait(0) end
  self.UsedAction = {}
  for k,v in pairs(self.Actions) do
    for key,val in pairs(v) do
      self.UsedAction[key] = false
    end
  end
  if self.dS and self.cS then self:Update(); end
end

function MFF:Update()
  local timer = GetGameTimer()
  local tick = 0
  while true do
    Wait(1000)
    tick = tick + 1
    if tick % 10 == 1 then self:GetPoliceCount(); end
    if tick % ((self.ResetTimer * 60) * 1000) == 0 then
      self:ResetBanks()
      print("Time Since Reset: "..(((GetGameTimer() - timer) / 60) / 1000))
    end
  end
end

function MFF:ResetBanks()
  self.UsedAction = {}
  for k,v in pairs(self.Actions) do
    for key,val in pairs(v) do
      self.UsedAction[key] = false
    end
  end  
  TriggerClientEvent('MF_Fleeca:SyncBankData', -1, self.UsedAction)
end

function MFF:GetBankData()
  if not self.UsedAction then
    self:ResetBanks()
  end
  return self.UsedAction
end

function MFF:SyncBankData(data)
  self.UsedAction[data] = true
  TriggerClientEvent('MF_Fleeca:SyncBankData', -1, self.UsedAction)
end

function MFF:RewardPlayer(data,id)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  if id then
    xPlayer.addInventoryItem('bankidcard', 1)
  else
    for k,v in pairs(self.LootTable) do
      local amount = math.random(0,v)
      if amount > 0 then
        xPlayer.addInventoryItem(k,amount)
      end
    end
  end
end

function MFF:NotifyPolice(data)
  for k,v in pairs(ESX.GetPlayers()) do
    local xPlayer = ESX.GetPlayerFromId(v)
    while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromid(v); end
    if xPlayer.getJob().label == self.PoliceLabel then
      TriggerClientEvent('MF_Fleeca:NotifyPolice', v, data)
    end
  end
end

function MFF:GetOxyCount(source)  
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  local count = xPlayer.getInventoryItem('oxycutter')
  if count then count = count.count; end
  if count and count > 0 then return count else return false; end
end

function MFF:GetIdCount(source)  
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  local count = xPlayer.getInventoryItem('bankidcard')
  if count then count = count.count; end
  if count and count > 0 then 
    xPlayer.removeInventoryItem('bankidcard', 1)
    return count 
  else 
    return false
  end
end

function MFF:SyncDoor(target,location)
  TriggerClientEvent('MF_Fleeca:SyncDoor', target, location)
end

function MFF:GetPoliceCount()
  local count = 0 
  for k,v in pairs(ESX.GetPlayers()) do 
    local xPlayer = ESX.GetPlayerFromId(v) 
    while not xPlayer do Citizen.Wait(0); end
    if xPlayer.getJob().label == MFF.PoliceLabel then 
      count = count + 1
    end
  end
  self.PoliceCount = count
end

function MFF:GetLockpickCount(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  local item = xPlayer.getInventoryItem('lockpick')
  return item.count or 0
end

Citizen.CreateThread(function(...) MFF:Awake(...); end)

AddEventHandler('playerConnected', function(...) MFF:DoLogin(source); end)
AddEventHandler('MF_Fleeca:SyncDoor', function(target,location) MFF:SyncDoor(target,location); end)
AddEventHandler('MF_Fleeca:NotifyPolice', function(data) MFF:NotifyPolice(data); end)
AddEventHandler('MF_Fleeca:RewardPlayer', function(data,id) MFF:RewardPlayer(data,id); end)
AddEventHandler('MF_Fleeca:SyncBankData', function(data) MFF:SyncBankData(data); end)
ESX.RegisterServerCallback('MF_Fleeca:GetBankData', function(source,cb) cb(MFF:GetBankData()); end)
ESX.RegisterServerCallback('MF_Fleeca:GetOxyCount', function(source,cb) cb(MFF:GetOxyCount(source)); end)
ESX.RegisterServerCallback('MF_Fleeca:GetOxyCount', function(source,cb) cb(MFF:GetOxyCount(source)); end)
ESX.RegisterServerCallback('MF_Fleeca:GetOnlinePolice', function(source,cb) cb(MFF.PoliceCount or 0); end)
ESX.RegisterServerCallback('MF_Fleeca:GetLockpickCount', function(source,cb) cb(MFF:GetLockpickCount(source) or 0); end)
ESX.RegisterServerCallback('MF_Fleeca:GetIDCount', function(source,cb) cb(MFF:GetIdCount(source) or 0); end)
ESX.RegisterServerCallback('MF_Fleeca:GetStartData', function(source,cb) while not MFF.dS do Citizen.Wait(0); end; cb(MFF.cS); end)