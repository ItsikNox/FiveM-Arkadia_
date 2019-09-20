local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,["-"] = 84,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


ESX                           = nil
local GUI      = {}
local PlayerData                = {}
local lastVehicle = nil
local lastOpen = false
GUI.Time                      = 0
local vehiclePlate = {}
local arrayWeight = Config.localWeight
local CloseToVehicle = false
local entityWorld = nil
local globalplate = nil
local lastChecked					= 0

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  	PlayerData = xPlayer
		TriggerServerEvent("esx_trunk_inventory:getOwnedVehicule")
		lastChecked = GetGameTimer()
end)

AddEventHandler('onResourceStart', function()
  PlayerData = xPlayer
	TriggerServerEvent("esx_trunk_inventory:getOwnedVehicule")
	lastChecked = GetGameTimer()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
  PlayerData.job2 = job2
end)

RegisterNetEvent('esx_trunk_inventory:setOwnedVehicule')
AddEventHandler('esx_trunk_inventory:setOwnedVehicule', function(vehicle)
		vehiclePlate = vehicle
		print('Your vehiclePlates: ',ESX.DumpTable(vehiclePlate))
end)

function getItemyWeight(item)
  local weight = 0
  local itemWeight = 0
  if item ~= nil then
	   itemWeight = Config.DefaultWeight
	   if arrayWeight[item] ~= nil then
	        itemWeight = arrayWeight[item]
	   end
	end
  return itemWeight
end

function VehicleInFront()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 4.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local a, b, c, d, result = GetRaycastResult(rayHandle)
    return result
end

function openmenuvehicle()
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	local vehicle   =VehicleInFront()
  globalplate  = GetVehicleNumberPlateText(vehicle)
  
  myVeh = false
  local thisVeh = VehicleInFront()
  PlayerData = ESX.GetPlayerData()
  for i=1, #vehiclePlate do
    local vPlate = all_trim(vehiclePlate[i].plate)
    local vFront = all_trim(GetVehicleNumberPlateText(thisVeh))
    print('vPlate: ',vPlate)
    print('vFront: ',vFront)
    if vPlate ~= vFront then
      print('No match: ' .. vPlate .. ' / '.. vFront)
    end
    if  vPlate == vFront then
      myVeh = true
      print('Plate match: ' .. vPlate .. ' / '.. vFront)
    elseif lastChecked < GetGameTimer() - 60000 then
      TriggerServerEvent("esx_trunk_inventory:getOwnedVehicule")
      print('Checking for new plates(timed event)')
      lastChecked = GetGameTimer()
      Wait(2000)
      for i=1, #vehiclePlate do
        local vPlate = all_trim(vehiclePlate[i].plate)
        local vFront = all_trim(GetVehicleNumberPlateText(thisVeh))
        if vPlate ~= vFront then
          print('2nd attempt no match: ' .. vPlate .. ' / '.. vFront)
        end
        if  vPlate == vFront then
          myVeh = true
          print('Plate match: ' .. vPlate .. ' / '.. vFront)
        end
      end
    end
  end

  if not Config.CheckOwnership or (Config.AllowPolice and PlayerData.job.name == 'police') or (Config.CheckOwnership and myVeh) then  
    if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
      CloseToVehicle = true
      local vehFront = VehicleInFront()
      local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
      local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)

      if vehFront > 0 and closecar ~= nil and GetPedInVehicleSeat(closecar, -1) ~= GetPlayerPed(-1) then
        lastVehicle = vehFront
        local model = GetDisplayNameFromVehicleModel(GetEntityModel(closecar))
        local locked = GetVehicleDoorLockStatus(closecar)
        local class = GetVehicleClass(vehFront)
        ESX.UI.Menu.CloseAll()

        if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'inventory') then
          SetVehicleDoorShut(vehFront, 5, false)
        else

          if locked == 1 or class == 15 or class == 16 or class == 14 then
            print('Trunk locked or improper class.')
            SetVehicleDoorOpen(vehFront, 5, false, false)
            ESX.UI.Menu.CloseAll()

            if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
              CloseToVehicle = true
              if inArray(model, Config.VehicleModel) then
                model = string.lower(model)
                vehCapacity = Config.VehicleModel[model]
                --ESX.ShowNotification('weight is '..vehCapacity)
              else
                vehCapacity = Config.VehicleLimit[class]
                --ESX.ShowNotification('weight is '..vehCapacity)
              end
              OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), vehCapacity)
            end

          else
            ESX.ShowNotification(_U('trunk_closed'))
            print('Trunk has been closed.')
          end
        end
      else
        ESX.ShowNotification(_U('no_veh_nearby'))
        print('Trunk: No vehicle nearby.')
      end
      lastOpen = true
      GUI.Time  = GetGameTimer()
    end
  else
    -- Not their vehicle
    ESX.ShowNotification(_U('nacho_veh'))
    print('Trunk: NOT YOUR VEHICLE')
    print('Your Plates: ',ESX.DumpTable(vehiclePlate))
    print('Veh in front: ',ESX.DumpTable(vehFront))
  end
end
local count = 0





-- Key controls
Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsControlPressed(0, Keys["L"]) and (GetGameTimer() - GUI.Time) > 1000  then
      openmenuvehicle()
    elseif lastOpen and IsControlPressed(0, Keys["BACKSPACE"]) and (GetGameTimer() - GUI.Time) > 150 then
	    CloseToVehicle = false
      lastOpen = false
      if lastVehicle > 0 then
        SetVehicleDoorShut(lastVehicle, 5, false)
        lastVehicle = 0
      end
      GUI.Time  = GetGameTimer()
    end
  end
end)

Citizen.CreateThread(function()
  while true do
  Wait(0)
	local pos = GetEntityCoords(GetPlayerPed(-1))
	if CloseToVehicle then
		local vehicle = GetClosestVehicle(pos['x'], pos['y'], pos['z'], 2.0, 0, 70)
		if DoesEntityExist(vehicle) then
			CloseToVehicle = true
		else
			CloseToVehicle = false
			lastOpen = false
			ESX.UI.Menu.CloseAll()
			SetVehicleDoorShut(lastVehicle, 5, false)
		end
	end
  end
end)

function OpenCoffreInventoryMenu(plate,max)

  ESX.TriggerServerCallback('esx_trunk:getInventoryV', function(inventory)
    local plate = plate
    local owner= GetPlayerPed(-1)
    local elements = {}
    table.insert(elements, {label = _U('deposit'), type = 'deposer', value = 'deposer'})
    table.insert(elements, {label = _U('dirty_money') .. inventory.blackMoney, type = 'item_account', value = 'black_money'})

    for i=1, #inventory.items, 1 do
      local item = inventory.items[i]
      if item.count > 0 then
        table.insert(elements, {label = item.label .. ' x' .. item.count..' - ('.. ((getItemyWeight(item.name)*item.count)/1000) ..' '.._U('measurement')..')', type = 'item_standard', value = item.name})
      end

    end

    for i=1, #inventory.weapons, 1 do
      local weapon = inventory.weapons[i]
      table.insert(elements, {label = ESX.GetWeaponLabel(weapon.name) .. ' [' .. weapon.ammo .. '] - ('..(getItemyWeight(weapon.name)/1000)..' '.._U('measurement')..')', type = 'item_weapon', value = weapon.name, ammo = weapon.ammo})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'car_inventory',
      {
        title    = plate .. ' - ' .. (inventory.weight/1000) .. " / "..(max/1000).._U('measurement'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        if data.current.type == 'item_weapon' then

          menu.close()

          TriggerServerEvent('esx_trunk:getItem', plate, data.current.type, data.current.value, data.current.ammo)

          ESX.SetTimeout(500, function()
            ESX.UI.Menu.CloseAll()
            OpenCoffreInventoryMenu(plate,max)
          end)

        elseif data.current.type == "deposer" then
          ESX.UI.Menu.CloseAll()
          OpenPlayerInventoryMenu(owner,plate,max,inventory.weight)
        else

          ESX.UI.Menu.Open(
            'dialog', GetCurrentResourceName(), 'get_item_count',
            {
              title = _U('quantity'),
            },
            function(data2, menu)

              local quantity = tonumber(data2.value)

              if quantity == nil or quantity < 1 then
                ESX.ShowNotification(_U('invalid_quantity'))
              else

                menu.close()

                TriggerServerEvent('esx_trunk:getItem', plate, data.current.type, data.current.value, quantity)

                ESX.SetTimeout(500, function()
                  ESX.UI.Menu.CloseAll()
                  OpenCoffreInventoryMenu(plate,max)
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

  end, plate)
end


function OpenPlayerInventoryMenu(owner,plate,max,weight)

  ESX.TriggerServerCallback('esx_trunk:getPlayerInventory', function(inventory)

    local elements = {}
    table.insert(elements, {label = _U('return'), type = 'retour', value = 'retour'})
    table.insert(elements, {label = _U('dirty_money') .. inventory.blackMoney, type = 'item_account', value = 'black_money'})

    for i=1, #inventory.items, 1 do

      local item = inventory.items[i]

      if item.count > 0 then
        table.insert(elements, {label = item.label .. ' x' .. item.count..' - ('.. ((getItemyWeight(item.name)*item.count)/1000) ..' '.._U('measurement')..')', type = 'item_standard', value = item.name})
      end

    end

    local playerPed  = GetPlayerPed(-1)
    local weaponList = ESX.GetWeaponList()

    for i=1, #weaponList, 1 do

      local weaponHash = GetHashKey(weaponList[i].name)

      if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
        local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
        table.insert(elements, {label = weaponList[i].label .. ' [' .. ammo .. '] - ('..(getItemyWeight(weaponList[i].name)/1000)..' '.._U('measurement')..')', type = 'item_weapon', value = weaponList[i].name, ammo = ammo})
      end

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'player_inventory',
      {
        title    = plate .. ' - ' .. (weight/1000) .. " / "..(max/1000)..' '.._U('measurement'), 
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        if data.current.type == 'item_weapon' then

          menu.close()

          TriggerServerEvent('esx_trunk:putItem', plate, data.current.type, data.current.value, data.current.ammo,max, myVeh)

          ESX.SetTimeout(300, function()
            weight = weight + (getItemyWeight(data.current.value))
            ESX.UI.Menu.CloseAll()
            OpenPlayerInventoryMenu(playerPed,plate,max,weight)
          end)
        elseif data.current.type == 'retour' then
          ESX.UI.Menu.CloseAll()
          OpenCoffreInventoryMenu(plate,max)
        else

          ESX.UI.Menu.Open(
            'dialog', GetCurrentResourceName(), 'put_item_count',
            {
              title = _U('quantity'),
            },
            function(data2, menu)
              local quantity = tonumber(data2.value)

              if quantity == nil or quantity < 1 then
                ESX.ShowNotification(_U('invalid_quantity'))
              else
                menu.close()

                TriggerServerEvent('esx_trunk:putItem', plate, data.current.type, data.current.value, tonumber(data2.value),max, myVeh)

                ESX.SetTimeout(300, function()
                  ESX.UI.Menu.CloseAll()
                  weight = weight + (getItemyWeight(data.current.value) * tonumber(data2.value))
                  OpenPlayerInventoryMenu(playerPed,plate,max,weight)

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

function all_trim(s)
	if s then
		return s:match"^%s*(.*)":match"(.-)%s*$"
	else
		return 'noTagProvided'
	end
end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end


function inArray(needle, haystack)
	for k,v in pairs(haystack) do
		if string.lower(k) == string.lower(needle) then
			return true
		end
	end
	return false
end

---------------------------------
--------- ikNox#6088 ------------
---------------------------------