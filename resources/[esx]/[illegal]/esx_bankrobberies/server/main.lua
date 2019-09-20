ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
	ESX = obj 
end)

RegisterServerEvent("esx_bankrobbery:startRobbery")
AddEventHandler("esx_bankrobbery:startRobbery", function(bankId)
    TriggerClientEvent("esx_bankrobbery:openDoor", -1, bankId)
    TriggerClientEvent("esx_bankrobbery:startRobbery", -1, bankId)

    local Players = ESX.GetPlayers()

    for i = 1, #Players do
    	local xPlayer = ESX.GetPlayerFromId(Players[i])

    	if xPlayer["job"]["name"] == "police" then
    		TriggerClientEvent("esx_bankrobbery:alertCops", xPlayer.source, bankId)
    	end
    end
end)

RegisterServerEvent("esx_bankrobbery:endRobbery")
AddEventHandler("esx_bankrobbery:endRobbery", function(bankId)
    TriggerClientEvent("esx_bankrobbery:endRobbery", -1, bankId)
end)

RegisterServerEvent("esx_bankrobbery:grabbedCash")
AddEventHandler("esx_bankrobbery:grabbedCash", function(bankId, oldCash, newCash)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    xPlayer.addAccountMoney("black_money", newCash)

    TriggerClientEvent("esx:showNotification", src, "Vous avez reçu " .. newCash .. " d'argent sale")

    TriggerClientEvent("esx_bankrobbery:changeCash", -1, bankId, oldCash - newCash)
end)

ESX.RegisterServerCallback("esx_bankrobbery:fetchCops", function(source, cb, minCops)
    local copsOnDuty = 0

    local Players = ESX.GetPlayers()

    for i = 1, #Players do
        local xPlayer = ESX.GetPlayerFromId(Players[i])

        if xPlayer["job"]["name"] == "police" then
            copsOnDuty = copsOnDuty + 1
        end
    end

    if copsOnDuty >= minCops then
        cb(true)
    else
        cb(false)
    end
end)