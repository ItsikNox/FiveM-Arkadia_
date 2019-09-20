ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_mask:pay')
AddEventHandler('esx_mask:pay', function()

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeMoney(Config.Price)

	TriggerClientEvent('esx:showNotification', source, _U('you_paid') .. '$' .. Config.Price)

end)

RegisterServerEvent('esx_mask:saveMask')
AddEventHandler('esx_mask:saveMask', function(skin)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'user_mask', xPlayer.identifier, function(store)
		
		store.set('hasMask', true)
		
		store.set('skin', {
			mask_1 = skin.mask_1,
			mask_2 = skin.mask_2
		})

	end)

end)


ESX.RegisterServerCallback('esx_mask:checkMoney', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('money') >= Config.Price then
		cb(true)
	else
		cb(false)
	end

end)


ESX.RegisterServerCallback('esx_mask:getMask', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'user_mask', xPlayer.identifier, function(store)
		
		local hasMask = (store.get('hasMask') and store.get('hasMask') or false)
		local skin    = (store.get('skin')    and store.get('skin')    or {})

		cb(hasMask, skin)

	end)

end)
