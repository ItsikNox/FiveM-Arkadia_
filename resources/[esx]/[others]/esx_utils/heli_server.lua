ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('heli:spotlight')
AddEventHandler('heli:spotlight', function(state)
	local serverID = source
	TriggerClientEvent('heli:spotlight', -1, serverID, state)
end)