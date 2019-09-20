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

local HasAlreadyEnteredMarker = false
local LastPad                 = nil
local LastAction              = nil
local LastPadData             = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = nil
local ClickedInsideMarker     = false

ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_teleportpads:hasEnteredMarker')
AddEventHandler('esx_teleportpads:hasEnteredMarker', function(currentPad, padData)
	CurrentAction = 'pad.' .. string.lower(currentPad)
	CurrentActionMsg = padData.Text
	CurrentActionData = { padData = padData }
end)

RegisterNetEvent('esx_teleportpads:hasExitedMarker')
AddEventHandler('esx_teleportpads:hasExitedMarker', function()
	ESX.UI.Menu.CloseAll()
	
	CurrentAction = nil
	ClickedInsideMarker = false
end)

-- Draw marker
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		for pad, padData in pairs(Config.Pads) do
			if GetDistanceBetweenCoords(coords, padData.Marker.x, padData.Marker.y, padData.Marker.z,  true) < Config.DrawDistance then
				DrawMarker(Config.Marker.Type, padData.Marker.x, padData.Marker.y, padData.Marker.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, 100, false, true, 2, false, false, false, false)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		local playerPed      = PlayerPedId()
		local coords         = GetEntityCoords(playerPed)
		local isInMarker, currentPad, currentAction, currentPadData = false, nil, nil, nil

		for pad,padData in pairs(Config.Pads) do
			if GetDistanceBetweenCoords(coords, padData.Marker.x, padData.Marker.y, padData.Marker.z, true) < (Config.Marker.x * 1.5) then
				isInMarker, currentPad, currentAction, currentPadData = true, pad, 'pad.' .. string.lower(pad), padData
			end
		end

		local hasExited = false

		if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastPad ~= currentPad or LastAction ~= currentAction)) then
			if (LastPad ~= nil and LastAction ~= nil) and (LastPad ~= currentPad or LastAction ~= currentAction) then
				TriggerEvent('esx_teleportpads:hasExitedMarker', LastPad, LastAction)
				
				hasExited = true
			end

			HasAlreadyEnteredMarker = true
			LastPad, LastAction, LastPadData = currentPad, currentAction, currentPadData

			TriggerEvent('esx_teleportpads:hasEnteredMarker', currentPad, currentPadData)
		end

		if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false

			TriggerEvent('esx_teleportpads:hasExitedMarker', LastPad, LastAction)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if CurrentAction ~= nil then

			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) then
				if ClickedInsideMarker == false then
					ClickedInsideMarker = true

					ESX.Game.Teleport(PlayerPedId(), CurrentActionData.padData.TeleportPoint, function()
						SetEntityHeading(PlayerPedId(), CurrentActionData.padData.TeleportPoint.h)
					end)
				end
			end
		else
			Citizen.Wait(500)
		end
	end
end)