ESX = nil


TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

ESX.RegisterUsableItem('weed', function(source)
        
        local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('weed', 1)

	TriggerClientEvent('esx_status:add', _source, 'drug', 166000)
	TriggerClientEvent('esx_drugeffects:onWeed', source)
end)

ESX.RegisterUsableItem('opium', function(source)
       
        local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('opium', 1)

	TriggerClientEvent('esx_status:add', _source, 'drug', 249000)
	TriggerClientEvent('esx_drugeffects:onOpium', source)
end)

ESX.RegisterUsableItem('meth', function(source)
        
        local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('meth', 1)

	TriggerClientEvent('esx_status:add', _source, 'drug', 333000)
	TriggerClientEvent('esx_drugeffects:onMeth', source)
end)

ESX.RegisterUsableItem('coke', function(source)
        
        local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('coke', 1)

	TriggerClientEvent('esx_status:add', _source, 'drug', 499000)
	TriggerClientEvent('esx_drugeffects:onCoke', source)
end)

ESX.RegisterUsableItem('xanax', function(source)
        
        local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('xanax', 1)

	TriggerClientEvent('esx_status:remove', _source, 'drug', 249000)
end)

ESX.RegisterUsableItem('weed1', function(source)

    local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
xPlayer.removeInventoryItem('weed1', 1)

TriggerClientEvent('esx_status:add', _source, 'drug', 250000)
TriggerClientEvent('esx_drugeffects:onWeed', source)
end)

ESX.RegisterUsableItem('weed2', function(source)

    local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
xPlayer.removeInventoryItem('weed2', 1)

TriggerClientEvent('esx_status:add', _source, 'drug', 260000)
TriggerClientEvent('esx_drugeffects:onWeed', source)
end)

ESX.RegisterUsableItem('weed3', function(source)

    local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
xPlayer.removeInventoryItem('weed3', 1)

TriggerClientEvent('esx_status:add', _source, 'drug', 275000)
TriggerClientEvent('esx_drugeffects:onWeed', source)
end)

ESX.RegisterUsableItem('weed4', function(source)

    local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
xPlayer.removeInventoryItem('weed4', 1)

TriggerClientEvent('esx_status:add', _source, 'drug', 350000)
TriggerClientEvent('esx_drugeffects:onWeed', source)
end)

ESX.RegisterUsableItem('weed5', function(source)

    local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
xPlayer.removeInventoryItem('weed5', 1)

TriggerClientEvent('esx_status:add', _source, 'drug', 320000)
TriggerClientEvent('esx_drugeffects:onWeed', source)
end)

ESX.RegisterUsableItem('weed6', function(source)

    local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
xPlayer.removeInventoryItem('weed6', 1)

TriggerClientEvent('esx_status:add', _source, 'drug', 340000)
TriggerClientEvent('esx_drugeffects:onWeed', source)
end)

ESX.RegisterUsableItem('weed7', function(source)

    local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
xPlayer.removeInventoryItem('weed7', 1)

TriggerClientEvent('esx_status:add', _source, 'drug', 320000)
TriggerClientEvent('esx_drugeffects:onWeed', source)
end)

ESX.RegisterUsableItem('weed8', function(source)

    local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
xPlayer.removeInventoryItem('weed8', 1)

TriggerClientEvent('esx_status:add', _source, 'drug', 310000)
TriggerClientEvent('esx_drugeffects:onWeed', source)
end)

ESX.RegisterUsableItem('weed9', function(source)

    local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
xPlayer.removeInventoryItem('weed9', 1)

TriggerClientEvent('esx_status:add', _source, 'drug', 330000)
TriggerClientEvent('esx_drugeffects:onWeed', source)
end)

ESX.RegisterUsableItem('weed10', function(source)

    local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
xPlayer.removeInventoryItem('weed10', 1)

TriggerClientEvent('esx_status:add', _source, 'drug', 360000)
TriggerClientEvent('esx_drugeffects:onWeed', source)
end)

ESX.RegisterUsableItem('weed11', function(source)

    local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
xPlayer.removeInventoryItem('weed11', 1)

TriggerClientEvent('esx_status:add', _source, 'drug', 270000)
TriggerClientEvent('esx_drugeffects:onWeed', source)
end)

ESX.RegisterUsableItem('weed12', function(source)

    local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
xPlayer.removeInventoryItem('weed12', 1)

TriggerClientEvent('esx_status:add', _source, 'drug', 280000)
TriggerClientEvent('esx_drugeffects:onWeed', source)
end)

ESX.RegisterUsableItem('weed13', function(source)

    local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
xPlayer.removeInventoryItem('weed13', 1)

TriggerClientEvent('esx_status:add', _source, 'drug', 3000000)
TriggerClientEvent('esx_drugeffects:onWeed', source)
end)

ESX.RegisterUsableItem('weed14', function(source)

    local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
xPlayer.removeInventoryItem('weed14', 1)

TriggerClientEvent('esx_status:add', _source, 'drug', 310000)
TriggerClientEvent('esx_drugeffects:onWeed', source)
end)

ESX.RegisterUsableItem('weed15', function(source)

    local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
xPlayer.removeInventoryItem('weed15', 1)

TriggerClientEvent('esx_status:add', _source, 'drug', 320000)
TriggerClientEvent('esx_drugeffects:onWeed', source)
end)
