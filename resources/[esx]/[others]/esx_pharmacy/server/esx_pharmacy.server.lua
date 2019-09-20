ESX              = nil
local ItemLabels = {}


-- ====================================================================================================================
-- Basic event handler
-- ====================================================================================================================
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('onMySQLReady', function()

  MySQL.Async.fetchAll('SELECT * FROM items', {}, function(result)
    for i = 1, #result, 1 do
      ItemLabels[result[i].name] = result[i].label
    end
  end)

end)

RegisterServerEvent('esx_pharmacy:buyItem')
AddEventHandler('esx_pharmacy:buyItem', function(itemName, price)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  if xPlayer.get('money') >= price then
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem(itemName, 1)

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
      account.addMoney(price)
    end)

    TriggerClientEvent('esx:showNotification', _source, _U('bought') .. ItemLabels[itemName])
  else
    TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
  end

end)

RegisterServerEvent('esx_pharmacy:removeItem')
AddEventHandler('esx_pharmacy:removeItem', function(itemName)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  xPlayer.removeInventoryItem(itemName, 1)
end)


-- ====================================================================================================================
-- Usable item
-- ====================================================================================================================
ESX.RegisterUsableItem('firstaidkit', function(source)
  local xPlayers     = ESX.GetPlayers()
  local hasAmbulance = false

  for i = 1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
    if xPlayer.job.name == 'ambulance' then
      hasAmbulance = true
      break
    end
  end

  if not hasAmbulance then
    TriggerClientEvent('esx_pharmacy:useKit', source, 'firstaidkit', 4)
  else
    TriggerClientEvent('esx:showNotification', source, _U('has_ambulance'))  
  end
end)

ESX.RegisterUsableItem('adrenaline', function(source)
  local xPlayers     = ESX.GetPlayers()
  local hasAmbulance = false

  for i = 1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
    if xPlayer.job.name == 'ambulance' then
      hasAmbulance = true
      break
    end
  end

  if not hasAmbulance then
    TriggerClientEvent('esx_pharmacy:useDefibrillateur', source, 'adrenaline')
  else
    TriggerClientEvent('esx:showNotification', source, _U('has_ambulance'))  
  end
end)