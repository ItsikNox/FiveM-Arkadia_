ESX						= nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('esx_worek:closest')
AddEventHandler('esx_worek:closest', function()
    local name = GetPlayerName(najblizszy)
    TriggerClientEvent('esx_worek:nalozNa', najblizszy)
end)

RegisterServerEvent('esx_worek:sendclosest')
AddEventHandler('esx_worek:sendclosest', function(closestPlayer)
    najblizszy = closestPlayer
end)

RegisterServerEvent('esx_worek:zdejmij')
AddEventHandler('esx_worek:zdejmij', function()
    TriggerClientEvent('esx_worek:zdejmijc', najblizszy)
end)

ESX.RegisterUsableItem('headbag', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('esx_worek:naloz', _source)
    TriggerEvent('esx_worek:debugger', source)
end)