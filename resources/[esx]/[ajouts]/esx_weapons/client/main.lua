ESX                           = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(1)
  end
end)


function GetHashName(table, hash)
  local name ='null'
  local hashName ='null'
  for k,v in pairs(table) do
      if GetHashKey(k) == hash then
        hashName = GetHashKey(k)
        name = k
        return hashName, name
      end 
  end
end

RegisterNetEvent('esx_weapons:components')
AddEventHandler('esx_weapons:components', function(component)

  local playerPed               = GetPlayerPed(-1)
  local currentWeaponHash       = GetSelectedPedWeapon(playerPed)
  local weaponHash, weaponName  = GetHashName(Config.WeaponsComponentsList, currentWeaponHash)

  if currentWeaponHash == weaponHash then
    if component == 'COMPONENT_AT_PI_FLSH' and Config.WeaponsComponentsList[weaponName]['flashlight'] ~= nil then
      componentName = Config.WeaponsComponentsList[weaponName]['flashlight']
      componentHash = GetHashKey(componentName)
    elseif component == 'COMPONENT_AT_PI_SUPP' and Config.WeaponsComponentsList[weaponName]['suppressorP'] ~= nil then
      componentName = Config.WeaponsComponentsList[weaponName]['suppressorP']
      componentHash = GetHashKey(componentName)
    elseif component == 'COMPONENT_AT_AR_SUPP_02' and Config.WeaponsComponentsList[weaponName]['suppressorR'] ~= nil  then
      componentName = Config.WeaponsComponentsList[weaponName]['suppressorR']
      componentHash = GetHashKey(componentName)
    elseif component == 'COMPONENT_AT_SCOPE_MACRO' and Config.WeaponsComponentsList[weaponName]['scope'] ~= nil  then
      componentName = Config.WeaponsComponentsList[weaponName]['scope']
      componentHash = GetHashKey(componentName)
    elseif component == 'COMPONENT_AT_PI_CLIP_02' and Config.WeaponsComponentsList[weaponName]['clipP'] ~= nil  then
      componentName = Config.WeaponsComponentsList[weaponName]['clipP']
      componentHash = GetHashKey(componentName)
    elseif component == 'COMPONENT_AT_AR_CLIP_02' and Config.WeaponsComponentsList[weaponName]['clipR'] ~= nil  then
      componentName = Config.WeaponsComponentsList[weaponName]['clipR']
      componentHash = GetHashKey(componentName)
    elseif component == 'COMPONENT_AT_AR_CLIP_03' and Config.WeaponsComponentsList[weaponName]['clipR2'] ~= nil  then
      componentName = Config.WeaponsComponentsList[weaponName]['clipR2']
      componentHash = GetHashKey(componentName)
    elseif component == 'COMPONENT_VARMOD_LUXE' and Config.WeaponsComponentsList[weaponName]['luxe'] ~= nil  then
      componentName = Config.WeaponsComponentsList[weaponName]['luxe']
      componentHash = GetHashKey(componentName)
    elseif component == 'COMPONENT_VARMOD_LOWRIDER' and Config.WeaponsComponentsList[weaponName]['lowrider'] ~= nil  then
      componentName = Config.WeaponsComponentsList[weaponName]['lowrider']
      componentHash = GetHashKey(componentName)
    elseif component == 'COMPONENT_MK2_CAMO' and Config.WeaponsComponentsList[weaponName]['cam_01'] ~= nil then
      componentName = Config.WeaponsComponentsList[weaponName]['cam_01']
      componentHash = GetHashKey(componentName)
    elseif component == 'COMPONENT_MK2_CAMO_02' and Config.WeaponsComponentsList[weaponName]['cam_02'] ~= nil then
      componentName = Config.WeaponsComponentsList[weaponName]['cam_02']
      componentHash = GetHashKey(componentName)
    elseif component == 'COMPONENT_MK2_CAMO_03' and Config.WeaponsComponentsList[weaponName]['cam_03'] ~= nil then
      componentName = Config.WeaponsComponentsList[weaponName]['cam_03']
      componentHash = GetHashKey(componentName)
    elseif component == 'COMPONENT_MK2_CAMO_04' and Config.WeaponsComponentsList[weaponName]['cam_04'] ~= nil then
      componentName = Config.WeaponsComponentsList[weaponName]['cam_04']
      componentHash = GetHashKey(componentName)
    elseif component == 'COMPONENT_MK2_CAMO_05' and Config.WeaponsComponentsList[weaponName]['cam_05'] ~= nil then
      componentName = Config.WeaponsComponentsList[weaponName]['cam_05']
      componentHash = GetHashKey(componentName)
    elseif component == 'COMPONENT_MK2_CAMO_06' and Config.WeaponsComponentsList[weaponName]['cam_06'] ~= nil then
      componentName = Config.WeaponsComponentsList[weaponName]['cam_06']
      componentHash = GetHashKey(componentName)
    elseif component == 'COMPONENT_MK2_CAMO_07' and Config.WeaponsComponentsList[weaponName]['cam_07'] ~= nil then
      componentName = Config.WeaponsComponentsList[weaponName]['cam_07']
      componentHash = GetHashKey(componentName)
    elseif component == 'COMPONENT_MK2_CAMO_08' and Config.WeaponsComponentsList[weaponName]['cam_08'] ~= nil then
      componentName = Config.WeaponsComponentsList[weaponName]['cam_08']
      componentHash = GetHashKey(componentName)
    elseif component == 'COMPONENT_MK2_CAMO_09' and Config.WeaponsComponentsList[weaponName]['cam_09'] ~= nil then
      componentName = Config.WeaponsComponentsList[weaponName]['cam_09']
      componentHash = GetHashKey(componentName)
    elseif component == 'COMPONENT_MK2_CAMO_10' and Config.WeaponsComponentsList[weaponName]['cam_10'] ~= nil then
      componentName = Config.WeaponsComponentsList[weaponName]['cam_10']
      componentHash = GetHashKey(componentName)
    elseif component == 'COMPONENT_MK2_CAMO_IND_01' and Config.WeaponsComponentsList[weaponName]['cam_11'] ~= nil then
      componentName = Config.WeaponsComponentsList[weaponName]['cam_11']
      componentHash = GetHashKey(componentName)
    else
      componentHash = GetHashKey(component)
    end
  else
    componentHash = GetHashKey(component)
  end
  
  if HasPedGotWeapon(playerPed, currentWeaponHash, false) then -- Test if player have the Weapon
    if HasPedGotWeaponComponent(playerPed, currentWeaponHash, componentHash) then -- Test if player Already have the component in his Weapon
      RemoveWeaponComponentFromPed(playerPed, currentWeaponHash, componentHash)
    else
      GiveWeaponComponentToPed(playerPed, currentWeaponHash, componentHash)
    end
  end

end)

function IsInList(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

RegisterNetEvent('esx_weapons:removeComponent')
AddEventHandler('esx_weapons:removeComponent', function(component)
  
  local playerPed = GetPlayerPed(-1)
  local componentHash = GetHashKey(component)
  for _,v in pairs(Config.WeaponList) do

    weaponHash = GetHashKey(v)

    if (v == 'WEAPON_PISTOL_MK2' or v == 'WEAPON_SMG_MK2') and component == 'COMPONENT_AT_PI_FLSH' then
      componentHash = GetHashKey('COMPONENT_AT_PI_FLSH_02')
    elseif v =='WEAPON_PISTOL_MK2' and component =='COMPONENT_AT_PI_SUPP' then
      componentHash = GetHashKey('COMPONENT_AT_PI_SUPP_02')
    elseif v =='WEAPON_MARKSMANRIFLE' and component =='COMPONENT_AT_AR_SUPP_02' then
      componentHash = GetHashKey('COMPONENT_AT_AR_SUPP')
    elseif (v =='WEAPON_SMG_MK2' or v == 'WEAPON_SMG') and component =='COMPONENT_AT_AR_SUPP_02' then
      componentHash = GetHashKey('COMPONENT_AT_PI_SUPP')
    elseif v =='WEAPON_SMG_MK2' and component =='COMPONENT_AT_SCOPE_MACRO' then
      componentHash = GetHashKey('COMPONENT_AT_SCOPE_SMALL_SMG_MK2')
    elseif v =='WEAPON_PISTOL_MK2' and component =='COMPONENT_AT_PI_CLIP_02' then
      componentHash = GetHashKey('COMPONENT_PISTOL_MK2_CLIP_02')
    elseif v =='WEAPON_SNSPISTOL' and component =='COMPONENT_AT_PI_CLIP_02' then
      componentHash = GetHashKey('COMPONENT_SNSPISTOL_CLIP_02')
    elseif v =='WEAPON_COMBATPISTOL' and component =='COMPONENT_AT_PI_CLIP_02' then
      componentHash = GetHashKey('COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER')
    elseif v =='WEAPON_HEAVYPISTOL' and component =='COMPONENT_AT_PI_CLIP_02' then
      componentHash = GetHashKey('COMPONENT_HEAVYPISTOL_CLIP_02')
    elseif v =='WEAPON_SMG_MK2' and component =='COMPONENT_AT_AR_CLIP_02' then
      componentHash = GetHashKey('COMPONENT_SMG_MK2_CLIP_02')
    elseif v =='WEAPON_ASSAULTSMG' and component =='COMPONENT_AT_AR_CLIP_02' then
      componentHash = GetHashKey('COMPONENT_ASSAULTSMG_CLIP_02')
    elseif v =='WEAPON_ASSAULTRIFLE' and component =='COMPONENT_AT_AR_CLIP_02' then
      componentHash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_02')
    elseif v =='WEAPON_SMG' and component =='COMPONENT_AT_AR_CLIP_02' then
      componentHash = GetHashKey('COMPONENT_SMG_CLIP_02')
    elseif v =='WEAPON_MARKSMANRIFLE' and component =='COMPONENT_AT_AR_CLIP_02' then
      componentHash = GetHashKey('COMPONENT_MARKSMANRIFLE_CLIP_02')
    elseif v =='WEAPON_ASSAULTRIFLE' and component =='COMPONENT_AT_AR_CLIP_03' then
      componentHash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_03')
    elseif v =='WEAPON_SMG' and component =='COMPONENT_AT_AR_CLIP_03' then
      componentHash = GetHashKey('COMPONENT_SMG_CLIP_03')
    elseif v =='WEAPON_ASSAULTRIFLE' and component =='COMPONENT_VARMOD_LUXE' then
      componentHash = GetHashKey('COMPONENT_ASSAULTRIFLE_VARMOD_LUXE')
    elseif v =='WEAPON_SMG' and component =='COMPONENT_VARMOD_LUXE' then
      componentHash = GetHashKey('COMPONENT_SMG_VARMOD_LUXE')
    elseif v =='WEAPON_HEAVYPISTOL' and component =='COMPONENT_VARMOD_LUXE' then
      componentHash = GetHashKey('COMPONENT_HEAVYPISTOL_VARMOD_LUXE')
    elseif v =='WEAPON_SAWNOFFSHOTGUN' and component =='COMPONENT_VARMOD_LUXE' then
      componentHash = GetHashKey('COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE')
    elseif v =='WEAPON_ASSAULTSMG' and component =='COMPONENT_VARMOD_LOWRIDER' then
      componentHash = GetHashKey('COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER')
    elseif v =='WEAPON_SNSPISTOL' and component =='COMPONENT_VARMOD_LOWRIDER' then
      componentHash = GetHashKey('COMPONENT_SNSPISTOL_VARMOD_LOWRIDER')
    elseif v =='WEAPON_COMBATPISTOL' and component =='COMPONENT_VARMOD_LOWRIDER' then
      componentHash = GetHashKey('COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER')
    else
      componentHash = GetHashKey(component)
    end

    weaponHash = GetHashKey(v)

    if HasPedGotWeaponComponent(playerPed, weaponHash, componentHash) then -- Test if player Already have the component in his Weapon
      RemoveWeaponComponentFromPed(playerPed, weaponHash, componentHash)
    end

  end

end)

RegisterNetEvent('esx_weapons:addWeapon')
AddEventHandler('esx_weapons:addWeapon', function(weapon)
  
  local playerPed = GetPlayerPed(-1)
  local _weapon   = GetHashKey(weapon)

  if not HasPedGotWeapon(playerPed, _weapon, false) then -- Test if player have the Weapon
    GiveWeaponToPed(playerPed, _weapon, 200, false, false)
  end

end)


RegisterNetEvent('esx_weapons:removeWeapon')
AddEventHandler('esx_weapons:removeWeapon', function(weapon)
  
  local playerPed = GetPlayerPed(-1)
  local _weapon   = GetHashKey(weapon)

  if HasPedGotWeapon(playerPed, _weapon, false) then -- Test if player have the Weapon
    RemoveWeaponFromPed(playerPed, _weapon)
  end

end)


RegisterNetEvent('esx_weapons:tints')
AddEventHandler('esx_weapons:tints', function(value)
  
  local playerPed   = GetPlayerPed(-1)
  local weaponName  = GetSelectedPedWeapon(playerPed)

  if HasPedGotWeapon(playerPed, weaponName, false) then -- Test if player have the Weapon
    SetPedWeaponTintIndex(playerPed, weaponName, value)
  end
  
end)


RegisterNetEvent('esx_weapons:compTints')
AddEventHandler('esx_weapons:compTints', function(value)

  local playerPed     = GetPlayerPed(-1)
  local weaponName    = GetSelectedPedWeapon(playerPed)
  local pistolMk2     = GetHashKey('WEAPON_PISTOL_MK2')
  local smgMk2        = GetHashKey('WEAPON_SMG_MK2')

  if weaponName == pistolMk2 or weaponName == smgMk2 then
    for _,v in pairs(Config.CamoList) do
      local camoName  = GetHashKey(v)
      if HasPedGotWeaponComponent(playerPed, weaponName, camoName) then
        Citizen.InvokeNative(0x9FE5633880ECD8ED, playerPed, weaponName, camoName, value) -- tint component color
      end
    end
  else
    ESX.ShowNotification("~r~Vous n'avez pas l'arme adéquate pour faire cela !~s~")
  end

end)

---------------------------------
--------- ikNox#6088 ------------
---------------------------------