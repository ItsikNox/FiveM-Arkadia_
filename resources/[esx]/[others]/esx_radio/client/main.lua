--- SCRIPT CREATED BY DNP
--- DONT RELEASE THAT SCRIPT

local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

ESX = nil
local PlayerData = {}
local Busy = false
local Nearby = false
-- THREADS

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    
    PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if IsControlPressed(2, Keys["LEFTALT"]) and GetLastInputMethod(2) and Busy == false and PlayerData.job.name ~= nil and PlayerData.job.name == "police" then
            ESX.TriggerServerCallback('esx_walkie:getItemAmount', function(quantity)
                if quantity > 0 then
                    --TriggerServerEvent("esx_walkie:playSoundWithinDistanceServer", 10, "copradiooff", 1.0)
                    TriggerServerEvent("esx_walkie:startActionB") -- Aktion für andere Personen starten
                    TriggerEvent("esx_walkie:startAnim", source)
                    DisableActions(PlayerPedId())
                    Busy = true
                    -- Aktiviere esx_walkie Talkie
                end
            end, 'radio')
        elseif not IsControlPressed(2, Keys["LEFTALT"]) and GetLastInputMethod(2) and Busy == true and PlayerData.job.name ~= nil and PlayerData.job.name == "police" then
            -- Deaktiviere esx_walkie Talkie
            TriggerServerEvent("esx_walkie:playSoundWithinDistanceServer", 10, "copradio", 1.0)
            TriggerServerEvent("esx_walkie:stopActionB") -- Aktion für andere Personen stoppen
            TriggerEvent("esx_walkie:stopAnim", source)
            EnableActions(PlayerPedId())
            Busy = false
            
        else
        end
    end
end)


function EnableActions(ped)
    EnableControlAction(1, 140, true)
    EnableControlAction(1, 141, true)
    EnableControlAction(1, 142, true)
    EnableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
    DisablePlayerFiring(ped, false) -- Disable weapon firing
end

function DisableActions(ped)
    DisableControlAction(1, 140, true)
    DisableControlAction(1, 141, true)
    DisableControlAction(1, 142, true)
    DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
    DisablePlayerFiring(ped, true) -- Disable weapon firing
end

-- EVENTS

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
    
    Citizen.Wait(5000)
end)

RegisterNetEvent("esx_walkie:startActionB") -- Aktion Person B
AddEventHandler("esx_walkie:startActionB", function()
    NetworkSetTalkerProximity(0.00) -- Sprachreichweite wird unbegrenzt
end)

RegisterNetEvent("esx_walkie:stopActionB") -- Aktion Person B
AddEventHandler("esx_walkie:stopActionB", function()
    NetworkSetTalkerProximity(6.00) -- Sprachreichweite wird 6 Meter
end)

RegisterNetEvent("esx_radio:notify")
AddEventHandler("esx_radio:notify", function(icon, type, sender, title, text)
    Citizen.CreateThread(function()
		Wait(1)
		SetNotificationTextEntry("STRING");
		AddTextComponentString(text);
		SetNotificationMessage(icon, icon, true, type, sender, title, text);
		DrawNotification(false, true);
    end)
end)

RegisterNetEvent("esx_walkie:startAnim") -- Event, um andere Personen Animation starten zu lassen
AddEventHandler("esx_walkie:startAnim", function()
    Citizen.CreateThread(function()
        if not IsPedSittingInAnyVehicle(PlayerPedId()) and not GetIsTaskActive(PlayerPedId(), 12) then
            RequestAnimDict("random@arrests")
            while not HasAnimDictLoaded("random@arrests") do
                Citizen.Wait(1)
            end
			TriggerEvent("esx_radio:notify", "CHAR_CALL911", 1, "911", false, 'Vous parlez désormais à la radio')
            TaskPlayAnim(GetPlayerPed(-1), "random@arrests", "generic_radio_enter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0)
        end
    end)
end)
RegisterNetEvent("esx_walkie:stopAnim")
AddEventHandler("esx_walkie:stopAnim", function()
    Citizen.CreateThread(function()
        Citizen.Wait(1)
        ClearPedTasks(GetPlayerPed(-1))
    end)
	TriggerEvent("esx_radio:notify", "CHAR_CALL911", 1, "911", false, 'Vous ne parlez plus à la radio')
    TriggerServerEvent("esx_walkie:playSoundWithinDistanceServer", 10.0, 'copradio', 1.0)
end)

RegisterNetEvent('esx_walkie:playSoundWithinDistanceClient')
AddEventHandler('esx_walkie:playSoundWithinDistanceClient', function(playerNetId, maxDistance, soundFile, soundVolume)
    local lCoords = GetEntityCoords(GetPlayerPed(-1))
    local eCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerNetId)))
    local distIs = Vdist(lCoords.x, lCoords.y, lCoords.z, eCoords.x, eCoords.y, eCoords.z)
    if (distIs <= maxDistance) then
        SendNUIMessage({
            transactionType = 'playSound',
            transactionFile = soundFile,
            transactionVolume = soundVolume
        })
    end
    print("Triger")
end)

