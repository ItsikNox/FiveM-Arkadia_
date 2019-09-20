ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('esx_tenues:settenuecasa')
AddEventHandler('esx_tenues:settenuecasa', function()
	if UseTenu then

		TriggerEvent('skinchanger:getSkin', function(skin)

    		if skin.sex == 0 then
        		local clothesSkin = {
					['tshirt_1']  = 15, ['tshirt_2']  = 0,
					['torso_1']   = 65, ['torso_2']   = 0,
					['decals_1']  = 0,  ['decals_2']  = 0,
					['mask_1']    = 50, ['mask_2']    = 6,
					['arms']      = 17,
					['pants_1']   = 38, ['pants_2']   = 0,
					['shoes_1']   = 54, ['shoes_2']   = 0,
					['helmet_1']  = -1, ['helmet_2']  = 0,
					['bags_1']    = 44, ['bags_2']    = 0,
					['bproof_1']  = 0,  ['bproof_2']  = 0
        		}
        		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    		else
        		local clothesSkin = {
					['tshirt_1']  = 14, ['tshirt_2']  = 0,
					['torso_1']   = 59, ['torso_2']   = 0,
					['decals_1']  = 0,  ['decals_2']  = 0,
					['mask_1']    = 50, ['mask_2']    = 6,
					['arms']      = 18,
					['pants_1']   = 38, ['pants_2']   = 0,
					['shoes_1']   = 55, ['shoes_2']   = 0,
					['helmet_1']  = -1, ['helmet_2']  = 0,
					['bags_1']    = 44, ['bags_2']  = 0,
					['bproof_1']  = 0,  ['bproof_2']  = 0
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