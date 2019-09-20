ESX                    = nil
PlayersHarvesting      = {}
PlayersHarvesting2     = {}
PlayersHarvesting3     = {}
PlayersCrafting        = {}
PlayersCrafting2       = {}
PlayersCrafting3       = {}
PlayersCrafting4       = {}
PlayersCrafting5       = {}
PlayersCrafting6       = {}
PlayersCrafting7       = {}
local PlayersSelling       = {}
local CreatedInstances = {}

function randomFloat(lower, greater)
  return lower + math.random()  * (greater - lower);
end

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
	
	local _source = source
	
	TriggerClientEvent('esx_tabac:setTimeDiff', _source, os.time())
	TriggerClientEvent('esx_tabac:onCreatedInstanceData', _source, CreatedInstances)

end)

if Config.MaxInService ~= -1 then
  TriggerEvent('esx_service:activateService', 'tabac', Config.MaxInService)
end

TriggerEvent('esx_society:registerSociety', 'tabac', 'Tabac', 'society_tabac', 'society_tabac', 'society_tabac', {type = 'private'})


-------------- Récupération de Tabac blond -------------
local function Harvest(source)

  SetTimeout(1200, function()

    if PlayersHarvesting[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local TabacBlondQuantity = xPlayer.getInventoryItem('tabacblond').count

      if TabacBlondQuantity >= 150 then
        TriggerClientEvent('esx:showNotification', source, _U('you_do_not_room'))
      else
                xPlayer.addInventoryItem('tabacblond', 1)

        Harvest(source)
      end
    end
  end)
end

RegisterServerEvent('esx_tabac:startHarvest')
AddEventHandler('esx_tabac:startHarvest', function()
  local _source = source
  PlayersHarvesting[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('recovery_tabacblond'))
  Harvest(source)
end)

RegisterServerEvent('esx_tabac:stopHarvest')
AddEventHandler('esx_tabac:stopHarvest', function()
  local _source = source
  PlayersHarvesting[_source] = false
end)

------------ Récupération tabac Brun --------------
local function Harvest2(source)

  SetTimeout(1200, function()

    if PlayersHarvesting2[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local TabacBrunQuantity  = xPlayer.getInventoryItem('tabacbrun').count
      if TabacBrunQuantity >= 150 then
        TriggerClientEvent('esx:showNotification', source, _U('you_do_not_room'))
      else
                xPlayer.addInventoryItem('tabacbrun', 1)

        Harvest2(source)
      end
    end
  end)
end

RegisterServerEvent('esx_tabac:startHarvest2')
AddEventHandler('esx_tabac:startHarvest2', function()
  local _source = source
  PlayersHarvesting2[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('recovery_tabacbrun'))
  Harvest2(_source)
end)

RegisterServerEvent('esx_tabac:stopHarvest2')
AddEventHandler('esx_tabac:stopHarvest2', function()
  local _source = source
  PlayersHarvesting2[_source] = false
end)

------------ Séchage Tabac Blond -------------------
local function Craft(source)

  SetTimeout(1200, function()

    if PlayersCrafting[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local TabacBlondQuantity = xPlayer.getInventoryItem('tabacblond').count

      if TabacBlondQuantity <= 0 then
        TriggerClientEvent('esx:showNotification', source, _U('not_enough_tabacblond'))
      else
                xPlayer.removeInventoryItem('tabacblond', 1)
                xPlayer.addInventoryItem('tabacblondsec', 1)

        Craft(source)
      end
    end
  end)
end

RegisterServerEvent('esx_tabac:startCraft')
AddEventHandler('esx_tabac:startCraft', function()
  local _source = source
  PlayersCrafting[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('sechage_tabacblond'))
  Craft(_source)
end)

RegisterServerEvent('esx_tabac:stopCraft')
AddEventHandler('esx_tabac:stopCraft', function()
  local _source = source
  PlayersCrafting[_source] = false
end)

------------ Séchage Tabac Brun --------------
local function Craft2(source)

  SetTimeout(1200, function()

    if PlayersCrafting2[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local TabacBrunQuantity  = xPlayer.getInventoryItem('tabacbrun').count
      if TabacBrunQuantity <= 0 then
        TriggerClientEvent('esx:showNotification', source, _U('not_enough_tabacbrun'))
      else
                xPlayer.removeInventoryItem('tabacbrun', 1)
                xPlayer.addInventoryItem('tabacbrunsec', 1)

        Craft2(source)
      end
    end
  end)
end

RegisterServerEvent('esx_tabac:startCraft2')
AddEventHandler('esx_tabac:startCraft2', function()
  local _source = source
  PlayersCrafting2[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('sechage_tabacbrun'))
  Craft2(_source)
end)

RegisterServerEvent('esx_tabac:stopCraft2')
AddEventHandler('esx_tabac:stopCraft2', function()
  local _source = source
  PlayersCrafting2[_source] = false
end)


RegisterServerEvent('esx_tabac:startCraft7')
AddEventHandler('esx_tabac:startCraft7', function()
  local _source = source
  PlayersCrafting7[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Séchage et Fermentation en cours...')
  Craft7(_source)
end)

RegisterServerEvent('esx_tabac:stopCraft7')
AddEventHandler('esx_tabac:stopCraft7', function()
  local _source = source
  PlayersCrafting7[_source] = false
end)


------------ Fabrication Malbora --------------
local function Craft3(source)

  SetTimeout(1200, function()

    if PlayersCrafting3[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local TabacBlondSecQuantity  = xPlayer.getInventoryItem('tabacblondsec').count
      if TabacBlondSecQuantity <= 0 then
        TriggerClientEvent('esx:showNotification', source, _U('not_enough_tabacblond_sec'))
      else
                xPlayer.removeInventoryItem('tabacblondsec', 1)
                xPlayer.addInventoryItem('malbora', 1)

        Craft3(source)
      end
    end
  end)
end

RegisterServerEvent('esx_tabac:startCraft3')
AddEventHandler('esx_tabac:startCraft3', function()
  local _source = source
  PlayersCrafting3[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('assemblage_malbora'))
  Craft3(_source)
end)

RegisterServerEvent('esx_tabac:stopCraft3')
AddEventHandler('esx_tabac:stopCraft3', function()
  local _source = source
  PlayersCrafting3[_source] = false
end)


------------ Fabrication Gitanes --------------
local function Craft4(source)

  SetTimeout(1200, function()

    if PlayersCrafting4[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local TabacBrunSecQuantity  = xPlayer.getInventoryItem('tabacbrunsec').count
      if TabacBrunSecQuantity <= 0 then
        TriggerClientEvent('esx:showNotification', source, _U('not_enough_tabacbrun_sec'))
      else
                xPlayer.removeInventoryItem('tabacbrunsec', 1)
                xPlayer.addInventoryItem('gitanes', 1)

        Craft4(source)
      end
    end
  end)
end

RegisterServerEvent('esx_tabac:startCraft4')
AddEventHandler('esx_tabac:startCraft4', function()
  local _source = source
  PlayersCrafting4[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('assemblage_gitanes'))
  Craft4(_source)
end)

RegisterServerEvent('esx_tabac:stopCraft4')
AddEventHandler('esx_tabac:stopCraft4', function()
  local _source = source
  PlayersCrafting4[_source] = false
end)

------------ Fabrication Spliff de Weed --------------
local function Craft5(source)

  SetTimeout(1200, function()

    if PlayersCrafting5[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local MalboraQuantity  = xPlayer.getInventoryItem('malbora').count
      local WeedQuantity  = xPlayer.getInventoryItem('weed').count
      if MalboraQuantity and WeedQuantity <= 0 then
      
        TriggerClientEvent('esx:showNotification', source, _U('pas_assez_ingredients'))
      else
                xPlayer.removeInventoryItem('malbora', 1)
                xPlayer.removeInventoryItem('weed', 1)
                xPlayer.addInventoryItem('splif', 1)

        Craft5(source)
      end
    end
  end)
end

RegisterServerEvent('esx_tabac:startCraft5')
AddEventHandler('esx_tabac:startCraft5', function()
  local _source = source
  PlayersCrafting5[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('assemblage_splif'))
  Craft5(_source)
end)

RegisterServerEvent('esx_tabac:stopCraft5')
AddEventHandler('esx_tabac:stopCraft5', function()
  local _source = source
  PlayersCrafting5[_source] = false
end)

----------------ACHAT PNJ---------------
RegisterServerEvent('esx_tabac:pedBuyCig')
AddEventHandler('esx_tabac:pedBuyCig', function()
  
  local _source       = source
  local xPlayer       = ESX.GetPlayerFromId(_source)
  local resellChances = {}
  local cigTypeMagic  = math.random(0, 100)
  local chosenCig     = nil
  local prices        = nil

  if highPrice then
    prices = Config.CigPricesHigh
  else
    prices = Config.CigPrices
  end

  for k,v in pairs(Config.CigResellChances) do
    table.insert(resellChances, {cig = k, chance = v})
  end

  table.sort(resellChances, function(a, b)
    return a.chance < b.chance
  end)

  local count = 0

  for i=1, #resellChances, 1 do
    
    count = count + resellChances[i].chance

    if cigTypeMagic <= count then
      chosenCig = resellChances[i].cig
      break
    end

  end

  local pricePerUnit = randomFloat(prices[chosenCig].min, prices[chosenCig].max)
  local quantity     = math.random(Config.CigResellQuantity[chosenCig].min, Config.CigResellQuantity[chosenCig].max)
  local item         = xPlayer.getInventoryItem(chosenCig)
  local societyAccount  = nil

  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_tabac', function(account)
    societyAccount = account
  end)

  if item.count > 0 then

    if item.count < quantity then

      local price = math.floor(item.count * pricePerUnit)

      xPlayer.removeInventoryItem(chosenCig, item.count)
      societyAccount.addMoney(price)
      
      TriggerClientEvent('esx:showNotification', _source, 'Vous avez gagné ~g~$' .. price .. '~s~ pour ~y~x' .. item.count .. ' ' .. item.label)
    else

      local price = math.floor(quantity * pricePerUnit)

      xPlayer.removeInventoryItem(chosenCig, quantity)
      societyAccount.addMoney(price)

      TriggerClientEvent('esx:showNotification', _source, 'Vous avez gagné ~g~$' .. price .. '~s~ pour ~y~x' .. quantity .. ' ' .. item.label)
    end

  else
    TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas les cigarettes demandées [' .. item.label .. ']')
  end

end)

RegisterServerEvent('esx_tabac:pedCallPolice')
AddEventHandler('esx_tabac:pedCallPolice', function()
	
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do

		local xPlayer2 = ESX.GetPlayerFromId(xPlayers[i])
			
		if xPlayer2.job.name == 'crypted' then
			TriggerClientEvent('esx_cryptedphone:onMessage', xPlayer2.source, '', 'Une personne a essayé de me vendre des cigarettes', xPlayer.get('coords'), true, 'Alerte Moldu', false)
		end
	end
end)

----------------------------------
---- Ajout Gestion Stock Boss ----
----------------------------------

RegisterServerEvent('esx_tabac:getStockItem')
AddEventHandler('esx_tabac:getStockItem', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_tabac', function(inventory)

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

ESX.RegisterServerCallback('esx_tabac:getStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_tabac', function(inventory)
    cb(inventory.items)
  end)

end)

-------------
-- AJOUT 2 --
-------------

RegisterServerEvent('esx_tabac:putStockItems')
AddEventHandler('esx_tabac:putStockItems', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)
  local sourceItem = xPlayer.getInventoryItem(itemName)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_tabac', function(inventory)

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

ESX.RegisterServerCallback('esx_tabac:putStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_tabac', function(inventory)
    cb(inventory.items)
  end)

end)

ESX.RegisterServerCallback('esx_tabac:getPlayerInventory', function(source, cb)

  local xPlayer    = ESX.GetPlayerFromId(source)
  local items      = xPlayer.inventory

  cb({
    items      = items
  })

end)

ESX.RegisterServerCallback('esx_tabac:tryRemoveInventoryItem', function(source, cb, itemName, itemCount)

  local xPlayer = ESX.GetPlayerFromId(source)
  local item    = xPlayer.getInventoryItem(itemName)

  if item.count >= itemCount then
    xPlayer.removeInventoryItem(itemName, itemCount)
    cb(true)
  else
    cb(false)
  end
end)

RegisterServerEvent('esx_tabac:annonce')
AddEventHandler('esx_tabac:annonce', function(result)
  local _source  = source
  local xPlayer  = ESX.GetPlayerFromId(_source)
  local xPlayers = ESX.GetPlayers()
  local text     = result
  print(text)
  for i=1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
    TriggerClientEvent('esx_tabac:annonce', xPlayers[i],text)
  end

  Wait(8000)

  local xPlayers = ESX.GetPlayers()
  for i=1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
    TriggerClientEvent('esx_tabac:annoncestop', xPlayers[i])
  end

end)

----------------------------
---- Utiliser Cigarette ----
----------------------------
ESX.RegisterUsableItem('malbora', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('malbora', 1)

    TriggerClientEvent('esx_tabac:onSmokeCig', source)
    TriggerClientEvent('esx:showNotification', source, 'Vous avez fumé ~g~1x ~b~Malboro')

end)

-----------------------------
---- Utiliser CigaretteC ----
-----------------------------
ESX.RegisterUsableItem('cigaret', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('cigaret', 1)

    TriggerClientEvent('esx_tabac:onSmokeCig', source)
    TriggerClientEvent('esx:showNotification', source, 'Vous avez fumé ~g~1x ~b~Cigarette chinoise')

end)

----------------------------
---- Utiliser Cigarette ----
----------------------------
ESX.RegisterUsableItem('gitanes', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('gitanes', 1)

    TriggerClientEvent('esx_tabac:onSmokeCig', source)
    TriggerClientEvent('esx:showNotification', source, 'Vous avez fumé ~g~1x ~b~Lucky Strike')

end)

---SPLIF

ESX.RegisterUsableItem('splif', function(source)

  local _source  = source
  local xPlayer  = ESX.GetPlayerFromId(_source)

  xPlayer.removeInventoryItem('splif', 1)
  
  TriggerClientEvent('esx_tabac:onSmokeSplif', _source)
  TriggerClientEvent('esx_status:add', source, 'thirst', -80000)
  TriggerClientEvent('esx_status:add', source, 'hunger', -80000)
  TriggerClientEvent('esx:showNotification', source, 'Vous fumez un splif de weed')
  TriggerClientEvent('esx_status:add', source, 'drunk', 150000)

end)

local function Sell(source, zone)

  if PlayersSelling[source] == true then
    local xPlayer  = ESX.GetPlayerFromId(source)
    
    if xPlayer ~= nil and zone == 'SellFarm' then
   -- if zone == 'SellFarm' then
      if xPlayer.getInventoryItem('malbora').count <= 0 then
        malbora = 0
      else
        malbora = 1
      end
      
      if xPlayer.getInventoryItem('gitanes').count <= 0 then
        gitanes = 0
      else
        gitanes = 1
      end
    
      if malbora == 0 and gitanes == 0 then
        TriggerClientEvent('esx:showNotification', source, _U('no_product_sale'))
        return
      elseif xPlayer.getInventoryItem('malbora').count <= 0 and gitanes == 0 then
        TriggerClientEvent('esx:showNotification', source, _U('no_malbora_sale'))
        malbora = 0
        return
      elseif xPlayer.getInventoryItem('gitanes').count <= 0 and malbora == 0 then
        TriggerClientEvent('esx:showNotification', source, _U('no_gitanes_sale'))
        gitanes = 0
        return
      else
        if (gitanes == 1) then
          SetTimeout(1200, function()
            local money = math.random(82,82)
			      local argent = math.random(82,82)
            xPlayer.removeInventoryItem('gitanes', 1)
            local societyAccount = nil

            TriggerEvent('esx_addonaccount:getSharedAccount', 'society_tabac', function(account)
              societyAccount = account
            end)
            if societyAccount ~= nil then
			  xPlayer.addMoney(argent)
              societyAccount.addMoney(money)
			  TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_earned') .. argent)
              TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
            end
            Sell(source,zone)
          end)
        elseif (malbora == 1) then
          SetTimeout(1200, function()
            local money = math.random(82,82)
			      local argent = math.random(82,82)
            xPlayer.removeInventoryItem('malbora', 1)
            local societyAccount = nil

            TriggerEvent('esx_addonaccount:getSharedAccount', 'society_tabac', function(account)
              societyAccount = account
            end)
            if societyAccount ~= nil then
			  xPlayer.addMoney(argent)
              societyAccount.addMoney(money)
			  TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_earned') .. argent)
              TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
            end
            Sell(source,zone)
          end)
        end
        
      end
    end
  end
end

RegisterServerEvent('esx_tabac:startSell')
AddEventHandler('esx_tabac:startSell', function(zone)

  local _source = source
  
  if PlayersSelling[_source] == false then
    TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
    PlayersSelling[_source]=false
  else
    PlayersSelling[_source]=true
    TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))
    Sell(_source, zone)
  end

end)

RegisterServerEvent('esx_tabac:stopSell')
AddEventHandler('esx_tabac:stopSell', function()

  local _source = source
  
  if PlayersSelling[_source] == true then
    PlayersSelling[_source]=false
    TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
    
  else
    TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~vendre')
    PlayersSelling[_source]=true
  end

end)

---------------------------------
--- Copyright by ikNox#6088 ---
---------------------------------