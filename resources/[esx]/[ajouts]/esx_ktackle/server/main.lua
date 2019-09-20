-- 2018 Henric 'Kekke' Johansson

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_kekke_tackle:tryTackle')
AddEventHandler('esx_kekke_tackle:tryTackle', function(target)
	local targetPlayer = ESX.GetPlayerFromId(target)

	TriggerClientEvent('esx_kekke_tackle:getTackled', targetPlayer.source, source)
	TriggerClientEvent('esx_kekke_tackle:playTackle', source)
end)