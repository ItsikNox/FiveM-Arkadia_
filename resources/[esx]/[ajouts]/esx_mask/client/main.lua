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

ESX                           = nil
local GUI                     = {}
GUI.Time                      = 0
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local UseMask                 = false

Citizen.CreateThread(function()

	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

end)

function OpenShopMenu()

	TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)

		menu.close()

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'shop_confirm',
			{
				css	= 'valider',
				title = _U('valid_purchase'),
				align    = 'left',
				elements = {
					{label = _U('yes'), value = 'yes'},
					{label = _U('no'), value = 'no'},
				}
			},
			function(data, menu)

				menu.close()

				if data.current.value == 'yes' then

					ESX.TriggerServerCallback('esx_mask:checkMoney', function(hasEnoughMoney)

						if hasEnoughMoney then
							
							TriggerServerEvent('esx_mask:pay')

							TriggerEvent('skinchanger:getSkin', function(skin)
								TriggerServerEvent('esx_mask:saveMask', skin)
							end)

						else

							TriggerEvent('esx_skin:getLastSkin', function(skin)
								TriggerEvent('skinchanger:loadSkin', skin)
							end)

							-- ESX.ShowNotification(_U('not_enough_money'))
							ESX.ShowAdvancedColoredNotification(('Magasin'), ('de masques'), _U('not_enough_money'), 'CHAR_BANK_MAZE', 1, 2)
						
						end

					end)

				end

				if data.current.value == 'no' then

					TriggerEvent('esx_skin:getLastSkin', function(skin)
						TriggerEvent('skinchanger:loadSkin', skin)
					end)

				end

				CurrentAction     = 'shop_menu'
				CurrentActionMsg  = _U('press_access')
				CurrentActionData = {}

			end,
			function(data, menu)

				menu.close()

				CurrentAction     = 'shop_menu'
				CurrentActionMsg  = _U('press_access')
				CurrentActionData = {}

			end
		)

	end, function(data, menu)

			menu.close()

			CurrentAction     = 'shop_menu'
			CurrentActionMsg  = _U('press_access')
			CurrentActionData = {}

	end, {
		'mask_1',
		'mask_2',
	})

end

AddEventHandler('esx_mask:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = _U('press_access')
	CurrentActionData = {}
end)

AddEventHandler('esx_mask:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- Create Blips
Citizen.CreateThread(function()
	
	for i=1, #Config.Shops, 1 do
		
		local blip = AddBlipForCoord(Config.Shops[i].x, Config.Shops[i].y, Config.Shops[i].z)

		SetBlipSprite (blip, 362)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.0)
		SetBlipColour (blip, 2)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("~g~Magasin de Masques")
		EndTextCommandSetBlipName(blip)
	end

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
			TriggerEvent('esx_mask:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_mask:hasExitedMarker', LastZone)
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

			if IsControlPressed(0,  Keys['E']) and (GetGameTimer() - GUI.Time) > 300 then
				
				if CurrentAction == 'shop_menu' then
					OpenShopMenu()
				end

				CurrentAction = nil
				GUI.Time      = GetGameTimer()
				
			end

		end

		if IsControlPressed(0,  Keys['LEFTSHIFT']) and IsControlPressed(0,  Keys['M']) and (GetGameTimer() - GUI.Time) > 300 then
			
			if UseMask then

				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)

					TriggerEvent('skinchanger:loadClothes', skin, {
						mask_1 = 0,
						mask_2 = 0
					})

				end)

			else

				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(playerSkin)

					ESX.TriggerServerCallback('esx_mask:getMask', function(hasMask, skin)

						if hasMask then

							TriggerEvent('skinchanger:loadClothes', playerSkin, {
								mask_1 = skin.mask_1,
								mask_2 = skin.mask_2
							})
						
						else
							-- ESX.ShowNotification(_U('no_mask'))
							ESX.ShowAdvancedColoredNotification(('Magasin'), ('de masques'), _U('no_mask'), 'CHAR_DEFAULT', 1, 2)
						end

					end)

				end)

			end

			UseMask  = not UseMask
			GUI.Time = GetGameTimer()
			
		end

	end
end)

---------------------------------
--------- ikNox#6088 ------------
---------------------------------