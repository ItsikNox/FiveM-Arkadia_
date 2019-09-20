-- Local
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

local CurrentAction = nil
local GUI                       = {}
GUI.Time                        = 0
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local times 					= 0
local this_Garage = {}

-- End Local
-- Initialise ESX

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- End ESX Initialisation
--- Generate map blips

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    --PlayerData = xPlayer
		--TriggerServerEvent('esx_jobs:giveBackCautionInCaseOfDrop')
    refreshBlips()
end)

function refreshBlips()
	local zones = {}
	local blipInfo = {}	

	for zoneKey,zoneValues in pairs(Config.BoatGarages)do

		if not zoneValues.Private then
			local blip = AddBlipForCoord(zoneValues.Pos.x, zoneValues.Pos.y, zoneValues.Pos.z)
			SetBlipSprite (blip, Config.BlipInfos.Sprite)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 1.0)
			SetBlipColour (blip, Config.BlipInfos.Color)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('public_garage'))
			EndTextCommandSetBlipName(blip)
		end
		
		if zoneValues.MunicipalPoundPoint then
			local blip = AddBlipForCoord(zoneValues.MunicipalPoundPoint.Pos.x, zoneValues.MunicipalPoundPoint.Pos.y, zoneValues.MunicipalPoundPoint.Pos.z)
			SetBlipSprite (blip, Config.BlipPound.Sprite)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 1.0)
			SetBlipColour (blip, Config.BlipPound.Color)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U("municipal_pound"))
			EndTextCommandSetBlipName(blip)
		end
	end
end

-- End map blip generation
-- Main menu

function OpenMenuGarage(PointType)

	ESX.UI.Menu.CloseAll()

	local elements = {}

	if PointType == 'spawn' then
		table.insert(elements,{label = _U('list_vehicles'), value = 'list_vehicles'})
	end

	if PointType == 'delete' then
		table.insert(elements,{label = _U('stock_vehicle'), value = 'stock_vehicle'})
	end

	if PointType == 'pound' then
		table.insert(elements,{label = _U('return_vehicle').." ("..Config.Price.."$)", value = 'return_vehicle'})
	end

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'garage_menu',
		{
			title    = _U('garage'),
			align    = 'top-left',
			elements = elements,
		},
		function(data, menu)

			menu.close()
			if(data.current.value == 'list_vehicles') then
				ListVehiclesMenu()
			end
			if(data.current.value == 'stock_vehicle') then
				StockVehicleMenu()
			end
			if(data.current.value == 'return_vehicle') then
				ReturnVehicleMenu()
			end

			local playerPed = GetPlayerPed(-1)
			SpawnVehicle(data.current.value)

		end,
		function(data, menu)
			menu.close()
			
		end
	)	
end
	
-- Vehicle list

function ListVehiclesMenu()
	local elements = {}

	ESX.TriggerServerCallback('eden_boatgarage:getVehicles', function(vehicles)

		for _,v in pairs(vehicles) do

			local hashVehicule = v.vehicle.model
    		local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
    		local labelvehicle
			local plate = v.plate

    		if(v.state)then
    		labelvehicle = vehicleName.. ' (' .. plate .. ') ' .._U('garage')
    		else
    		labelvehicle = vehicleName.. ' (' .. plate .. ') ' .._U('municipal_pound')
    		end	
			table.insert(elements, {label =labelvehicle , value = v})
			
		end
		local c = 0
		for _,a in pairs(vehicles) do
			if (a.state) then
				c = c + 1
			else
				c = c - 1
			end
		end

	
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'spawn_vehicle',
		{
			title    = _U('garage'),
			align    = 'top-left',
			elements = elements,
		},
		function(data, menu)
			if(data.current.value.state)then
				menu.close()
				if c > 0 then
					SpawnVehicle(data.current.value.vehicle, data.current.value.plate)
				else
					TriggerEvent('esx:showNotification', _U('vehicle_is_impounded'))
				end
			else
				TriggerEvent('esx:showNotification', _U('vehicle_is_impounded'))
			end
		end,
		function(data, menu)
			menu.close()
			--CurrentAction = 'open_garage_action'
		end
	)	
	end)
end

-- End vehicle list

function reparation(prix,vehicle,vehicleProps)
	
	ESX.UI.Menu.CloseAll()

	local elements = {
		{label = _U('return_vehicle').." ("..prix.."$)", value = 'yes'},
		{label = _U('see_mechanic'), value = 'no'},
	}
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'delete_menu',
		{
			title    = _U('damaged_vehicle'),
			align    = 'top-left',
			elements = elements,
		},
		function(data, menu)

			menu.close()
			if(data.current.value == 'yes') then
				TriggerServerEvent('eden_boatgarage:payhealth', prix)
				ranger(vehicle,vehicleProps)
			end
			if(data.current.value == 'no') then
				ESX.ShowNotification(_U('visit_mechanic'))
			end

		end,
		function(data, menu)
			menu.close()
			
		end
	)	
end

function ranger(vehicle,vehicleProps)
	ESX.Game.DeleteVehicle(vehicle)
	TriggerServerEvent('eden_boatgarage:modifystate', vehicleProps.plate, true)
	TriggerEvent('esx:showNotification', _U('vehicle_in_garage'))
end

-- Store vehicle

function StockVehicleMenu()
	local playerPed  = GetPlayerPed(-1)
	if IsPedInAnyVehicle(playerPed,  false) then

		local playerPed = GetPlayerPed(-1)
    	local coords    = GetEntityCoords(playerPed)
    	local vehicle = GetVehiclePedIsIn(playerPed,false)     
		local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
		local current 	    = GetPlayersLastVehicle(GetPlayerPed(-1), true)
		local engineHealth  = GetVehicleEngineHealth(current)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('eden_boatgarage:stockv',function(valid)

			if (valid) then
				TriggerServerEvent('eden_boatgarage:debug', vehicle)
				if engineHealth < 990 then
					local fraisRep= math.floor((1000 - engineHealth)/1000*Config.Price*Config.DamageMultiplier)
					reparation(fraisRep,vehicle,vehicleProps)
				else
					ranger(vehicle,vehicleProps)
				end	
			else
				TriggerEvent('esx:showNotification', _U('cannot_store_vehicle'))
			end
		end,vehicleProps)
	else
		TriggerEvent('esx:showNotification', _('no_vehicle_to_enter'))
	end

end

-- End story vehicle
--End main menu
--Vehicle spawn

function SpawnVehicle(vehicle, plate)

	ESX.Game.SpawnVehicle(vehicle.model,{
		x=this_Garage.SpawnPoint.Pos.x ,
		y=this_Garage.SpawnPoint.Pos.y,
		z=this_Garage.SpawnPoint.Pos.z + 1											
		},this_Garage.SpawnPoint.Heading, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
		end)
		

	TriggerServerEvent('eden_boatgarage:modifystate', plate, false)

end

--End vehicle spawn
--Spawn impounded vehicle

function SpawnPoundedVehicle(vehicle, plate)

	ESX.Game.SpawnVehicle(vehicle.model, {
		x = this_Garage.SpawnMunicipalPoundPoint.Pos.x ,
		y = this_Garage.SpawnMunicipalPoundPoint.Pos.y,
		z = this_Garage.SpawnMunicipalPoundPoint.Pos.z + 1											
		},this_Garage.SpawnMunicipalPoundPoint.Heading, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
		end)
	TriggerServerEvent('eden_boatgarage:modifystate', plate, true)

	ESX.SetTimeout(10000, function()
		TriggerServerEvent('eden_boatgarage:modifystate', plate, false)
	end)

end

--End spawn impounded vehicle
--Marker action notifications

AddEventHandler('eden_boatgarage:hasEnteredMarker', function(zone)

	if zone == 'spawn' then
		CurrentAction     = 'spawn'
		CurrentActionMsg  = _U('press_to_enter')
		CurrentActionData = {}
	end

	if zone == 'delete' then
		CurrentAction     = 'delete'
		CurrentActionMsg  = _U('press_to_delete')
		CurrentActionData = {}
	end
	
	if zone == 'pound' then
		CurrentAction     = 'pound_action_menu'
		CurrentActionMsg  = _U('press_to_impound')
		CurrentActionData = {}
	end
end)

AddEventHandler('eden_boatgarage:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

--End marker action notifications

function ReturnVehicleMenu()

	ESX.TriggerServerCallback('eden_boatgarage:getOutVehicles', function(vehicles)

		local elements = {}

		for _,v in pairs(vehicles) do

			local hashVehicule = v.model
    		local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
    		local labelvehicle

    		labelvehicle = vehicleName..': '.._U('return')
    	
			table.insert(elements, {label =labelvehicle , value = v})
			
		end

		ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'return_vehicle',
		{
			title    = _U('garage'),
			align    = 'top-left',
			elements = elements,
		},
		function(data, menu)
	
			ESX.TriggerServerCallback('eden_boatgarage:checkMoney', function(hasEnoughMoney)
				if hasEnoughMoney then
					
					if times == 0 then
						TriggerServerEvent('eden_boatgarage:pay')
						SpawnPoundedVehicle(data.current.value, data.current.value.plate)
						times=times+1
					elseif times > 0 then
						ESX.SetTimeout(60000, function()
						times=0
						end)
					end
				else
					ESX.ShowNotification(_U('not_enough_money'))						
				end
			end)
		end,
		function(data, menu)
			menu.close()
			--CurrentAction = 'open_garage_action'
		end
		)	
	end)
end

-- Marker display

Citizen.CreateThread(function()
	while true do
		Wait(0)		
		local coords = GetEntityCoords(GetPlayerPed(-1))			

		for k,v in pairs(Config.BoatGarages) do
			if not v.Private or has_value(userProperties, v.Private) then
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then		
					DrawMarker(v.SpawnPoint.Marker, v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.SpawnPoint.Size.x, v.SpawnPoint.Size.y, v.SpawnPoint.Size.z, v.SpawnPoint.Color.r, v.SpawnPoint.Color.g, v.SpawnPoint.Color.b, 100, false, true, 2, false, false, false, false)	
					DrawMarker(v.DeletePoint.Marker, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.DeletePoint.Size.x, v.DeletePoint.Size.y, v.DeletePoint.Size.z, v.DeletePoint.Color.r, v.DeletePoint.Color.g, v.DeletePoint.Color.b, 100, false, true, 2, false, false, false, false)	
				end
				if(v.MunicipalPoundPoint and GetDistanceBetweenCoords(coords, v.MunicipalPoundPoint.Pos.x, v.MunicipalPoundPoint.Pos.y, v.MunicipalPoundPoint.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(v.MunicipalPoundPoint.Marker, v.MunicipalPoundPoint.Pos.x, v.MunicipalPoundPoint.Pos.y, v.MunicipalPoundPoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.MunicipalPoundPoint.Size.x, v.MunicipalPoundPoint.Size.y, v.MunicipalPoundPoint.Size.z, v.MunicipalPoundPoint.Color.r, v.MunicipalPoundPoint.Color.g, v.MunicipalPoundPoint.Color.b, 100, false, true, 2, false, false, false, false)	
					DrawMarker(v.SpawnMunicipalPoundPoint.Marker, v.SpawnMunicipalPoundPoint.Pos.x, v.SpawnMunicipalPoundPoint.Pos.y, v.SpawnMunicipalPoundPoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.SpawnMunicipalPoundPoint.Size.x, v.SpawnMunicipalPoundPoint.Size.y, v.SpawnMunicipalPoundPoint.Size.z, v.SpawnMunicipalPoundPoint.Color.r, v.SpawnMunicipalPoundPoint.Color.g, v.SpawnMunicipalPoundPoint.Color.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end	
	end
end)

-- End marker display
-- Activate menu when in

Citizen.CreateThread(function()
	local currentZone = 'garage'
	while true do

		Wait(0)

		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false

		for _,v in pairs(Config.BoatGarages) do
			if not v.Private or has_value(userProperties, v.Private) then
				if(GetDistanceBetweenCoords(coords, v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					this_Garage = v
					currentZone = 'spawn'
				end

				if(GetDistanceBetweenCoords(coords, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					this_Garage = v
					currentZone = 'delete'
				end
				if(v.MunicipalPoundPoint and GetDistanceBetweenCoords(coords, v.MunicipalPoundPoint.Pos.x, v.MunicipalPoundPoint.Pos.y, v.MunicipalPoundPoint.Pos.z, true) < v.MunicipalPoundPoint.Size.x) then
					isInMarker  = true
					this_Garage = v
					currentZone = 'pound'
				end
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('eden_boatgarage:hasEnteredMarker', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('eden_boatgarage:hasExitedMarker', LastZone)
		end

	end
end)

-- End Activate menu when in
-- Controls/Keybinds

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		if CurrentAction ~= nil then

			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlPressed(0,  Keys['E']) and (GetGameTimer() - GUI.Time) > 150 then

				if CurrentAction == 'pound_action_menu' then
					OpenMenuGarage('pound')
				end
				if CurrentAction == 'spawn' then
					OpenMenuGarage('spawn')
				end
				if CurrentAction == 'delete' then
					OpenMenuGarage('delete')
				end


				CurrentAction = nil
				GUI.Time      = GetGameTimer()

			end
		end
	end
end)

-- End Controls/Keybinds