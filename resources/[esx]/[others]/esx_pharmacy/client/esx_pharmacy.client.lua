ESX = nil
local GUI                     = {}
GUI.Time                      = 0
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}


-- ====================================================================================================================
-- Local function
-- ====================================================================================================================
function setCurrentAction(action, msg, data)
  CurrentAction     = action
  CurrentActionMsg  = msg
  CurrentActionData = data
end


-- ====================================================================================================================
-- Citizen thread
-- ====================================================================================================================
Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

-- Render markers
-- Citizen.CreateThread(function()
  -- while true do
    -- Wait(0)
    -- local coords = GetEntityCoords(GetPlayerPed(-1))

    -- for k,v in pairs(Config.Shops) do
      -- if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.DrawDistance then
        -- DrawMarker(
          -- Config.MarkerType, 
          -- v.x, 
          -- v.y, 
          -- v.z, 
          -- 0.0, 
          -- 0.0, 
          -- 0.0, 
          -- 0, 
          -- 0.0, 
          -- 0.0, 
          -- Config.MarkerSize.x, 
          -- Config.MarkerSize.y, 
          -- Config.MarkerSize.z, 
          -- Config.MarkerColor.r, 
          -- Config.MarkerColor.g, 
          -- Config.MarkerColor.b, 
          -- 100, 
          -- false, 
          -- true, 
          -- 2, 
          -- false, 
          -- false, 
          -- false, 
          -- false
        -- )
      -- end
    -- end
  -- end
-- end)

-- Create blips
-- Citizen.CreateThread(function()
  -- for i = 1, #Config.Shops, 1 do
    -- local shop = Config.Shops[i]

    -- local blip = AddBlipForCoord(shop.x, shop.y, shop.z - Config.ZDiff)
    -- SetBlipSprite (blip, Config.BlipSprite)
    -- SetBlipDisplay(blip, 4)
    -- SetBlipScale  (blip, 1.0)
    -- SetBlipColour (blip, Config.BlipColour)
    -- SetBlipAsShortRange(blip, true)
    -- BeginTextCommandSetBlipName('STRING')
    -- AddTextComponentString('Pharmacie')
    -- EndTextCommandSetBlipName(blip)
  -- end
-- end)

-- Enter / Exit marker events
-- Citizen.CreateThread(function()
  -- while true do
    -- Wait(0)
    -- local coords      = GetEntityCoords(GetPlayerPed(-1))
    -- local isInMarker  = false
    -- local currentZone = nil

    -- for k,v in pairs(Config.Shops) do
      -- if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.MarkerSize.x then
        -- isInMarker  = true
        -- currentZone = k
      -- end
    -- end

    -- if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
      -- HasAlreadyEnteredMarker = true
      -- LastZone                = currentZone
      -- TriggerEvent('esx_pharmacy:hasEnteredMarker', currentZone)
    -- end

    -- if not isInMarker and HasAlreadyEnteredMarker then
      -- HasAlreadyEnteredMarker = false
      -- TriggerEvent('esx_pharmacy:hasExitedMarker', LastZone)
    -- end

  -- end
-- end)

-- Key Controls
-- Citizen.CreateThread(function()
  -- while true do
    -- Citizen.Wait(0)
    -- if CurrentAction ~= nil then
      -- SetTextComponentFormat('STRING')
      -- AddTextComponentString(CurrentActionMsg)
      -- DisplayHelpTextFromStringLabel(0, 0, 1, -1)
      -- if IsControlPressed(0, 38) and (GetGameTimer() - GUI.Time) > 300 then
        -- if CurrentAction == 'pharmacy_shop' then
          -- OpenShopMenu()
        -- end
        -- CurrentAction = nil
        -- GUI.Time      = GetGameTimer()
      -- end
    -- end
  -- end
-- end)


-- ====================================================================================================================
-- Event handler
-- ====================================================================================================================
AddEventHandler('esx_pharmacy:hasEnteredMarker', function(zone)
  CurrentAction     = 'pharmacy_shop'
  CurrentActionMsg  = _U('press_menu')
  CurrentActionData = {}
end)

AddEventHandler('esx_pharmacy:hasExitedMarker', function(zone)
  ESX.UI.Menu.CloseAll()
  CurrentAction = nil
end)

RegisterNetEvent('esx_pharmacy:useKit')
AddEventHandler('esx_pharmacy:useKit', function(itemName, hp_regen)
  local ped    = GetPlayerPed(-1)
  local health = GetEntityHealth(ped)
  local max    = GetEntityMaxHealth(ped)

  if health > 0 and health < max then

    TriggerServerEvent('esx_pharmacy:removeItem', itemName)
    ESX.UI.Menu.CloseAll()
    ESX.ShowNotification(_U('use_firstaidkit'))

    health = health + (max / hp_regen)
    if health > max then
      health = max
    end
    SetEntityHealth(ped, health)
  end
end)

RegisterNetEvent('esx_pharmacy:useDefibrillateur')
AddEventHandler('esx_pharmacy:useDefibrillateur', function(itemName)
  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

  if closestPlayer == -1 or closestDistance > 3.0 then
    ESX.ShowNotification(_U('no_players'))
  else
    local ped    = GetPlayerPed(closestPlayer)
    local health = GetEntityHealth(ped)

    if health == 0 then
      local playerPed = GetPlayerPed(-1)
      Citizen.CreateThread(function()
        ESX.ShowNotification(_U('revive_inprogress'))
        TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
        Citizen.Wait(15000)
        ClearPedTasks(playerPed)
        if GetEntityHealth(closestPlayerPed) == 0 then
          TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))
          ESX.ShowNotification(_U('revive_complete') .. GetPlayerName(closestPlayer))
        else
          ESX.ShowNotification(GetPlayerName(closestPlayer) .. _U('isdead'))
        end
      end)
    else
		  ESX.ShowNotification(GetPlayerName(closestPlayer) .. _U('unconscious'))
    end
  end
end)