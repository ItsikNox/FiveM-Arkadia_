-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

RegisterNetEvent('MF_PacificStandard:RefreshBank')
RegisterNetEvent('MF_PacificStandard:OpenDoor')
RegisterNetEvent('MF_SafeCracker:EndMinigame')
RegisterNetEvent('MF_LockPicking:MinigameComplete')
RegisterNetEvent('MF_PacificStandard:NotifyCops')
RegisterNetEvent('MF_PacificStandard:SetCops')

local MFP = MF_PacificStandard

function MFP:Start(...)
    while not ESX do Citizen.Wait(0) end
    while not ESX.IsPlayerLoaded() do Citizen.Wait(0); end
    self.SoundID    = GetSoundId() 
    self.DoorCount  = 0
    if not RequestAmbientAudioBank(self.AudioBank, false) then RequestAmbientAudioBank(self.AudioBankName, false); end
    ESX.TriggerServerCallback('MF_PacificStandard:GetBankData', function(bankData) self.BankData = bankData; for k,v in pairs(self.BankData.DoorLocs) do if v then self.DoorCount = math.min(self.DoorCount + 1,7); end; end; end)
    while not self.BankData do Citizen.Wait(0); end
    if self.dS and self.cS then self:Update(); end
end

function MFP:SpawnSafe()
  self.SafeObject = true
  local newPos = vector3(264.19,207.45,109.59)
  TriggerEvent('MF_SafeCracker:SpawnSafe', false, newPos, 247.0, function(safeObj) self.SafeObject = safeObj; end)
end

function MFP:SpawnCash()
    local pos = vector3(264.24,213.72,101.52)
    local hk = GetHashKey('bkr_prop_bkr_cashpile_04')
    while not HasModelLoaded(hk) do RequestModel(hk); Citizen.Wait(0) end
    self.CashObject = CreateObject(hk, pos.x, pos.y, pos.z, false, false, false)
    SetEntityHeading(self.CashObject, 290.0)
    FreezeEntityPosition(self.CashObject,true)
    SetModelAsNoLongerNeeded(hk)
end

MFP.PoliceOnline = 0
MFP.GetPolTimer = 30 -- seconds
function MFP:Update()
    local tick = 0
    local timer = GetGameTimer()
    while true do
        Citizen.Wait(0)     
        tick = tick + 1
        local plyPed = GetPlayerPed(-1)
        local plyPos = GetEntityCoords(plyPed)
        local dist = Utils:GetVecDist(plyPos, self.BankLocation)

        if dist < self.LoadDist then
            if not self.BankData or (not self.BankData.DoorLocs or self.DoorCount <= 0) then
                print("NOT DOOR STUFF")                
                ESX.TriggerServerCallback('MF_PacificStandard:GetBankData', function(bankData) self.BankData = bankData; end)
            end

            if self.BankData and self.BankData.DoorLocs then
                if not self.ZoneLoaded then
                    if not self.CashObject then self:SpawnCash(); end
                    if not self.SafeObject then self:SpawnSafe(); end
                    local allObjs = ESX.Game.GetObjects()
                    local didLock = 0
                    for k,v in pairs(allObjs) do
                        local objPos = GetEntityCoords(v)
                        local closest,closestDist
                        for key,val in pairs(self.BankData.DoorLocs) do
                            local dist = Utils:GetVecDist(objPos,key)
                            if not closestDist or dist < closestDist then
                                closest = k
                                closestDist = dist
                            end
                        end

                        if closestDist < 5.0 then
                            local hKey = GetEntityModel(v)
                            local rKey = hKey % 0x100000000
                            local found = false
                            for key,val in pairs(self.BankData.DoorModels) do
                                if hKey == val or rKey == val then
                                    found = true
                                    locked = self.BankData.DoorLocs[key]
                                end
                            end

                            if found and locked then
                                FreezeEntityPosition(v,true)
                                didLock = didLock + 1
                            else
                            end                          
                        end
                    end  

                    if self.DoorCount >= 0 and didLock >= self.DoorCount then 
                        print("MF_PacificStandard : Locked All Doors")
                        self.ZoneLoaded = true
                    else
                        Citizen.Wait(0)
                    end
                end
            end

            local closestKey,closestVal,closestDis,closestText
            for k,v in pairs(self.Actions) do
                local dist = Utils:GetVecDist(v,plyPos)
                if not closestDis or dist < closestDis then
                    closestKey = k
                    closestVal = v
                    closestDis = dist
                    closestText = self.ActionText[k]
                end
            end

            if self.BankData and closestDis and closestDis < self.InteractDist and not self.DoingAction and self.PoliceOnline and self.PoliceOnline >= self.MinPoliceCount then
                if self.BankData.DoorLocs[closestVal] or self.BankData.LootLocs[closestVal] then
                    Utils:DrawText3D(closestVal.x,closestVal.y,closestVal.z, closestText)

                    if Utils:GetKeyPressed("E") then
                        if not self.DoingAction then
                            self.DoingAction = closestVal
                            self:DoAction(closestKey)
                        end
                    end                  
                end
            end
        else
            if self.ZoneLoaded then 
                self.ZoneLoaded = false 
                if self.SafeObject then
                    for k,v in pairs(self.SafeObject) do DeleteObject(v); end
                    self.SafeObject = false
                end
            end
        end
    end
end

function MFP:DoAction(act)
    if act == "Hack" then
        TriggerEvent("mhacking:show")
        TriggerEvent("mhacking:start",7,35,self.HackingCb)
        FreezeEntityPosition(GetPlayerPed(-1),true)
    elseif act == "LockpickA" or act == "LockpickB" or act == "LockpickC" then
        ESX.TriggerServerCallback('MF_PacificStandard:GetLockpickCount', function(count)
            if count and count > 0 then
                TriggerEvent('MF_LockPicking:StartMinigame')
            else
                ESX.ShowNotification("You don't have any lockpicks.")
                self.DoingAction = false
            end
        end)
    elseif act == "Identify" then
        self:HandleVaultDoor(self.DoingAction)
    elseif act == "Safe" then
        FreezeEntityPosition(GetPlayerPed(-1),true)
        TriggerEvent('MF_SafeCracker:StartMinigame', self.SafeRewards)
    elseif act == "LootA" or act == "LootB" or act == "LootC" or act == "LootD" or act == "LootE" or act == "LootF" or act == "LootG" or act == "LootH" then
        ESX.TriggerServerCallback('MF_PacificStandard:GetOxyCount', function(count)
            if count and count > 0 then
                self:HandleLooting(act)
            else
                ESX.ShowNotification("You need a plasma torch to cut this open.")
                self.DoingAction = false
            end
        end)
    elseif act == "LootCash" then
        self:HandleLootCash()
    end

    TriggerServerEvent('MF_PacificStandard:NotifyPolice')
end

function MFP:HandleLootCash()
    local plySkin
    TriggerEvent('skinchanger:getSkin', function(skin) plySkin = skin; end)
    if (plySkin["bags_1"] ~= 0 or plySkin["bags_2"] ~= 0) then
        Citizen.CreateThread(function(...)
            TriggerServerEvent('MF_PacificStandard:LootCash')     

            TaskTurnPedToFaceCoord(plyPed, self.DoingAction.x, self.DoingAction.y, self.DoingAction.z, -1)
            Wait(1500)
            local plyPed = GetPlayerPed(-1)

            exports['progressBars']:startUI(self.InteractTimer * 1000, "Looting Cash")
            ESX.Streaming.RequestAnimDict('mp_take_money_mg', function(...)
                TaskPlayAnim( plyPed, "mp_take_money_mg", "stand_cash_in_bag_loop", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )     
            end)
            Wait(self.InteractTimer * 1000)
            ClearPedTasksImmediately(plyPed)
            Wait(1000)

            self.DoingAction = false
        end)
    else
        ESX.ShowNotification("You need a bag to carry all this cash.")
        self.DoingAction = false
    end
end

function MFP:Awake(...)
    while not ESX do Citizen.Wait(0); end
    while not ESX.IsPlayerLoaded() do Citizen.Wait(0); end
    ESX.TriggerServerCallback('MF_PacificStandard:GetStartData', function(retVal) self.dS = true; self.cS = retVal; end)
    while not self.dS do Citizen.Wait(0); end
    self:Start()
end

function MFP:HandleLooting(act)
    ESX.TriggerServerCallback('MF_PacificStandard:GetCutterCount', function(count)
        if count then
            TriggerServerEvent('MF_PacificStandard:OpenLoot', self.DoingAction)
            local plyPed = GetPlayerPed(-1)

            TaskTurnPedToFaceCoord(plyPed, self.DoingAction.x, self.DoingAction.y, self.DoingAction.z, -1)
            Wait(2000)

            FreezeEntityPosition(plyPed,true)
            exports['progressBars']:startUI(self.InteractTimer * 1000, "Cutting")
            TaskStartScenarioInPlace(plyPed, "WORLD_HUMAN_WELDING", 0, true)
            Wait(self.InteractTimer * 1000)

            ClearPedTasksImmediately(plyPed)
            FreezeEntityPosition(plyPed,false)
            TriggerServerEvent('MF_PacificStandard:RewardPlayer', act)
        else
            ESX.ShowNotification("You don't have any plasma cutters.")
        end
        self.DoingAction = false
    end)
end

function MFP:HandleVaultDoor(closest)
  ESX.TriggerServerCallback('MF_PacificStandard:GetIDCount', function(count)
    if count and count > 0 then
      local plyPed = GetPlayerPed(-1)
      TaskTurnPedToFaceCoord(plyPed, closest.x, closest.y, closest.z, -1)
      Wait(2000)

      FreezeEntityPosition(plyPed,true)
      exports['progressBars']:startUI(self.InteractTimer * 1000, "Requesting Access")
      TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_ATM", 0, true)
      Wait(self.InteractTimer * 1000)

      TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_ATM", 0, false)
      Wait(1500)

      ClearPedTasksImmediately(plyPed)
      FreezeEntityPosition(plyPed,false)
      Wait(100)
      TriggerServerEvent('MF_PacificStandard:OpenDoor', self.DoingAction)
    else
      ESX.ShowNotification("You havn't got a bank ID card.")
    end
    self.DoingAction = false
  end)
end

function MFP.HackingCb(success)
    FreezeEntityPosition(GetPlayerPed(-1),false)
    TriggerEvent('mhacking:hide')
    if success then
        TriggerServerEvent('MF_PacificStandard:OpenDoor', MFP.DoingAction)
    end
    MFP.DoingAction = false;
end

function MFP:OpenDoor(doorloc,doorhash)
    if self.ZoneLoaded then
        Citizen.CreateThread(function(...) 
            local allObjs = ESX.Game.GetObjects()

            local closestObj,closestDist
            for k,v in pairs(allObjs) do
                local hKey = GetEntityModel(v)
                local rKey = hKey % 0x100000000
                if hKey == doorhash or rKey == doorhash then
                    local dist = Utils:GetVecDist(doorloc, GetEntityCoords(v))
                    if not closestDist or dist < closestDist then
                        closestObj = v
                        closestDist = dist
                    end
                end
            end

            if closestDist and closestDist < self.LoadDist then
                local tick = 0
                local modifier = 0.3
                if doorhash == 961976194 then modifier = -0.3; end
                while tick < 350 do
                    Citizen.Wait(5)
                    tick = tick + 1
                    local entHeading = GetEntityHeading(closestObj)
                    SetEntityHeading(closestObj, entHeading + modifier)
                end
            end
        end)
    end        
end

function MFP:FinishLockpick(result)
    FreezeEntityPosition(GetPlayerPed(-1),false)
    if result then
        TriggerServerEvent('MF_PacificStandard:OpenDoor', self.DoingAction)
    end
    self.DoingAction = false;
end

function MFP:NotifyCops()
  ESX.ShowNotification("Somebody is robbing Pacific Standard bank!")  
  Citizen.CreateThread(function(...)
    local blipA = AddBlipForRadius(246.78, 218.70, 106.30, 100.0)
    SetBlipHighDetail(blipA, true)
    SetBlipColour(blipA, 1)
    SetBlipAlpha (blipA, 128)

    local blipB = AddBlipForCoord(246.78, 218.70, 106.30)
    SetBlipSprite               (blipB, 458)
    SetBlipDisplay              (blipB, 4)
    SetBlipScale                (blipB, 1.0)
    SetBlipColour               (blipB, 1)
    SetBlipAsShortRange         (blipB, true)
    SetBlipHighDetail           (blipB, true)
    BeginTextCommandSetBlipName ("STRING")
    AddTextComponentString      ("Robbery In Progress")
    EndTextCommandSetBlipName   (blipB)

    local timer = GetGameTimer()
    while GetGameTimer() - timer < 30000 do
      Citizen.Wait(0)
    end

    RemoveBlip(blipA)
    RemoveBlip(blipB)
  end)
end

AddEventHandler('MF_PacificStandard:RefreshBank', function(bankData) MFP.BankData = bankData; end)
AddEventHandler('MF_PacificStandard:OpenDoor', function(doorloc,doorhash) MFP:OpenDoor(doorloc,doorhash); end)
AddEventHandler('MF_PacificStandard:NotifyCops', function() MFP:NotifyCops(); end)
AddEventHandler('MF_PacificStandard:SetCops', function(val) MFP.PoliceOnline = val; end)
AddEventHandler('MF_SafeCracker:EndMinigame', function(won) MFP:FinishLockpick(won); end)
AddEventHandler('MF_LockPicking:MinigameComplete', function(result) MFP:FinishLockpick(result); end)
AddEventHandler('MF_LockPicking:MinigameComplete', function(result) MFP:FinishLockpick(result); end)

Citizen.CreateThread(function(...) MFP:Awake(...); end)