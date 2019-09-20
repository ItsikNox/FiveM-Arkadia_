ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterUsableItem('tenuebraquage', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('esx_tenues:settenuebraquage', _source)
end)

---------------------------------
--- Copyright by ikNox#6088 ---
---------------------------------