--DO-NOT-EDIT-BELLOW-THIS-LINE--

Key = 201 -- ENTER

vehicleWashStation = {
	{26.5906,  -1392.0261,  27.3634},
	{167.1034,  -1719.4704,  27.2916},
	{-74.5693,  6427.8715,  29.4400},
	{-699.6325,  -932.7043,  17.0139},
	{1362.5385, 3592.1274, 33.9211}
}


Citizen.CreateThread(function ()
	Citizen.Wait(0)
	for i = 1, #vehicleWashStation do
		garageCoords = vehicleWashStation[i]
		stationBlip = AddBlipForCoord(garageCoords[1], garageCoords[2], garageCoords[3])
		SetBlipSprite(stationBlip, 100) -- 100 = carwash
		SetBlipAsShortRange(stationBlip, true)
	end
    return
end)

function es_carwash_DrawSubtitleTimed(m_text, showtime)
	SetTextEntry_2('STRING')
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

function es_carwash_DrawNotification(m_text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(m_text)
	DrawNotification(true, false)
end

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 
			for i = 1, #vehicleWashStation do
				garageCoords2 = vehicleWashStation[i]
				DrawMarker(1, garageCoords2[1], garageCoords2[2], garageCoords2[3], 0, 0, 0, 0, 0, 0, 5.0, 5.0, 2.0, 0, 157, 0, 155, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), garageCoords2[1], garageCoords2[2], garageCoords2[3], true ) < 5 then
					es_carwash_DrawSubtitleTimed("Appuyez sur [~g~ENTER~s~] pour laver votre véhicule !")
					if IsControlJustPressed(1, Key) then
						TriggerServerEvent('es_carwash:checkmoney')
					end
				end
			end
		end
	end
end)

RegisterNetEvent('es_carwash:success')
AddEventHandler('es_carwash:success', function (price)
	WashDecalsFromVehicle(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1.0)
	SetVehicleDirtLevel(GetVehiclePedIsUsing(GetPlayerPed(-1)))
	es_carwash_DrawNotification("Votre véhicule a été ~y~nettoyé~s~! ~g~-$" .. price .. "~s~ !")
end)

RegisterNetEvent('es_carwash:notenoughmoney')
AddEventHandler('es_carwash:notenoughmoney', function (moneyleft)
	es_carwash_DrawNotification("~h~~r~Tu n'as pas assez d'argent ! $" .. moneyleft .. " restant !")
end)

RegisterNetEvent('es_carwash:free')
AddEventHandler('es_carwash:free', function ()
	WashDecalsFromVehicle(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1.0)
	SetVehicleDirtLevel(GetVehiclePedIsUsing(GetPlayerPed(-1)))
	es_carwash_DrawNotification("Votre véhicule a été ~y~nettoyé~s~ gratuitement !")
end)
