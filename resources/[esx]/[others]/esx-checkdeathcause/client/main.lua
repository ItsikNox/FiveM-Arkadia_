  ESX               = nil
  
  Citizen.CreateThread(function()
	  while ESX == nil do
		  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		  Citizen.Wait(1)
	  end
		PlayerData = ESX.GetPlayerData()
  end)
  
  RegisterNetEvent('esx:playerLoaded')
  AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
  end)
  
  RegisterNetEvent('esx:setJob')
  AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
  end)
  
  local Melee = { -1569615261, 1737195953, 1317494643, -1786099057, 1141786504, -2067956739, -868994466 }
  local Knife = { -1716189206, 1223143800, -1955384325, -1833087301, 910830060, }
  local Bullet = { 453432689, 1593441988, 584646201, -1716589765, 324215364, 736523883, -270015777, -1074790547, -2084633992, -1357824103, -1660422300, 2144741730, 487013001, 2017895192, -494615257, -1654528753, 100416529, 205991906, 1119849093 }
  local Animal = { -100946242, 148160082 }
  local FallDamage = { -842959696 }
  local Explosion = { -1568386805, 1305664598, -1312131151, 375527679, 324506233, 1752584910, -1813897027, 741814745, -37975472, 539292904, 341774354, -1090665087 }
  local Gas = { -1600701090 }
  local Burn = { 615608432, 883325847, -544306709 }
  local Drown = { -10959621, 1936677264 }
  local Car = { 133987706, -1553120962 }
  
  function checkArray (array, val)
	  for name, value in ipairs(array) do
		  if value == val then
			  return true
		  end
	  end
  
	  return false
  end
  
  Citizen.CreateThread(function()
	  Citizen.Wait(1000)
		while true do
		  local sleep = 3000
  
		  if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
  
			  local player, distance = ESX.Game.GetClosestPlayer()
  
			  if distance ~= -1 and distance < 10.0 then
  
				  if distance ~= -1 and distance <= 2.0 then	
					  if IsPedDeadOrDying(GetPlayerPed(player)) then
						  Start(GetPlayerPed(player))
					  end
				  end
  
			  else
				  sleep = sleep / 100 * distance 
			  end
  
		  end
  
		  Citizen.Wait(sleep)
  
	  end
  end)
  
  function Start(ped)
	  checking = true
  
	  while checking do
		  Citizen.Wait(5)
  
		  local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(ped))
  
		  local x,y,z = table.unpack(GetEntityCoords(ped))
  
		  if distance < 2.0 then
			  DrawText3D(x,y,z, 'Appuyez sur [~g~E~s~] pour vérifiez les causes de la mort', 0.4)
			  
			  if IsControlPressed(0, 38) then
				  OpenDeathMenu(ped)
			  end
		  end
  
		  if distance > 7.5 or not IsPedDeadOrDying(ped) then
			  checking = false
		  end
  
	end
  
end
  
  function Notification(x,y,z)
	  local timestamp = GetGameTimer()
  
	  while (timestamp + 4500) > GetGameTimer() do
		  Citizen.Wait(0)
		  DrawText3D(x, y, z, 'Les dégâts semblent se produire ici.', 0.4)
		  checking = false
	  end
  end
  
  function OpenDeathMenu(player)
  
	  loadAnimDict('amb@medic@standing@kneel@base')
	  loadAnimDict('anim@gangops@facility@servers@bodysearch@')
  
	  local elements   = {}
  
	  table.insert(elements, {label = 'Identifier la cause de la mort', value = 'deathcause'})
	  table.insert(elements, {label = 'Identifier l\'endroit où les dommages se sont produits', value = 'damage'})
  
  
	  ESX.UI.Menu.Open(
		  'default', GetCurrentResourceName(), 'dead_citizen',
		  {
			  title    = 'Choisi une option',
			  align    = 'right',
			  elements = elements,
		  },
	  function(data, menu)
		  local ac = data.current.value
  
		  if ac == 'damage' then
  
			  local bone
			  local success = GetPedLastDamageBone(player,bone)
  
			  local success,bone = GetPedLastDamageBone(player)
			  if success then
				  --print(bone)
				  local x,y,z = table.unpack(GetPedBoneCoords(player, bone))
					Notification(x,y,z)
				
			  else
				  Notify('Les dommages survenus n\'ont pas pu être identifiés')
			  end
		  end
  
		  if ac == 'deathcause' then
			  --gets deathcause
			  local d = GetPedCauseOfDeath(player)		
			  local playerPed = GetPlayerPed(-1)
  
			  --starts animation
  
			  TaskPlayAnim(GetPlayerPed(-1), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
			  TaskPlayAnim(GetPlayerPed(-1), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
  
			  Citizen.Wait(5000)
  
			  --exits animation			
  
			  ClearPedTasksImmediately(playerPed)
  
			  if checkArray(Melee, d) then
				  Notify(_U('hardmeele'))
			  elseif checkArray(Bullet, d) then
				  Notify(_U('bullet'))
			  elseif checkArray(Knife, d) then
				  Notify(_U('knifes'))
			  elseif checkArray(Animal, d) then
				  Notify(_U('bitten'))
			  elseif checkArray(FallDamage, d) then
				  Notify(_U('brokenlegs'))
			  elseif checkArray(Explosion, d) then
				  Notify(_U('explosive'))
			  elseif checkArray(Gas, d) then
				  Notify(_U('gas'))
			  elseif checkArray(Burn, d) then
				  Notify(_U('fire'))
			  elseif checkArray(Drown, d) then
				  Notify(_U('drown'))
			  elseif checkArray(Car, d) then
				  Notify(_U('caraccident'))
			  else
				  Notify(_U('unknown'))
			  end
		  end
  
  
	  end,
	  function(data, menu)
		menu.close()
	  end
	)
  end
  
  function loadAnimDict(dict)
	  while (not HasAnimDictLoaded(dict)) do
		  RequestAnimDict(dict)
		  
		  Citizen.Wait(1)
	  end
  end
  
  function Notify(message)
	  ESX.ShowNotification(message)
  end
  
  function DrawText3D(x, y, z, text, scale)
	  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	  local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
   
	  SetTextScale(scale, scale)
	  SetTextFont(4)
	  SetTextProportional(1)
	  SetTextEntry("STRING")
	  SetTextCentre(1)
	  SetTextColour(255, 255, 255, 215)
   
	  AddTextComponentString(text)
	  DrawText(_x, _y)
   
  end
