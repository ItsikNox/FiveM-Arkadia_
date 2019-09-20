ESX                			 = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_location:Buy')
AddEventHandler('esx_location:Buy', function(price)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.removeMoney(price)
    TriggerClientEvent('esx:showNotification', _source, 'Bonne route !')
end)