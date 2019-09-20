ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
  TriggerEvent('esx_service:activateService', 'avocat', Config.MaxInService)
end

TriggerEvent('esx_society:registerSociety', 'avocat', 'Avocat', 'society_avocat', 'society_avocat', 'society_avocat', {type = 'private'})


----------------------------------
---- Ajout Gestion Stock Boss ----
----------------------------------

RegisterServerEvent('esx_avocatjob:getStockItem')
AddEventHandler('esx_avocatjob:getStockItem', function(itemName, count)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_avocat', function(inventory)

    local item = inventory.getItem(itemName)

    if item.count >= count then
      inventory.removeItem(itemName, count)
      xPlayer.addInventoryItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_removed') .. count .. ' ' .. item.label)

  end)

end)

ESX.RegisterServerCallback('esx_avocatjob:getStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_avocat', function(inventory)
    cb(inventory.items)
  end)

end)

-------------
-- AJOUT 2 --
-------------

RegisterServerEvent('esx_avocatjob:putStockItems')
AddEventHandler('esx_avocatjob:putStockItems', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)
  local sourceItem = xPlayer.getInventoryItem(itemName)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_avocat', function(inventory)

    local inventoryItem = inventory.getItem(itemName)

    if sourceItem.count >= count and count > 0 then
      xPlayer.removeInventoryItem(itemName, count)
      inventory.addItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('added') .. count .. ' ' .. item.label)

  end)

end)

ESX.RegisterServerCallback('esx_avocatjob:putStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_avocat', function(inventory)
    cb(inventory.items)
  end)

end)

ESX.RegisterServerCallback('esx_avocatjob:getPlayerInventory', function(source, cb)

  local xPlayer    = ESX.GetPlayerFromId(source)
  local items      = xPlayer.inventory

  cb({
    items      = items
  })

end)

---------------------------------
--- Copyright by ikNox#6088 ---
---------------------------------