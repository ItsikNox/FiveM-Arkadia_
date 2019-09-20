ESX               = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


function IsInList(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

RegisterServerEvent('esx:onAddInventoryItem')
AddEventHandler('esx:onAddInventoryItem', function(source, item, count)
  local _source = source
  local _item = item.name
  if IsInList(Config.WeaponList, _item) and item.count >= 1 then
    TriggerClientEvent('esx_weapons:addWeapon', _source, _item)
  end
end)

RegisterServerEvent('esx:onRemoveInventoryItem')
AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
  local _source = source
  local _item = item.name
  if IsInList(Config.WeaponList, _item) and item.count < 1 then
    TriggerClientEvent('esx_weapons:removeWeapon', _source, _item)
  end
  if IsInList(Config.ComponentList, _item) and item.count < 1 then
    TriggerClientEvent('esx_weapons:removeComponent', _source, _item)
  end
end)

RegisterNetEvent('esx_weapons:loadWeapons')
AddEventHandler('esx_weapons:loadWeapons', function()
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  for i=1, #xPlayer.inventory, 1 do
    local weaponName  = xPlayer.inventory[i].name
    local weaponCount = xPlayer.inventory[i].count
    if IsInList(Config.WeaponList, weaponName) and weaponCount > 0 then
      TriggerClientEvent('esx_weapons:addWeapon', _source, weaponName)
    end
  end
end)


------------------------------
------ COMPONENT ITEMS -------
------------------------------

-- PISTOL SUPPRESSOR
ESX.RegisterUsableItem('COMPONENT_AT_PI_SUPP', function(source)
  local component = 'COMPONENT_AT_PI_SUPP'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
-- RIFLE SUPPRESSOR
ESX.RegisterUsableItem('COMPONENT_AT_AR_SUPP_02', function(source)
  local component = 'COMPONENT_AT_AR_SUPP_02'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
-- PISTOL FLASHLIGHT
ESX.RegisterUsableItem('COMPONENT_AT_PI_FLSH', function(source)
  local component = 'COMPONENT_AT_PI_FLSH'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
-- RIFLE FLASHLIGHT
ESX.RegisterUsableItem('COMPONENT_AT_AR_FLSH', function(source)
  local component = 'COMPONENT_AT_AR_FLSH'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
-- RIFLE GRIP
ESX.RegisterUsableItem('COMPONENT_AT_AR_AFGRIP', function(source)
  local component = 'COMPONENT_AT_AR_AFGRIP'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
-- PISTOL CLIP
ESX.RegisterUsableItem('COMPONENT_AT_PI_CLIP_02', function(source)
  local component = 'COMPONENT_AT_PI_CLIP_02'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
-- RIFLE CLIP
ESX.RegisterUsableItem('COMPONENT_AT_AR_CLIP_02', function(source)
  local component = 'COMPONENT_AT_AR_CLIP_02'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
-- RIFLE EXTENDED CLIP
ESX.RegisterUsableItem('COMPONENT_AT_AR_CLIP_03', function(source)
  local component = 'COMPONENT_AT_AR_CLIP_03'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
-- RIFLE SCOPE
ESX.RegisterUsableItem('COMPONENT_AT_SCOPE_MACRO', function(source)
  local component = 'COMPONENT_AT_SCOPE_MACRO'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
-- FINISH LUXE
ESX.RegisterUsableItem('COMPONENT_VARMOD_LUXE', function(source)
  local component = 'COMPONENT_VARMOD_LUXE'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
-- FINISH LOWRIDER
ESX.RegisterUsableItem('COMPONENT_VARMOD_LOWRIDER', function(source)
  local component = 'COMPONENT_VARMOD_LOWRIDER'
  TriggerClientEvent('esx_weapons:components', source, component)
end)

-- REVOLVER
ESX.RegisterUsableItem('COMPONENT_REVOLVER_VARMOD_BOSS', function(source)
  local component = 'COMPONENT_REVOLVER_VARMOD_BOSS'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
ESX.RegisterUsableItem('COMPONENT_REVOLVER_VARMOD_GOON', function(source)
  local component = 'COMPONENT_REVOLVER_VARMOD_GOON'
  TriggerClientEvent('esx_weapons:components', source, component)
end)

-- PISTOL MK2
ESX.RegisterUsableItem('COMPONENT_AT_PI_COMP', function(source)
  local component = 'COMPONENT_AT_PI_COMP'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
ESX.RegisterUsableItem('COMPONENT_AT_PI_RAIL', function(source)
  local component = 'COMPONENT_AT_PI_RAIL'
  TriggerClientEvent('esx_weapons:components', source, component)
end)

-- SMG MK2
ESX.RegisterUsableItem('COMPONENT_AT_SIGHTS_SMG', function(source)
  local component = 'COMPONENT_AT_SIGHTS_SMG'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
ESX.RegisterUsableItem('COMPONENT_AT_MUZZLE_03', function(source)
  local component = 'COMPONENT_AT_MUZZLE_03'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
ESX.RegisterUsableItem('COMPONENT_AT_SB_BARREL_02', function(source)
  local component = 'COMPONENT_AT_SB_BARREL_02'
  TriggerClientEvent('esx_weapons:components', source, component)
end)

-- SWITCHBLADE
ESX.RegisterUsableItem('COMPONENT_SWITCHBLADE_VARMOD_VAR1', function(source)
  local component = 'COMPONENT_SWITCHBLADE_VARMOD_VAR1'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
ESX.RegisterUsableItem('COMPONENT_SWITCHBLADE_VARMOD_VAR2', function(source)
  local component = 'COMPONENT_SWITCHBLADE_VARMOD_VAR2'
  TriggerClientEvent('esx_weapons:components', source, component)
end)

-- KNUCKLE
ESX.RegisterUsableItem('COMPONENT_KNUCKLE_VARMOD_PIMP', function(source)
  local component = 'COMPONENT_KNUCKLE_VARMOD_PIMP'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
ESX.RegisterUsableItem('COMPONENT_KNUCKLE_VARMOD_BALLAS', function(source)
  local component = 'COMPONENT_KNUCKLE_VARMOD_BALLAS'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
ESX.RegisterUsableItem('COMPONENT_KNUCKLE_VARMOD_DOLLAR', function(source)
  local component = 'COMPONENT_KNUCKLE_VARMOD_DOLLAR'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
ESX.RegisterUsableItem('COMPONENT_KNUCKLE_VARMOD_DIAMOND', function(source)
  local component = 'COMPONENT_KNUCKLE_VARMOD_DIAMOND'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
ESX.RegisterUsableItem('COMPONENT_KNUCKLE_VARMOD_HATE', function(source)
  local component = 'COMPONENT_KNUCKLE_VARMOD_HATE'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
ESX.RegisterUsableItem('COMPONENT_KNUCKLE_VARMOD_LOVE', function(source)
  local component = 'COMPONENT_KNUCKLE_VARMOD_LOVE'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
ESX.RegisterUsableItem('COMPONENT_KNUCKLE_VARMOD_PLAYER', function(source)
  local component = 'COMPONENT_KNUCKLE_VARMOD_PLAYER'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
ESX.RegisterUsableItem('COMPONENT_KNUCKLE_VARMOD_KING', function(source)
  local component = 'COMPONENT_KNUCKLE_VARMOD_KING'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
ESX.RegisterUsableItem('COMPONENT_KNUCKLE_VARMOD_VAGOS', function(source)
  local component = 'COMPONENT_KNUCKLE_VARMOD_VAGOS'
  TriggerClientEvent('esx_weapons:components', source, component)
end)

------------------------------
------------------------------

------------------------------
---- COMPONENT CAMO ITEMS ----
------------------------------
ESX.RegisterUsableItem('COMPONENT_MK2_CAMO', function(source)
  local component = 'COMPONENT_MK2_CAMO'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
ESX.RegisterUsableItem('COMPONENT_MK2_CAMO_01', function(source)
  local component = 'COMPONENT_MK2_CAMO_01'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
ESX.RegisterUsableItem('COMPONENT_MK2_CAMO_02', function(source)
  local component = 'COMPONENT_MK2_CAMO_02'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
ESX.RegisterUsableItem('COMPONENT_MK2_CAMO_03', function(source)
  local component = 'COMPONENT_MK2_CAMO_03'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
ESX.RegisterUsableItem('COMPONENT_MK2_CAMO_04', function(source)
  local component = 'COMPONENT_MK2_CAMO_04'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
ESX.RegisterUsableItem('COMPONENT_MK2_CAMO_05', function(source)
  local component = 'COMPONENT_MK2_CAMO_05'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
ESX.RegisterUsableItem('COMPONENT_MK2_CAMO_06', function(source)
  local component = 'COMPONENT_MK2_CAMO_06'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
ESX.RegisterUsableItem('COMPONENT_MK2_CAMO_07', function(source)
  local component = 'COMPONENT_MK2_CAMO_07'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
ESX.RegisterUsableItem('COMPONENT_MK2_CAMO_08', function(source)
  local component = 'COMPONENT_MK2_CAMO_08'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
ESX.RegisterUsableItem('COMPONENT_MK2_CAMO_09', function(source)
  local component = 'COMPONENT_MK2_CAMO_09'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
ESX.RegisterUsableItem('COMPONENT_MK2_CAMO_10', function(source)
  local component = 'COMPONENT_MK2_CAMO_10'
  TriggerClientEvent('esx_weapons:components', source, component)
end)
ESX.RegisterUsableItem('COMPONENT_MK2_CAMO_IND_01', function(source)
  local component = 'COMPONENT_MK2_CAMO_IND_01'
  TriggerClientEvent('esx_weapons:components', source, component)
end)

------------------------------
------------------------------

------------------------------
---- COMPONENT TINT ITEMS ----
------------------------------

ESX.RegisterUsableItem('COMPONENT_TINT_01', function(source)
  local tintComponent = 1
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_02', function(source)
  local tintComponent = 2
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_03', function(source)
  local tintComponent = 3
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_04', function(source)
  local tintComponent = 4
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_05', function(source)
  local tintComponent = 5
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_06', function(source)
  local tintComponent = 6
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_07', function(source)
  local tintComponent = 7
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_08', function(source)
  local tintComponent = 8
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_09', function(source)
  local tintComponent = 9
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_10', function(source)
  local tintComponent = 10
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_11', function(source)
  local tintComponent = 11
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_12', function(source)
  local tintComponent = 12
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_13', function(source)
  local tintComponent = 13
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_14', function(source)
  local tintComponent = 14
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_15', function(source)
  local tintComponent = 15
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_16', function(source)
  local tintComponent = 16
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_17', function(source)
  local tintComponent = 17
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_18', function(source)
  local tintComponent = 18
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_19', function(source)
  local tintComponent = 19
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_20', function(source)
  local tintComponent = 20
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_21', function(source)
  local tintComponent = 21
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_22', function(source)
  local tintComponent = 22
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_23', function(source)
  local tintComponent = 23
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_24', function(source)
  local tintComponent = 24
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_25', function(source)
  local tintComponent = 25
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_26', function(source)
  local tintComponent = 26
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_27', function(source)
  local tintComponent = 27
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_28', function(source)
  local tintComponent = 28
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_29', function(source)
  local tintComponent = 29
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_30', function(source)
  local tintComponent = 30
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)
ESX.RegisterUsableItem('COMPONENT_TINT_31', function(source)
  local tintComponent = 31
  TriggerClientEvent('esx_weapons:compTints', source, tintComponent)
end)

------------------------------
------------------------------

------------------------------
--------- TINT ITEMS ---------
------------------------------

ESX.RegisterUsableItem('TINT_01', function(source)
  local tint = 1
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_02', function(source)
  local tint = 2
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_03', function(source)
  local tint = 3
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_04', function(source)
  local tint = 4
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_05', function(source)
  local tint = 5
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_06', function(source)
  local tint = 6
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_07', function(source)
  local tint = 7
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_01', function(source)
  local tint = 1
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_02', function(source)
  local tint = 2
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_03', function(source)
  local tint = 3
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_04', function(source)
  local tint = 4
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_05', function(source)
  local tint = 5
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_06', function(source)
  local tint = 6
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_07', function(source)
  local tint = 7
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_08', function(source)
  local tint = 8
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_09', function(source)
  local tint = 9
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_10', function(source)
  local tint = 10
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_11', function(source)
  local tint = 11
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_12', function(source)
  local tint = 12
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_13', function(source)
  local tint = 13
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_14', function(source)
  local tint = 14
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_15', function(source)
  local tint = 15
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_16', function(source)
  local tint = 16
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_17', function(source)
  local tint = 17
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_18', function(source)
  local tint = 18
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_19', function(source)
  local tint = 19
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_20', function(source)
  local tint = 20
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_21', function(source)
  local tint = 21
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_22', function(source)
  local tint = 22
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_23', function(source)
  local tint = 23
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_24', function(source)
  local tint = 24
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_25', function(source)
  local tint = 25
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_26', function(source)
  local tint = 26
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_27', function(source)
  local tint = 27
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_28', function(source)
  local tint = 28
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_29', function(source)
  local tint = 29
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_30', function(source)
  local tint = 30
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)
ESX.RegisterUsableItem('TINT_MK2_31', function(source)
  local tint = 31
  TriggerClientEvent('esx_weapons:tints', source, tint)
end)

------------------------------
------------------------------