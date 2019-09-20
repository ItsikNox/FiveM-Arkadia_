local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX                             = nil
local GUI                       = {}
GUI.Time                        = 0
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local HasAlreadyEnteredMarker   = false
local LastStation               = nil
local LastPart                  = nil
local LastPartNum               = nil
local LastEntity                = nil
local OnFaction                 = false
local hintIsShowed              = false
local hintToDisplay             = "no hint to display"
local PlayerData                = {}


Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(1)
  end
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

local blips = {

  {title="QG Podolskaïa", colour=21, id=84, x = -806.78, y = 173.7, z = 72.84}
  }
  Citizen.CreateThread(function()

		Citizen.Wait(0)

local bool = true
  
  if bool then
        
		for k,v in pairs(blips) do
           

               zoneblip = AddBlipForRadius(v.x,v.y,v.z, 450.0)
                          SetBlipSprite(zoneblip,1)
                          SetBlipColour(zoneblip,21)
                          SetBlipAlpha(zoneblip,75)
                         
        end
         
    
         for _, info in pairs(blips) do
        
             info.blip = AddBlipForCoord(info.x, info.y, info.z)
                         SetBlipSprite(info.blip, info.id)
                         SetBlipDisplay(info.blip, 4)
                         SetBlipColour(info.blip, info.colour)
                         SetBlipAsShortRange(info.blip, true)
                         BeginTextCommandSetBlipName("STRING")
                         AddTextComponentString(info.title)
                         EndTextCommandSetBlipName(info.blip)
         end
	   
	   bool = false
   
   end
end)

function SetVehicleMaxMods(vehicle)

  local props = {
    modEngine       = 2,
    modBrakes       = 2,
    modTransmission = 2,
    modSuspension   = 3,
    modTurbo        = true,
  }

  ESX.Game.SetVehicleProperties(vehicle, props)

end

function OpenBanditsActionsMenu()

  local elements = {
    -- {label = 'Liste Véhicules', value = 'vehicle_list'},
    -- {label = 'Tenue', value = 'cloakroom'},
    {label = '---------', value = ''},
    {label = 'Déposer Argent sale / Armes', value = 'put_black_money'},
    {label = 'Prendre Argent sale / Armes', value = 'get_black_money'},
    {label = '---------', value = ''},
    {label = 'Déposer Stock', value = 'put_stock'},
    {label = 'Prendre Stock', value = 'get_stock'},
    {label = 'Acheté Torch Plasma 15K$', value = 'item'},
    {label = 'Acheté LockPick 7500$', value = 'item1'},
    {label = 'Acheté BankID 7500$', value = 'item2'}
  }
  if Config.EnablePlayerManagement and PlayerData.job2 ~= nil and PlayerData.job2.grade_name == 'boss' then
    table.insert(elements, {label = '---------', value = ''})
    table.insert(elements, {label = 'Actions boss', value = 'boss_actions'})
  end

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'bandits_actions',
    {
      title    = 'podolskaia',
      elements = elements
    },
    function(data, menu)
      if data.current.value == 'vehicle_list' then

        if Config.EnableSocietyOwnedVehicles then

            local elements = {}

            ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)

              for i=1, #vehicles, 1 do
                table.insert(elements, {label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']', value = vehicles[i]})
              end

              ESX.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'vehicle_spawner',
                {
                  title    = 'Véhicule podolskaia',
                  align    = 'right',
                  elements = elements,
                },
                function(data, menu)

                  menu.close()

                  local playerPed = GetPlayerPed(-1)
                  local vehicleProps = data.current.value
                  local platenum = math.random(100, 900)

                  ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones2.VehicleBanditsSpawnPoint.Pos, 270.0, function(vehicle)
                    ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
                    SetVehicleNumberPlateText(vehicle, "Ace" .. platenum)
                    TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
                    local plate = GetVehicleNumberPlateText(vehicle)
                    plate = string.gsub(plate, " ", "")
                    TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
                  end)

                  TriggerServerEvent('esx_society:removeVehicleFromGarage', 'podolskaia', vehicleProps)

                end,
                function(data, menu)
                  menu.close()
                end
              )

            end, 'podolskaia')

          else

            local elements = {
              {label = 'Banalisé', value = 'oracle'},
              {label = 'Baller blindé', value = 'baller6'},
              {label = 'R8 Prior', value = 'r8prior'},
              {label = 'Ferrari 458', value = 'italia458'}
            }

            if Config.EnablePlayerManagement and PlayerData.job2 ~= nil and
              (PlayerData.job2.grade_name == 'boss' or PlayerData.job2.grade_name == '') then
              table.insert(elements, {label = 'Véhicule du Boss', value = 'w124'})
            end

            ESX.UI.Menu.CloseAll()

            ESX.UI.Menu.Open(
              'default', GetCurrentResourceName(), 'spawn_vehicle',
              {
                title    = 'Véhicule Renaissance',
                elements = elements
              },
              function(data, menu)

                for i=1, #elements, 1 do

                    local model = data.current.value
                	local platenum = math.random(100, 900)
                	local playerPed = GetPlayerPed(-1)

                  if Config.MaxInService == -1 then

                    ESX.Game.SpawnVehicle(data.current.value, Config.Zones2.VehicleBanditsSpawnPoint.Pos, 90.0, function(vehicle)
                      SetVehicleNumberPlateText(vehicle, "Ace" .. platenum)
                      SetVehicleCustomPrimaryColour(vehicle, 0, 0, 0)
                      SetVehicleWindowTint(vehicle, 1)
                      SetVehicleMaxMods(vehicle)
                      TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                      local plate = GetVehicleNumberPlateText(vehicle)
                      plate = string.gsub(plate, " ", "")
                      TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
                    end)

                    break

                  else

                    ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)

                      if canTakeService then

                        ESX.Game.SpawnVehicle(data.current.value, Config.Zones2.VehicleBanditsSpawnPoint.Pos, 90.0, function(vehicle)
                          SetVehicleNumberPlateText(vehicle, "Ace" .. platenum)
                          SetVehicleCustomPrimaryColour(vehicle, 0, 0, 0)
                          SetVehicleWindowTint(vehicle, 1)
                          SetVehicleMaxMods(vehicle)
                          TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
                        end)

                      else

                        ESX.ShowNotification('service_full' .. inServiceCount .. '/' .. maxInService)

                      end
                    end, 'podolskaia')

                    break

                  end
                end
                menu.close()
              end,

              function(data, menu)
                menu.close()
                OpenBanditsActionsMenu()
              end
            )

          end
      end

      if data.current.value == 'cloakroom' then
        OpenCloakroomMenu()
      end

      if data.current.value == 'get_black_money' then
        OpenGetBlackMoney()
      end

      if data.current.value == 'put_black_money' then
        OpenPutBlackMoney()
      end

      if data.current.value == 'item' then
        TriggerServerEvent('esx_podolskaia:buyItem')
      end

      if data.current.value == 'item1' then
        TriggerServerEvent('esx_podolskaia:buyItem1')
      end

      if data.current.value == 'item2' then
        TriggerServerEvent('esx_podolskaia:buyItem2')
      end

      if data.current.value == 'put_stock' then
        OpenPutStocksBanditsMenu()
      end

      if data.current.value == 'get_stock' then
        OpenGetStocksBanditsMenu()
      end

      if data.current.value == 'boss_actions' then
        TriggerEvent('esx_society:openBossMenu', 'podolskaia', function(data, menu)
          menu.close()
        end)
      end

    end,
    function(data, menu)

      menu.close()

      CurrentAction     = 'bandits_actions_menu'
      CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
      CurrentActionData = {}

    end
  )

end



function OpenCloakroomMenu()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'cloakroom',
    {
      title    = 'cloakroom',
      align    = 'right',
      elements = {
        {label = 'Tenue Civil', value = 'citizen_wear'},
        {label = 'Tenue bandits', value = 'bandits_wear'},
      },
    },
    function(data, menu)

      menu.close()

      if data.current.value == 'citizen_wear' then

        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, factionSkin)
          TriggerEvent('skinchanger:loadSkin', skin)
        end)

      end

      if data.current.value == 'bandits_wear' then

        ESX.TriggerServerCallback('esx_skin:getPlayerSkinFaction', function(skin, factionSkin)

          if skin.sex == 0 then
            TriggerEvent('skinchanger:loadClothes', skin, factionSkin.skin_male)
          else
            TriggerEvent('skinchanger:loadClothes', skin, factionSkin.skin_female)
          end

        end)

      end

      CurrentAction     = 'bandits_actions_menu'
      CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
      CurrentActionData = {}

    end,
    function(data, menu)
      menu.close()
    end
  )

end

---- Stock Items bandits

function OpenGetStocksBanditsMenu()

  ESX.TriggerServerCallback('esx_podolskaia:getStockItemsBandits', function(items)

    print(json.encode(items))

    local elements = {}

    for i=1, #items, 1 do

      local item = items[i]

      if item.count > 0 then
        table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
      end

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
        title    = 'podolskaia Stock',
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
          {
            title = 'Quantité'
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification('Quantité Invalide')
            else
              menu2.close()
              menu.close()
              OpenGetStocksBanditsMenu()

              TriggerServerEvent('esx_podolskaia:getStockItemsBandits', itemName, count)
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end



function OpenPutStocksBanditsMenu()

ESX.TriggerServerCallback('esx_podolskaia:getPlayerInventory', function(inventory)

    local elements = {}

    for i=1, #inventory.items, 1 do

      local item = inventory.items[i]

      if item.count > 0 then
        table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
      end

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count',
          {
            title = 'Quantité'
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification('Quantité Invalide')
            else
              menu2.close()
              menu.close()
              OpenPutStocksBanditsMenu()

              TriggerServerEvent('esx_podolskaia:putStockItemsBandits', itemName, count)
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

---------------------------
--------MARCHE NOIR--------
---------------------------
function OpenArmoryMenu(station)

  if Config.EnableArmoryManagement then

    local elements = {
      {label = _U('get_weapon'), value = 'get_weapon'},
      {label = _U('put_weapon'), value = 'put_weapon'}
      -- {label = _U('buy_weapons'), value = 'buy_weapons'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory',
      {
        title    = _U('armory'),
        align    = 'right',
        elements = elements,
      },
      function(data, menu)

        if data.current.value == 'get_weapon' then
          OpenGetWeaponBanditsMenu(station)
        end

        if data.current.value == 'put_weapon' then
          OpenPutWeaponBanditsMenu(station)
        end

        -- if data.current.value == 'buy_weapons' then
          -- OpenBuyWeaponsMenu(station)
        -- end

      end,
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_armory'
        CurrentActionMsg  = _U('open_armory')
        CurrentActionData = {station = station}
      end
    )

  else

    local elements = {}

    for i=1, #Config.BanditsStations[station].AuthorizedWeapons, 1 do
      local weapon = Config.BanditsStations[station].AuthorizedWeapons[i]
      table.insert(elements, {label = ESX.GetWeaponLabel(weapon.name), value = weapon.name})
    end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory',
      {
        title    = _U('armory'),
        align    = 'right',
        elements = elements,
      },
      function(data, menu)
        local weapon = data.current.value
        TriggerServerEvent('esx_podolskaia:giveWeaponBandits', weapon,  1000)
      end,
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_armory'
        CurrentActionMsg  = _U('open_armory')
        CurrentActionData = {station = station}

      end
    )

  end

end
function OpenGetWeaponBanditsMenu(station)

  ESX.TriggerServerCallback('esx_podolskaia:getArmoryWeaponsBandits', function(weapons)

    local elements = {}

    for i=1, #weapons, 1 do
      if weapons[i].count > 0 then
        table.insert(elements, {label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name), value = weapons[i].name})
      end
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory_get_weapon',
      {
        title    = _U('get_weapon_menu'),
        align    = 'right',
        elements = elements,
      },
      function(data, menu)

        menu.close()

        ESX.TriggerServerCallback('esx_podolskaia:removeArmoryWeaponBandits', function()
          OpenGetWeaponBanditsMenu()
        end, data.current.value)

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenPutWeaponBanditsMenu(station)

  local elements   = {}
  local playerPed  = GetPlayerPed(-1)
  local weaponList = ESX.GetWeaponList()

  for i=1, #weaponList, 1 do

    local weaponHash = GetHashKey(weaponList[i].name)

    if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
      local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
      table.insert(elements, {label = weaponList[i].label, value = weaponList[i].name})
    end

  end

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'armory_put_weapon',
    {
      title    = _U('put_weapon_menu'),
      align    = 'right',
      elements = elements,
    },
    function(data, menu)

      menu.close()

      ESX.TriggerServerCallback('esx_podolskaia:addArmoryWeaponBandits', function()
        OpenPutWeaponBanditsMenu()
      end, data.current.value)

    end,
    function(data, menu)
      menu.close()
    end
  )

end

function OpenBuyWeaponsMenu(station)

  ESX.TriggerServerCallback('esx_podolskaia:getArmoryWeaponsBandits', function(weapons)

    local elements = {}

    for i=1, #Config.BanditsStations[station].AuthorizedWeapons, 1 do

      local weapon = Config.BanditsStations[station].AuthorizedWeapons[i]
      local count  = 0

      for i=1, #weapons, 1 do
        if weapons[i].name == weapon.name then
          count = weapons[i].count
          break
        end
      end

      table.insert(elements, {label = 'x' .. count .. ' ' .. ESX.GetWeaponLabel(weapon.name) .. ' $' .. weapon.price, value = weapon.name, price = weapon.price})

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory_buy_weapons',
      {
        title    = _U('buy_weapon_menu'),
        align    = 'right',
        elements = elements,
      },
      function(data, menu)

        ESX.TriggerServerCallback('esx_podolskaia:buyBandits', function(hasEnoughMoney)

          if hasEnoughMoney then
            ESX.TriggerServerCallback('esx_podolskaia:addArmoryWeaponBandits', function()
              OpenBuyWeaponsMenu(station)
            end, data.current.value)
          else
            ESX.ShowNotification(_U('not_enough_money'))
          end

        end, data.current.price)

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end
------------------------------
------------------------------
------------------------------



function OpenCryptedHarvestMenu()

  if Config.EnablePlayerManagement and PlayerData.job2 ~= nil and PlayerData.job2.grade_name ~= 'recrue' then
    local elements = {
      {label = 'Bouteille de Formoll', value = 'formol'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'bandits_harvest',
      {
        title    = 'Récup Formoll',
        elements = elements
      },
      function(data, menu)
        if data.current.value == 'formol' then
          menu.close()
          TriggerServerEvent('esx_podolskaia:startHarvestBandits')
        end
      end,
      function(data, menu)
        menu.close()
        CurrentAction     = 'bandits_harvest_menu'
        CurrentActionMsg  = 'Récup Formoll'
        CurrentActionData = {}
      end
    )
  else
    ESX.ShowNotification('Pas assez expérimenté')
  end
end



function OpenCryptedHarvest2Menu()

  if Config.EnablePlayerManagement and PlayerData.job2 ~= nil and PlayerData.job2.grade_name ~= 'recrue' then
    local elements = {
      {label = 'Puce de cryptage', value = 'puce'},
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'bandits_harvest',
      {
        title    = 'Récup Puce',
        elements = elements
      },
      function(data, menu)
        if data.current.value == 'puce' then
          menu.close()
          TriggerServerEvent('esx_podolskaia:startHarvest2Bandits')
        end
      end,
      function(data, menu)
        menu.close()
        CurrentAction     = 'bandits_harvest2_menu'
        CurrentActionMsg  = 'Récup Puce'
        CurrentActionData = {}
      end
    )
  else
    ESX.ShowNotification('Pas assez expérimenté')
  end
end

function OpenCryptedHarvest3Menu()

  if Config.EnablePlayerManagement and PlayerData.job2 ~= nil and PlayerData.job2.grade_name ~= 'recrue' then
    local elements = {
      {label = 'Spark Amélioré', value = 'spark'},
      {label = 'Bobine TESLA', value = 'tesla'},
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'bandits_harvest3',
      {
        title    = 'Matériel R&D',
        elements = elements
      },
      function(data, menu)

        if data.current.value == 'spark' then
          menu.close()
          TriggerServerEvent('esx_podolskaia:startHarvest3Bandits')
        end

        if data.current.value == 'tesla' then
          menu.close()
          TriggerServerEvent('esx_podolskaia:startHarvest4Bandits')
        end

      end,
      function(data, menu)
        menu.close()
        CurrentAction     = 'bandits_harvest3_menu'
        CurrentActionMsg  = 'Récup Bobine'
        CurrentActionData = {}
      end
    )
  else
    ESX.ShowNotification('Pas assez expérimenté')
  end
end

function OpenCryptedCraftMenu()
  if Config.EnablePlayerManagement and PlayerData.job2 ~= nil and PlayerData.job2.grade_name ~= 'recrue' then

    local elements = {
      {label = 'Sédatif', value = 'sedatif'},
      {label = 'SmartPhone Crypté', value = 'cryptedphone'},
      --{label = 'Bombe IEM - 10 Min', value = 'lightbreak'},

    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'bandits_craft',
      {
        elements = elements
      },
      function(data, menu)
        if data.current.value == 'sedatif' then
          menu.close()
          TriggerServerEvent('esx_podolskaia:startCraftBandits')
        end

        if data.current.value == 'cryptedphone' then
          menu.close()
          TriggerServerEvent('esx_podolskaia:startCraft2Bandits')
        end

        if data.current.value == 'lightbreak' then
          menu.close()
          TriggerServerEvent('esx_podolskaia:startCraft3Bandits')
        end

      end,
      function(data, menu)
        menu.close()
        CurrentAction     = 'bandits_craft_menu'
        CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu Production.'
        CurrentActionData = {}
      end
    )
  else
    ESX.ShowNotification('Vous n\'êtes ~r~pas assez expérimenté~s~ pour effectuer cette action.')
  end
end


AddEventHandler('esx_podolskaia:hasEnteredMarkerBandits', function(zone, station, part, partNum)

  if zone == 'CryptedActions' then
    CurrentAction     = 'bandits_actions_menu'
    CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
    CurrentActionData = {}
  end

  -- if zone == 'HarvestBandits' then
    -- CurrentAction     = 'bandits_harvest_menu'
    -- CurrentActionMsg  = 'Récup Formoll'
    -- CurrentActionData = {}
  -- end
  
  -- if zone == 'HarvestBandits2' then
    -- CurrentAction     = 'bandits_harvest2_menu'
    -- CurrentActionMsg  = 'Récup Puce'
    -- CurrentActionData = {}
  -- end

  -- if zone == 'HarvestBandits3' then
    -- CurrentAction     = 'bandits_harvest3_menu'
    -- CurrentActionMsg  = 'Récup R&D'
    -- CurrentActionData = {}
  -- end     

  -- if zone == 'CraftBandits' then
    -- CurrentAction     = 'bandits_craft_menu'
    -- CurrentActionMsg  = 'Menu Craft bandits'
    -- CurrentActionData = {}
  -- end

  if part == 'Armory' then
    CurrentAction     = 'menu_armory'
    CurrentActionMsg  = 'Marché Noir Armes'
    CurrentActionData = {station = station}
  end    

  -- if zone == 'VehicleDeleter' then

    -- local playerPed = GetPlayerPed(-1)

    -- if IsPedInAnyVehicle(playerPed,  false) then
      -- CurrentAction     = 'delete_vehicle'
      -- CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour ranger le véhicule.'
      -- CurrentActionData = {}
    -- end

  -- end

end)


AddEventHandler('esx_podolskaia:hasExitedMarkerBandits', function(zone, station, part, partNum)

  if zone == 'HarvestBandits' then
    TriggerServerEvent('esx_podolskaia:stopHarvestBandits')
  end

  if zone == 'HarvestBandits2' then
    TriggerServerEvent('esx_podolskaia:stopHarvest2Bandits')
  end  

  if zone == 'HarvestBandits3' then
    TriggerServerEvent('esx_podolskaia:stopHarvest3Bandits')
    TriggerServerEvent('esx_podolskaia:stopHarvest4Bandits')
  end
  
  if zone == 'CraftBandits' then
    TriggerServerEvent('esx_podolskaia:stopCraftBandits')
    TriggerServerEvent('esx_podolskaia:stopCraft2Bandits')
    TriggerServerEvent('esx_podolskaia:stopCraft3Bandits')
  end

  ESX.UI.Menu.CloseAll()
  CurrentAction = nil
end)





RegisterNetEvent('esx_cryptedhone:loaded')
AddEventHandler('esx_cryptedhone:loaded', function(phoneNumber, contacts)

  local specialContact = {
    name       = 'podolskaia',
    number     = 'podolskaia',
    base64Icon = 'data:image/png;base64,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'
  }

  TriggerEvent('esx_cryptedhone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)

end)

-- Display markers
Citizen.CreateThread(function()
  while true do

    Wait(0)

    if PlayerData.job2 ~= nil and PlayerData.job2.name == 'podolskaia' then

          local playerPed = GetPlayerPed(-1)
          local coords = GetEntityCoords(GetPlayerPed(-1))

        for k,v in pairs(Config.Zones2) do
          if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
            DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
          end
        end

        for k,v in pairs(Config.BanditsStations) do
          for i=1, #v.Armories, 1 do
            if GetDistanceBetweenCoords(coords,  v.Armories[i].x,  v.Armories[i].y,  v.Armories[i].z,  true) < Config.DrawDistance then
              DrawMarker(Config.MarkerType, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
            end
          end 
        end
    
    end

  end
end)


-- Enter / Exit marker events
Citizen.CreateThread(function()
  while true do

    Wait(0)

    if PlayerData.job2 ~= nil and PlayerData.job2.name == 'podolskaia' then

      local coords      = GetEntityCoords(GetPlayerPed(-1))
      local isInMarker  = false
      local currentZone = nil
      local currentStation = nil
      local currentPart    = nil
      local currentPartNum = nil

      for k,v in pairs(Config.Zones2) do
        if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
          isInMarker  = true
          currentZone = k
        end
      end

      for k,v in pairs(Config.BanditsStations) do

        for i=1, #v.Armories, 1 do
          if GetDistanceBetweenCoords(coords,  v.Armories[i].x,  v.Armories[i].y,  v.Armories[i].z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'Armory'
            currentPartNum = i
          end
        end

      end      

      local hasExited = false

      if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastZone ~= currentZone or LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum) ) then

        if
          (LastZone ~= nil and LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
          (LastZone ~= currentZone or LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
        then
          TriggerEvent('esx_podolskaia:hasExitedMarkerBandits', LastZone, LastStation, LastPart, LastPartNum)
          hasExited = true
        end

        HasAlreadyEnteredMarker = true
        LastZone                = currentZone
        LastStation             = currentStation
        LastPart                = currentPart
        LastPartNum             = currentPartNum

        TriggerEvent('esx_podolskaia:hasEnteredMarkerBandits', currentZone, currentStation, currentPart, currentPartNum)
      end

      if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
        HasAlreadyEnteredMarker = false
        TriggerEvent('esx_podolskaia:hasExitedMarkerBandits', LastZone, LastStation, LastPart, LastPartNum)
      end  

    end

  end
end)


-- Key Controls
Citizen.CreateThread(function()
  while true do

    Citizen.Wait(1)

    if CurrentAction ~= nil then

      SetTextComponentFormat('STRING')
      AddTextComponentString(CurrentActionMsg)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)

      if IsControlPressed(0,  Keys['E']) and PlayerData.job2 ~= nil and PlayerData.job2.name == 'podolskaia' and (GetGameTimer() - GUI.Time) > 300 then

        if CurrentAction == 'bandits_actions_menu' then
          OpenBanditsActionsMenu()
        end
            
        if CurrentAction == 'menu_armory' then
          OpenArmoryMenu(CurrentActionData.station)
        end                     

        CurrentAction = nil
        GUI.Time      = GetGameTimer()

      end

    end
  end
end)


-----------------------
----- TELEPORTERS -----

AddEventHandler('esx_podolskaia:teleportMarkers', function(position)
  SetEntityCoords(GetPlayerPed(-1), position.x, position.y, position.z)
end)

-- Show top left hint
Citizen.CreateThread(function()
  while true do
    Wait(0)
    if hintIsShowed == true then
      SetTextComponentFormat("STRING")
      AddTextComponentString(hintToDisplay)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)
    end
  end
end)


function OpenGetBlackMoney()

  ESX.TriggerServerCallback('esx_podolskaia:getBlackMoneySociety', function(inventory)

    local elements = {}

    table.insert(elements, {label = 'Argent sale : ' .. inventory.blackMoney, type = 'item_account', value = 'black_money'})

    for i=1, #inventory.items, 1 do

      local item = inventory.items[i]

      if item.count > 0 then
        table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
      end
    end

    for i=1, #inventory.weapons, 1 do
      local weapon = inventory.weapons[i]
      table.insert(elements, {label = ESX.GetWeaponLabel(weapon.name) .. ' [' .. weapon.ammo .. ']', type = 'item_weapon', value = weapon.name, ammo = weapon.ammo})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'get_black_money',
      {
        align    = 'right',
        elements = elements,
      },
      function(data, menu)
        if data.current.type == 'item_weapon' then
          menu.close()
          TriggerServerEvent('esx_podolskaia:getItem', data.current.type, data.current.value, data.current.ammo)
          ESX.SetTimeout(300, function()
            OpenGetBlackMoney()
          end)

        else
          ESX.UI.Menu.Open(
            'dialog', GetCurrentResourceName(), 'get_item_count',
            {
              title = 'Montant',
            },
            function(data2, menu)

              local quantity = tonumber(data2.value)

              if quantity == nil then
                ESX.ShowNotification('Montant invalide')
              else
                menu.close()
                TriggerServerEvent('esx_podolskaia:getItem', data.current.type, data.current.value, quantity)
                ESX.SetTimeout(300, function()
                  OpenGetBlackMoney()
                end)
              end
            end,
            function(data2,menu)
              menu.close()
            end
          )
        end
      end,
      function(data, menu)
        menu.close()
      end
    )
  end)
end

function OpenPutBlackMoney()

  ESX.TriggerServerCallback('esx_podolskaia:getPlayerInventory2', function(inventory)

    local elements = {}

    table.insert(elements, {label = 'Argent sale : ' .. inventory.blackMoney, type = 'item_account', value = 'black_money'})

    local playerPed  = GetPlayerPed(-1)
    local weaponList = ESX.GetWeaponList()

    for i=1, #weaponList, 1 do
      local weaponHash = GetHashKey(weaponList[i].name)

      if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
        local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
        table.insert(elements, {label = weaponList[i].label .. ' [' .. ammo .. ']', type = 'item_weapon', value = weaponList[i].name, ammo = ammo})
      end
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'put_black_money',
      {
        align    = 'right',
        elements = elements,
      },
      function(data, menu)

        if data.current.type == 'item_weapon' then

          menu.close()

          TriggerServerEvent('esx_podolskaia:putItem', data.current.type, data.current.value, data.current.ammo)

          ESX.SetTimeout(300, function()
            OpenPutBlackMoney()
          end)
        else

          ESX.UI.Menu.Open(
            'dialog', GetCurrentResourceName(), 'put_item_count',
            {
              title = 'Montant',
            },
            function(data2, menu)

              menu.close()

              TriggerServerEvent('esx_podolskaia:putItem', data.current.type, data.current.value, tonumber(data2.value))

              ESX.SetTimeout(300, function()
                OpenPutBlackMoney()
              end)

            end,
            function(data2,menu)
              menu.close()
            end
          )

        end

      end,
      function(data, menu)
        menu.close()
      end
    )
  end)
end

---------------------------------
--- Copyright by ikNox#6088 ---
---------------------------------