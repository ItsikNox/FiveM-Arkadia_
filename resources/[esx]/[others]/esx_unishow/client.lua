 ESX                             = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)


function OpenPositionMenu(zone)

	local elements = {}

	for k,v in pairs(Config.Salle) do
	   table.insert(elements,{
       label = v.label,
       pos  = v.pos
     })
	end


	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'strip',
		{
			title  = 'Position Menu',
			elements = elements
		},
		function(data, menu)
      OpenDancerMenu(data.current,zone)
		end,
		function(data, menu)

			menu.close()

			CurrentAction     = 'strip_menu'
			CurrentActionMsg  = 'menu'
			CurrentActionData = {zone = zone}
		end
	)
end
function OpenDancerMenu(position,zone)
  local position = position
	local elements = {}
      table.insert(elements,{
      label = 'Personne',
      hash  = '',
      type = ''

    })
  for i=1,#Config.Ped do
    table.insert(elements,{
      label = Config.Ped[i].label,
      hash  = Config.Ped[i].hash,
      type = Config.Ped[i].type

    })
  end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'strip',
		{
			title  = 'Dancer Menu',
			elements = elements
		},
		function(data, menu)
      	if data.current.label == 'Personne'	then
      		print(position.label)
      		TriggerServerEvent('esx_unishow:DeleteShow',position.label)
      	else
      		OpenDanceMenu(data.current,position,zone)
      	end
		end,
		function(data, menu)

			menu.close()

			CurrentAction     = 'strip_menu'
			CurrentActionMsg  = 'menu'
			CurrentActionData = {zone = zone}
		end
	)
end

function OpenDanceMenu(dancer,position,zone)
  local position = position
  local dancer = dancer
  local elements = {}
  for k,v in pairs(Config.Dict) do

    table.insert(elements,{
      label = v.label,
      name  = v.name,
      anim = v.anim,

    })
  end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'strip',
		{
			title  = 'Dance Menu',
			elements = elements
		},
		function(data, menu)
      showUni(data.current,dancer,position)
		end,
		function(data, menu)

			menu.close()

			CurrentAction     = 'strip_menu'
			CurrentActionMsg  = 'menu'
			CurrentActionData = {zone = zone}
		end
	)
end

function showUni(dance,dancer,position)
  TriggerServerEvent('esx_unishow:DeleteShow',position.label)
  Wait(2000)
  RequestModel(GetHashKey(dancer.hash))
  while not HasModelLoaded(GetHashKey(dancer.hash)) do
    Wait(1)
  end

  stripper =  CreatePed(dancer.type, dancer.hash, position.pos.x, position.pos.y, position.pos.z, position.pos.a, true, true)
  SetPedArmour(stripper, 0)
  SetPedMaxHealth(stripper, 200)
  SetPedDiesWhenInjured(ped, false)
  local param = {label=position.label,ped=stripper}
  TriggerServerEvent('esx_unishow:RegisterShow',param)
  RequestAnimDict(dance.name)
  while not HasAnimDictLoaded(dance.name) do
    Wait(1)
  end
  TaskPlayAnim(stripper,dance.name,dance.anim, 8.0, 0.0, -1, 1, 0, 0, 1, 0)
end

RegisterNetEvent('esx_unishow:StopDance')
AddEventHandler('esx_unishow:StopDance',function(ped)
  ClearPedTasksImmediately(ped)
  DeletePed(ped)
end)


AddEventHandler('esx_unishow:hasEnteredMarker', function(zone)

	CurrentAction     = 'strip_menu'
	CurrentActionMsg  = 'appuyez sur ~INPUT_CONTEXT~ pour choisir les shows'
	CurrentActionData = {zone = zone}


end)

AddEventHandler('esx_unishow:hasExitedMarker', function(zone)

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()

end)



Citizen.CreateThread(function()
  while true do
    Wait(0)
    local coords = GetEntityCoords(GetPlayerPed(-1))
        if(Config.Type ~= -1 and GetDistanceBetweenCoords(coords, Config.Zones.Pos.x, Config.Zones.Pos.y, Config.Zones.Pos.z, true) < 10) then
          DrawMarker(2, Config.Zones.Pos.x, Config.Zones.Pos.y, Config.Zones.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3, 3, 3, 255, 0, 0, 100, false, true, 2, false, false, false, false)
        end
  end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Wait(0)
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil

		if(GetDistanceBetweenCoords(coords, Config.Zones.Pos.x, Config.Zones.Pos.y, Config.Zones.Pos.z, true) < 1) then
			isInMarker  = true
			currentZone = 'menustrip'
			LastZone    = 'menustrip'
		end

		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('esx_unishow:hasEnteredMarker', currentZone)
		end
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_unishow:hasExitedMarker', LastZone)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if CurrentAction ~= nil then
      SetTextComponentFormat('STRING')
      AddTextComponentString(CurrentActionMsg)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)
      if IsControlJustReleased(0, 38) then
        if CurrentAction == 'strip_menu' then
          OpenPositionMenu(CurrentActionData.zone)
        end
        CurrentAction = nil
      end
    end
  end
end)
