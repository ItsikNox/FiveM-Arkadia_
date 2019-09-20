ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('esx_tenues:settenueprison')
AddEventHandler('esx_tenues:settenueprison', function()
	if UseTenu then

		TriggerEvent('skinchanger:getSkin', function(skin)

    		if skin.sex == 0 then
        		local clothesSkin = {
            		['tshirt_1'] = 15, ['tshirt_2'] = 0,
			          ['ears_1'] = -1, ['ears_2'] = 0,
            		['torso_1'] = 17, ['torso_2'] = 2,
            		['decals_1'] = 0,  ['decals_2']= 0,
            		['arms'] = 5,
            		['pants_1'] = 5, ['pants_2'] = 7,
            		['shoes_1'] = 8, ['shoes_2'] = 8,
            		['helmet_1'] 	= -1, ['helmet_2'] = 0,
            		['bags_1'] = 0, ['bags_2'] = 0,
			          ['glasses_1'] = 0, ['glasses_2'] = 0,
			          ['chain_1'] = 0, ['chain_2'] = 0,
            		['bproof_1'] = 0,  ['bproof_2'] = 0
        		}
        		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    		else
        		local clothesSkin = {
            		['tshirt_1'] = 15, ['tshirt_2'] = 0,
			          ['ears_1'] = -1, ['ears_2'] = 0,
            		['torso_1'] = 17, ['torso_2'] = 2,
            		['decals_1'] = 0,  ['decals_2']= 0,
            		['arms'] = 5,
            		['pants_1'] = 5, ['pants_2'] = 7,
            		['shoes_1'] = 8, ['shoes_2'] = 8,
            		['helmet_1'] 	= -1, ['helmet_2'] = 0,
            		['bags_1'] = 0, ['bags_2'] = 0,
			          ['glasses_1'] = 0, ['glasses_2'] = 0,
			          ['chain_1'] = 0, ['chain_2'] = 0,
            		['bproof_1'] = 0,  ['bproof_2'] = 0
        		}
        		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        	end
        	local playerPed = GetPlayerPed(-1)
    	end)
	else

		TriggerEvent('skinchanger:getSkin', function(skin)

			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, hasSkin)

				if hasSkin then

					TriggerEvent('skinchanger:loadSkin', skin)
					TriggerEvent('esx:restoreLoadout')
				end
			end)
		end)
	end

	UseTenu  = not UseTenu
	GUI.Time = GetGameTimer()

end)

---------------------------------
--- Copyright by ikNox#6088 ---
---------------------------------