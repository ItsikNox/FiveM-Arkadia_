local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX                             = nil
local PlayerData                = {}
local GUI                       = {}
GUI.Time                        = 0
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

function OpenVehicleMenu() -- Menu location véhicules

    local elements = {
        {label = 'Scooter 250$', value = 'Faggio', price = 250},
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'vehicle_menu',
        {
            title = 'Location de véhicules', -- Titre du menu
            elements = elements
        },
        function(data, menu)
            for i=1, #elements, 1 do
                local playerPed = GetPlayerPed(-1)
                local platenum = math.random(00001, 99998)
				local coords    = Config.Zones.LocationVehicleEntering.Pos 
				local price     = data.current.price
                ESX.Game.SpawnVehicle(data.current.value, coords, 200.0, function(vehicle)
                    TaskWarpPedIntoVehicle(playerPed, vehicle, -1) -- Téléportation du joueur dans le véhicule
                    SetVehicleNumberPlateText(vehicle, 'LOCATION' .. platenum) -- Modification de la plaque d'immatriculation en LOCATION
                end)
                TriggerServerEvent('esx_location:Buy', price) -- Event permetant de faire payer le joueur
                break
            end
            menu.close()
    end,
    function(data, menu)
        menu.close()
        CurrentAction     = 'locationVehicle_menu'
        CurrentActionMsg  = '~INPUT_CONTEXT~ Location de véhicules'
        CurrentActionData = {}
    end
    )
end

AddEventHandler('esx_location:hasEnteredMarker', function(zone)

    if zone == 'LocationVehicleEntering' then
        CurrentAction     = 'locationVehicle_menu'
        CurrentActionMsg  = '~INPUT_CONTEXT~ Location de véhicules'
        CurrentActionData = {}
	end

end)

AddEventHandler('esx_location:hasExitedMarker', function(zone)
    CurrentAction = nil
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		for k,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Wait(0)
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil
		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
				isInMarker  = true
				currentZone = k
			end
		end
		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('esx_location:hasEnteredMarker', currentZone)
		end
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_location:hasExitedMarker', LastZone)
		end

	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if CurrentAction ~= nil then
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            if IsControlPressed(0, Keys['E']) and (GetGameTimer() - GUI.Time) > 300 then
                if CurrentAction == 'locationVehicle_menu' then
                    OpenVehicleMenu()
				end
				CurrentAction = nil
				GUI.Time      = GetGameTimer()
            end
		end
    end  
end)

-- Blips
Citizen.CreateThread(function()	

    local blip = AddBlipForCoord(Config.Zones.LocationVehicleEntering.Pos.x, Config.Zones.LocationVehicleEntering.Pos.y, Config.Zones.LocationVehicleEntering.Pos.z)
    
	SetBlipSprite (blip, 409)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.6)
	SetBlipColour (blip, 5)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("~o~Location de véhicules")
    EndTextCommandSetBlipName(blip)
 
end)