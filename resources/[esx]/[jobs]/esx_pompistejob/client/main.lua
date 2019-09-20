-----------------------------------------
-- Created and modify by L'ile Légale RP
-- SenSi and Kaminosekai
-----------------------------------------


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

local PlayerData                = {}
local GUI                       = {}
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local JobBlips                = {}
local publicBlip = false
ESX                             = nil
GUI.Time                        = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function TeleportFadeEffect(entity, coords)

	Citizen.CreateThread(function()

		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end

		ESX.Game.Teleport(entity, coords, function()
			DoScreenFadeIn(800)
		end)

	end)
end

function OpenCloakroomMenu()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'cloakroom',
		{
			title    = _U('cloakroom'),
			align    = 'left',
			css    = 'vestiaire',
			elements = {
				{label = _U('civil_clothes'), value = 'citizen_wear'},
				{label = _U('fueler_clothes'), value = 'fueler_wear'},
			},
		},
		function(data, menu)

			menu.close()

			if data.current.value == 'citizen_wear' then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end

			if data.current.value == 'fueler_wear' then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
					else
						TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
					end
				end)
			end

			CurrentAction     = 'fueler_actions_menu'
			CurrentActionMsg  = _U('open_menu')
			CurrentActionData = {}
		end,
		function(data, menu)
			menu.close()
		end
	)

end

function OpenFuelerActionsMenu()

	local elements = {
        {label = _U('cloakroom'), value = 'cloakroom'},
		{label = _U('deposit_stock'), value = 'put_stock'}
	}

	if Config.EnablePlayerManagement and PlayerData.job ~= nil and (PlayerData.job.grade_name ~= 'recrue' and PlayerData.job.grade_name ~= 'novice')then -- Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.grade_name == 'boss'
		table.insert(elements, {label = _U('take_stock'), value = 'get_stock'})
	end
  
	if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.grade_name == 'boss' then -- Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.grade_name == 'boss'
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'fueler_actions',
		{
			title    = 'Pompiste',
			align    = 'left',
			css    = 'pompiste',
			elements = elements
		},
		
		function(data, menu)
			if data.current.value == 'cloakroom' then
				OpenCloakroomMenu()
			end

			if data.current.value == 'put_stock' then
				OpenPutStocksMenu()
			end

			if data.current.value == 'get_stock' then
				OpenGetStocksMenu()
			end

			if data.current.value == 'boss_actions' then
				TriggerEvent('esx_society:openBossMenu', 'pompiste', function(data, menu)
					menu.close()
				end, {wash = false})
			end

		end,
		function(data, menu)

			menu.close()

			CurrentAction     = 'fueler_actions_menu'
			CurrentActionMsg  = _U('press_to_open')
			CurrentActionData = {}

		end
	)
end

function OpenVehicleSpawnerMenu()

	ESX.UI.Menu.CloseAll()

	if Config.EnableSocietyOwnedVehicles then

		local elements = {}

		ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)

			for i=1, #vehicles, 1 do
				table.insert(elements, {label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']', value = vehicles[i]})
			end

			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'vehicle_spawner',
				{
					title    = _U('veh_menu'),
					align    = 'left',
					css    = 'pompiste',
					elements = elements,
				},
				function(data, menu)

					menu.close()

					local vehicleProps = data.current.value

					ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint.Pos, 90.0, function(vehicle)
						ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
						local playerPed = GetPlayerPed(-1)
						local plate = 'WORK' .. math.random(100, 900)
						TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
						TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
						SetVehicleNumberPlateText(vehicle, plate)
						table.insert(myPlate, plate)
						plate = string.gsub(plate, " ", "")
					end)

					TriggerServerEvent('esx_society:removeVehicleFromGarage', 'pompiste', vehicleProps)

				end,
				function(data, menu)

					menu.close()

					CurrentAction     = 'vehicle_spawner_menu'
					CurrentActionMsg  = _U('spawn_veh')
					CurrentActionData = {}

				end
			)

		end, 'pompiste')

	else
	
		local elements = {
			{label = 'Voiture Patron',  value = 'Windsor2'},
			{label = 'Vehicule de Travail',  value = 'Rumpo3'},
		}
		
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'vehicle_spawner',
			{
				title    = _U('veh_menu'),
				align    = 'left',
				css    = 'pompiste',
				elements = elements,
			},
			function(data, menu)

				menu.close()

				local model = data.current.value
		
				ESX.Game.SpawnVehicle(model, Config.Zones.VehicleSpawnPoint.Pos, 56.326, function(vehicle)
					local playerPed = GetPlayerPed(-1)
					local plate = 'WORK' .. math.random(100, 900)
					TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
					TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
						SetVehicleNumberPlateText(vehicle, plate)
						table.insert(myPlate, plate)
						plate = string.gsub(plate, " ", "")
				end)
			end,
			function(data, menu)

				menu.close()

				CurrentAction     = 'vehicle_spawner_menu'
				CurrentActionMsg  = _U('spawn_veh')
				CurrentActionData = {}

			end
		)
	end
end

function OpenMobileFuelerActionsMenu()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'mobile_fueler_actions',
		{
			title    = 'pompiste',
			align    = 'left',
			css    = 'metier',
			elements = {
				{label = _U('billing'), value = 'billing'}
			}
		},
		function(data, menu)

			if data.current.value == 'billing' then

				ESX.UI.Menu.Open(
					'dialog', GetCurrentResourceName(), 'billing',
					{
						title = _U('invoice_amount')
					},
					function(data, menu)

						local amount = tonumber(data.value)

						if amount == nil or amount <= 0 then
							ESX.ShowNotification(_U('amount_invalid'))
						else
							menu.close()

							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

							if closestPlayer == -1 or closestDistance > 3.0 then
								ESX.ShowNotification(_U('no_players_near'))
							else
								local playerPed        = GetPlayerPed(-1)

								Citizen.CreateThread(function()
									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
									Citizen.Wait(5000)
									ClearPedTasks(playerPed)
									TriggerServerEvent('esx_billing:sendBill1', GetPlayerServerId(closestPlayer), 'society_pompiste', 'Pompiste', amount)
								end)
							end
						end
					end,
					function(data, menu)
						menu.close()
					end
				)
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function OpenGetStocksMenu()

	ESX.TriggerServerCallback('esx_pompistejob:getStockItems', function(items)

		print(json.encode(items))

		local elements = {}

		for i=1, #items, 1 do
			if (items[i].count ~= 0) then
				table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
			end
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'stocks_menu',
			{
				title    = 'pompiste Stock',
				align    = 'left',
				css    = 'pompiste',
				elements = elements
			},
			function(data, menu)

				local itemName = data.current.value

				ESX.UI.Menu.Open(
					'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
					{
						title = _U('quantity')
					},
					function(data2, menu2)
		
						local count = tonumber(data2.value)

						if count == nil or count <= 0 then
							ESX.ShowNotification(_U('quantity_invalid'))
						else
							menu2.close()
							menu.close()
							OpenGetStocksMenu()

							TriggerServerEvent('esx_pompistejob:getStockItem', itemName, count)
						end

					end,
					function(data2, menu2)
						menu2.close()
					end
				)

			end,
			function(data, menu)
				menu.close()
			end
		)
	end)
end

function OpenPutStocksMenu()

	ESX.TriggerServerCallback('esx_pompistejob:getPlayerInventory', function(inventory)

		local elements = {}

		for i=1, #inventory.items, 1 do

			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
			end

		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'stocks_menu',
			{
				title    = _U('inventory'),
				elements = elements
			},
			function(data, menu)

				local itemName = data.current.value

				ESX.UI.Menu.Open(
					'dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count',
					{
						title = _U('quantity')
					},
					function(data2, menu2)

						local count = tonumber(data2.value)

						if count == nil or count <= 0 then
							ESX.ShowNotification(_U('quantity_invalid'))
						else
							menu2.close()
							menu.close()
							OpenPutStocksMenu()

							TriggerServerEvent('esx_pompistejob:putStockItems', itemName, count)
						end

					end,
					function(data2, menu2)
						menu2.close()
					end
				)

			end,
			function(data, menu)
				menu.close()
			end
		)

	end)

end


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	blips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	deleteBlips()
	blips()
end)

AddEventHandler('esx_pompistejob:hasEnteredMarker', function(zone)
	if zone == 'PetrolFarm' and PlayerData.job ~= nil and PlayerData.job.name == 'pompiste'  then
		CurrentAction     = 'raisin_harvest'
		CurrentActionMsg  = _U('press_collect')
		CurrentActionData = {zone= zone}
	end
		
	-- if zone == 'TraitementRaffin' and PlayerData.job ~= nil and PlayerData.job.name == 'fueler'  then
		-- CurrentAction     = 'vine_traitement'
		-- CurrentActionMsg  = _U('press_traitement_raffine')
		-- CurrentActionData = {zone= zone}
	-- end		
		
	if zone == 'TraitementPetrol' and PlayerData.job ~= nil and PlayerData.job.name == 'pompiste'  then
		CurrentAction     = 'jus_traitement'
		CurrentActionMsg  = _U('press_traitement')
		CurrentActionData = {zone = zone}
	end
		
	if zone == 'SellFarm' and PlayerData.job ~= nil and PlayerData.job.name == 'pompiste'  then
		CurrentAction     = 'farm_resell'
		CurrentActionMsg  = _U('press_sell')
		CurrentActionData = {zone = zone}
	end

	if zone == 'FuelerActions' and PlayerData.job ~= nil and PlayerData.job.name == 'pompiste' then
		CurrentAction     = 'fueler_actions_menu'
		CurrentActionMsg  = _U('press_to_open')
		CurrentActionData = {}
	end
  
	if zone == 'VehicleSpawner' and PlayerData.job ~= nil and PlayerData.job.name == 'pompiste' then
		CurrentAction     = 'vehicle_spawner_menu'
		CurrentActionMsg  = _U('spawn_veh')
		CurrentActionData = {}
	end
		
	if zone == 'VehicleDeleter' and PlayerData.job ~= nil and PlayerData.job.name == 'pompiste' then

		local playerPed = GetPlayerPed(-1)
		local coords    = GetEntityCoords(playerPed)
		
		if IsPedInAnyVehicle(playerPed,  false) then

			local vehicle, distance = ESX.Game.GetClosestVehicle({
				x = coords.x,
				y = coords.y,
				z = coords.z
			})

			if distance ~= -1 and distance <= 1.0 then

				CurrentAction     = 'delete_vehicle'
				CurrentActionMsg  = _U('store_veh')
				CurrentActionData = {vehicle = vehicle}

			end
		end
	end
end)

AddEventHandler('esx_pompistejob:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	if (zone == 'PetrolFarm') and PlayerData.job ~= nil and PlayerData.job.name == 'pompiste' then
		TriggerServerEvent('esx_pompistejob:stopHarvest')
	end  
	-- if (zone == 'TraitementRaffin' or zone == 'TraitementPetrol') and PlayerData.job ~= nil and PlayerData.job.name == 'fueler' then
		-- TriggerServerEvent('esx_imprimeriejob:stopTransform')
	-- end
	if (zone == 'SellFarm') and PlayerData.job ~= nil and PlayerData.job.name == 'pompiste' then
		TriggerServerEvent('esx_pompistejob:stopSell')
	end
	CurrentAction = nil
end)


RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)

	local specialContact = {
		name       = 'pompiste',
		number     = 'pompiste',
		base64Icon = 'data:image/png;base64,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`ypu�    pu�                    ��            ���    �u�            �u�     @      �u�            Ph�            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',
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)

end)

function deleteBlips()
	if JobBlips[1] ~= nil then
		for i=1, #JobBlips, 1 do
		RemoveBlip(JobBlips[i])
		JobBlips[i] = nil
		end
	end
end

-- Create Blips
function blips()
	if publicBlip == false then
		local blip = AddBlipForCoord(Config.Zones.FuelerActions.Pos.x, Config.Zones.FuelerActions.Pos.y, Config.Zones.FuelerActions.Pos.z)
		SetBlipSprite (blip, 436)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.2)
		SetBlipColour (blip, 51)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("~o~Entreprise de Pompiste")
		EndTextCommandSetBlipName(blip)
		publicBlip = true
	end
	
    if PlayerData.job ~= nil and PlayerData.job.name == 'pompiste' then

		for k,v in pairs(Config.Zones)do
			if v.Type == 1 or v.Type == 29 then
				local blip2 = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)

				SetBlipSprite (blip, 440)
				SetBlipDisplay(blip, 4)
				SetBlipScale  (blip, 1.2)
				SetBlipColour (blip, 25)
				SetBlipAsShortRange(blip2, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(v.Name)
				EndTextCommandSetBlipName(blip2)
				table.insert(JobBlips, blip2)
			end
		end
	end
end


-- Display markers
Citizen.CreateThread(function()
	while true do
		Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))

		for k,v in pairs(Config.Zones) do
			if PlayerData.job ~= nil and PlayerData.job.name == 'pompiste' then
				if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end
	end
end)


-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do

		Wait(0)

		if PlayerData.job ~= nil and PlayerData.job.name == 'pompiste' then

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
				TriggerEvent('esx_pompistejob:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_pompistejob:hasExitedMarker', LastZone)
			end
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		if CurrentAction ~= nil then

			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlPressed(0,  Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'pompiste' and (GetGameTimer() - GUI.Time) > 300 then
				if CurrentAction == 'raisin_harvest' then
					TriggerServerEvent('esx_pompistejob:startHarvest', CurrentActionData.zone)
				end
				if CurrentAction == 'jus_traitement' then
					TriggerServerEvent('esx_pompistejob:startTransform', CurrentActionData.zone)
				end
				if CurrentAction == 'vine_traitement' then
					TriggerServerEvent('esx_pompistejob:startTransform', CurrentActionData.zone)
				end
				if CurrentAction == 'farm_resell' then
					TriggerServerEvent('esx_pompistejob:startSell', CurrentActionData.zone)
				end
				
				if CurrentAction == 'fueler_actions_menu' then
					OpenFuelerActionsMenu()
				end
				if CurrentAction == 'vehicle_spawner_menu' then
					OpenVehicleSpawnerMenu()
				end
				if CurrentAction == 'delete_vehicle' then

					if Config.EnableSocietyOwnedVehicles then
						local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
						TriggerServerEvent('esx_society:putVehicleInGarage', 'pompiste', vehicleProps)
					end

					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				end

				CurrentAction = nil
				GUI.Time      = GetGameTimer()

			end
		end

		if IsControlPressed(0,  Keys['F6']) and Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.name == 'pompiste' and (GetGameTimer() - GUI.Time) > 150 then
			OpenMobileFuelerActionsMenu()
			GUI.Time = GetGameTimer()
		end
	end
end)

---------------------------------
--------- ikNox#6088 ------------
---------------------------------