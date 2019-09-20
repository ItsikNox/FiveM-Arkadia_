ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

ESX.RegisterUsableItem('beer', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('beer', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 250000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_beer'))

end)

ESX.RegisterUsableItem('vine', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('vine', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 200000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_vine'))

end)

ESX.RegisterUsableItem('vodka', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('vodka', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 60000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_vodka'))

end)

ESX.RegisterUsableItem('whisky', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('whisky', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 60000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_whisky'))

end)

ESX.RegisterUsableItem('martini', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('martini', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 60000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_martini'))

end)

ESX.RegisterUsableItem('tequila', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('tequila', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 60000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_tequila'))

end)

ESX.RegisterUsableItem('jager', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('jager', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 120000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_jager'))

end)

ESX.RegisterUsableItem('rhum', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('rhum', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 60000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_rhum'))

end)

ESX.RegisterUsableItem('rhumcoca', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('rhumcoca', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 180000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_rhumcoca'))

end)

ESX.RegisterUsableItem('jagerbomb', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('jagerbomb', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 180000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_jagerbomb'))

end)

ESX.RegisterUsableItem('golem', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('golem', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 180000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_golem'))

end)

ESX.RegisterUsableItem('whiskycoca', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('whiskycoca', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 180000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_whiskycoca'))

end)

ESX.RegisterUsableItem('vodkafruit', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('vodkafruit', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 180000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_vodkafruit'))

end)

ESX.RegisterUsableItem('teqpaf', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('teqpaf', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 180000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_teqpaf'))

end)

ESX.RegisterUsableItem('mojito', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('mojito', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 180000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_mojito'))

end)

ESX.RegisterUsableItem('metreshooter', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('metreshooter', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 300000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_metreshooter'))

end)

ESX.RegisterUsableItem('jagercerbere', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('jagercerbere', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 300000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_jagercerbere'))

end)

ESX.RegisterUsableItem('vodkaenergy', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('vodkaenergy', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 180000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_vodkaenergy'))
end)
