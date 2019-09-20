

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
ESX.RegisterServerCallback('Parow:GetCoiffeurMontant', function(source, cb, _)
	--("ss")
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
  k = xPlayer.get('money')
  if k >= 50 then
    xPlayer.removeMoney(50)
    cb(true)
  else
    cb(false)
  end
end)


ESX.RegisterServerCallback('Parow:GetTenues', function(source, cb, _)
	--("ss")
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll(
		'SELECT * FROM user_tenue WHERE identifier = @identifier',
		{
      ['@identifier'] = xPlayer.identifier
		},
    function(result)
    print(json.encode(result))
			cb(result)
		end
	)
end)
ESX.RegisterServerCallback('Parow:GetMoneyVet', function(source, cb, _)
	--("ss")
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
  if xPlayer.get('money') >= 50 then
    xPlayer.removeMoney(50)
    cb(true)
    TriggerClientEvent("Parow:isxkaaa9921",source)
  else
    
		TriggerClientEvent('esx:showNotification', _source, 'Pas assez d\'argent')
    cb(false)
  end
end)