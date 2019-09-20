ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterNetEvent("esx_walkie:startActionB")
AddEventHandler("esx_walkie:startActionB", function()
	local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do

			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer.job.name ~= nil and xPlayer.job.name == "police" and xPlayer.getInventoryItem("radio") then
				TriggerClientEvent("esx_walkie:startActionB", xPlayer.source) -- Client Event auf Aktionen start
			end
		end
end)

ESX.RegisterServerCallback('esx_walkie:getItemAmount', function(source, cb, item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

RegisterNetEvent("esx_walkie:stopActionB")
AddEventHandler("esx_walkie:stopActionB", function()
	local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do

			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer.job.name ~= nil and xPlayer.job.name == "police" and xPlayer.getInventoryItem("radio") then
				TriggerClientEvent("esx_walkie:stopActionB", xPlayer.source) -- Client Event auf Aktionen start
			end
		end
end)

RegisterServerEvent('esx_walkie:playSoundWithinDistanceServer')
AddEventHandler('esx_walkie:playSoundWithinDistanceServer', function(maxDistance, soundFile, soundVolume)
	local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do

			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer.job.name == "police" and xPlayer.getInventoryItem("radio") then
				TriggerClientEvent('esx_walkie:playSoundWithinDistanceClient', xPlayer.source, -1, maxDistance, soundFile, soundVolume)
			end
		end
end)
