ESX = nil 
TriggerEvent("esx:getSharedObject", function(obj)
    ESX = obj
end)

RegisterServerEvent("tattoos:GetPlayerTattoos_s")
AddEventHandler("tattoos:GetPlayerTattoos_s", function()
	local _source = source
	local playerId = getPlayerID(_source)

	MySQL.Async.fetchAll("SELECT * FROM playerstattoos WHERE identifier = @identifier", {['@identifier'] = playerId}, function(result)
		if(result[1] ~= nil) then
			TriggerClientEvent("tattoos:getPlayerTattoos", _source, result[1].tattoos)
		else
			local tattooValue = json.encode({})
			MySQL.Async.execute("INSERT INTO playerstattoos (identifier, tattoos) VALUES (@identifier, @tattoo)", {['@identifier'] = playerId, ['@tattoo'] = tattooValue})
			TriggerClientEvent("tattoos:getPlayerTattoos", _source, {})
		end
	end)
	
end)





RegisterServerEvent("tattoos:save")
AddEventHandler("tattoos:save", function(tattoosList, price, value)
	local _source = source
	local playerId = getPlayerID(_source)
	local xPlayer = ESX.GetPlayerFromId(_source)

	if(xPlayer.getMoney() >= price) then
		xPlayer.removeMoney(price)
		table.insert(tattoosList,value)
		MySQL.Async.execute("UPDATE playerstattoos SET tattoos = @tattoos WHERE identifier = @identifier", {['@tattoos'] = json.encode(tattoosList), ['@identifier'] = playerId})
		TriggerClientEvent("tattoo:buySuccess", _source, value)
		TriggerClientEvent("esx:showNotification", _source, "~g~You just bought this tattoo.")
	else
		TriggerClientEvent("esx:showNotification", _source, "~r~You don't have enought money.")
	end
end)

function getPlayerID(source)
	local _source = source
    local identifiers = GetPlayerIdentifiers(_source)
    local player = getIdentifiant(identifiers)
    return player
end

-- gets the actual player id unique to the player,
-- independent of whether the player changes their screen name
function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end

