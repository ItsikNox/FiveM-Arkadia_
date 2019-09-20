ESX = nil
local connectedPlayers = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountJobs()
	local EMSConnected = 0
	local PoliceConnected = 0
	local TaxiConnected = 0
	local MekConnected = 0
	local BilConnected = 0
	local MaklareConnected = 0
	local PlayerConnected = 0

	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		
		PlayerConnected = PlayerConnected + 1
		if xPlayer.job.name == 'ambulance' then
			EMSConnected = EMSConnected + 1
		elseif xPlayer.job.name == 'police' then
			PoliceConnected = PoliceConnected + 1
		elseif xPlayer.job.name == 'taxi' then
			TaxiConnected = TaxiConnected + 1
		elseif xPlayer.job.name == 'mecano' then
			MekConnected = MekConnected + 1
		elseif xPlayer.job.name == 'cardealer' then
			BilConnected = BilConnected + 1
		elseif xPlayer.job.name == 'realestateagent' then
			MaklareConnected = MaklareConnected + 1
		end
	end

	return EMSConnected, PoliceConnected, TaxiConnected, MekConnected, BilConnected, MaklareConnected, PlayerConnected
end

ESX.RegisterServerCallback('scoreboard:getScoreboard', function(source, cb)
	cb(CountJobs())
end)

ESX.RegisterServerCallback('scoreboard:getPlayers', function(source, cb)
	cb(connectedPlayers)
end)

AddEventHandler('esx:playerLoaded', function(player)
	connectedPlayers[player] = {}
	local identifier = GetPlayerIdentifiers(player)[1]

	MySQL.Async.fetchAll('SELECT firstname, lastname, name FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function (result)

		if result[1].firstname and result[1].lastname then
			connectedPlayers[player].name = result[1].firstname .. ' ' .. result[1].lastname
			TriggerClientEvent('scoreboard:updatePlayers', -1, connectedPlayers)
		elseif result[1].name then
			connectedPlayers[player].name = result[1].name
			TriggerClientEvent('scoreboard:updatePlayers', -1, connectedPlayers)
		else
			connectedPlayers[player].name = 'Unknown player name'
			TriggerClientEvent('scoreboard:updatePlayers', -1, connectedPlayers)
		end

	end)

end)

AddEventHandler('esx:playerDropped', function(playerID)
	connectedPlayers[playerID] = nil

	TriggerClientEvent('scoreboard:updatePlayers', -1, connectedPlayers)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then

		Citizen.CreateThread(function()
			Citizen.Wait(1000)
			ForceCountPlayers()
		end)
		
	end
end)

function ForceCountPlayers()
	local xPlayers = ESX.GetPlayers()
	local player

	for i=1, #xPlayers, 1 do
		player = xPlayers[i]

		connectedPlayers[player] = {}
		local identifier = GetPlayerIdentifiers(player)[1]

		MySQL.Async.fetchAll('SELECT firstname, lastname, name FROM users WHERE identifier = @identifier', {
			['@identifier'] = identifier
		}, function (result)

			if result[1].firstname and result[1].lastname then
				connectedPlayers[player].name = result[1].firstname .. ' ' .. result[1].lastname
			elseif result[1].name then
				connectedPlayers[player].name = result[1].name
			else
				connectedPlayers[player].name = 'Unknown player name'
			end
	
		end)

		-- await!
		while connectedPlayers[player].name == nil do
			Citizen.Wait(1)
		end

	end

	TriggerClientEvent('scoreboard:updatePlayers', -1, connectedPlayers)

end