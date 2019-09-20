ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_eden_clotheshop:pay')
AddEventHandler('esx_eden_clotheshop:pay', function()

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeMoney(Config.Price)

	TriggerClientEvent('esx:showNotification', source, _U('you_paid') .. Config.Price)

end)

RegisterServerEvent('esx_eden_clotheshop:saveOutfit')
AddEventHandler('esx_eden_clotheshop:saveOutfit', function(label, skin)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)

		local dressing = store.get('dressing')

		if dressing == nil then
			dressing = {}
		end

		table.insert(dressing, {
			label = label,
			skin  = skin
		})

		store.set('dressing', dressing)

	end)

end)

RegisterServerEvent('esx_eden_clotheshop:deleteOutfit')
AddEventHandler('esx_eden_clotheshop:deleteOutfit', function(label)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)

		local dressing = store.get('dressing')

		if dressing == nil then
			dressing = {}
		end

		label = label
		
		table.remove(dressing, label)

		store.set('dressing', dressing)

	end)

end)

ESX.RegisterServerCallback('esx_eden_clotheshop:checkMoney', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('money') >= Config.Price then
		cb(true)
	else
		cb(false)
	end

end)

ESX.RegisterServerCallback('esx_eden_clotheshop:checkPropertyDataStore', function(source, cb)

	local xPlayer    = ESX.GetPlayerFromId(source)
	local foundStore = false

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		foundStore = true
	end)

	cb(foundStore)

end)

ESX.RegisterServerCallback('esx_eden_clotheshop:getPlayerDressing', function(source, cb)

  local xPlayer  = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)

    local count    = store.count('dressing')
    local labels   = {}

    for i=1, count, 1 do
      local entry = store.get('dressing', i)
      table.insert(labels, entry.label)
    end

    cb(labels)

  end)

end)

ESX.RegisterServerCallback('esx_eden_clotheshop:getPlayerOutfit', function(source, cb, num)

  local xPlayer  = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
    local outfit = store.get('dressing', num)
    cb(outfit.skin)
  end)

end)
