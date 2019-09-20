local PlayerData = {}
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		DrawMarker(Config.Marker.type, Config.Marker.x, Config.Marker.y, Config.Marker.z, 0, 0, 0, 0, 0, 0, 2.0001,2.0001,2.0001, 0, Config.Color.r, Config.Color.g, Config.Color.b, 0, 0, 0, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),  -267.92422485352,-957.95263671875,31.22313117981, true) < 1 then
			DisplayHelpText("Appuyez sur ~g~E~s~ pour ouvrir l'agence")
		 if (IsControlJustReleased(1, 51)) then
			SetNuiFocus( true, true )
			SendNUIMessage({
				ativa = true
			})
		 end
		end
	end
end)

RegisterNUICallback('1', function(data, cb)
	TriggerServerEvent('esx_jk_jobs:setJobt')
  	cb('ok')
end)

RegisterNUICallback('3', function(data, cb)
	TriggerServerEvent('esx_jk_jobs:setJobp')
  	cb('ok')
end)

RegisterNUICallback('4', function(data, cb)
	TriggerServerEvent('esx_jk_jobs:setJobn')
  	cb('ok')
end)

RegisterNUICallback('5', function(data, cb)
	TriggerServerEvent('esx_jk_jobs:setJobb')
  	cb('ok')
end)

RegisterNUICallback('fechar', function(data, cb)
	SetNuiFocus( false )
	SendNUIMessage({
	ativa = false
	})
  	cb('ok')
end)

function DrawSpecialText(m_text, showtime)
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

---------------------------------
--------- ikNox#6088 ------------
---------------------------------