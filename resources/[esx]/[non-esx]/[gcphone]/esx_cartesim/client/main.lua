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

ESX                           = nil
local GUI                     = {}
GUI.Time                      = 0
local isInMarker      = false

RegisterNetEvent('esx_cartesim:OpenSim')
AddEventHandler('esx_cartesim:OpenSim', function()
	OpenPhoneMenu()
end)

function OpenSimMenu()

	ESX.UI.Menu.CloseAll()

	local elements = {}
	local elements2 = {}
  
	  ESX.TriggerServerCallback('esx_cartesim:GetList', function(sim)
  
		  for _,v in pairs(sim) do
  
			  table.insert(elements, {label = tostring(v.number), value = v})
			  
		  end
  
		  ESX.UI.Menu.Open(
		  'default', GetCurrentResourceName(), 'phone_change',
		  {
			  title    = 'Liste des cartes sim',
			  align    = 'center',
			  elements = elements,
		  },
	  function(data, menu)
  
		local elements2 = {
			{label = 'Utiliser', value = 'sim_use'},
			{label = 'Donner', value = 'sim_give'},
		  	{label = 'Jeter', value = 'sim_delete'}
		  }
  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sim_change', {
			title    = "Que voulez vous faire de cette carte sim?",
			align    = 'center',
			elements = elements2,
  
		  }, 
		  function(data2, menu2)
  
			if data2.current.value == 'sim_use' then
				ESX.UI.Menu.CloseAll()
				TriggerServerEvent('esx_cartesim:sim_use', data.current.value.number)
				ESX.ShowNotification("Vous avez activé la carte sim ~o~" .. data.current.value.number)
				TriggerServerEvent('gcPhone:allUpdate')
			end
			if data2.current.value == 'sim_give' then
				ESX.UI.Menu.CloseAll()
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer == -1 or closestDistance > 3.0 then
					ESX.ShowNotification('Aucun joueur à proximité')
				else
					TriggerServerEvent('esx_cartesim:sim_give', data.current.value.number, GetPlayerServerId(closestPlayer))
				end
				TriggerServerEvent('gcPhone:allUpdate')
			end
			if data2.current.value == 'sim_delete' then
				ESX.UI.Menu.CloseAll()
				TriggerServerEvent('esx_cartesim:sim_delete', data.current.value.number)
				ESX.ShowNotification("Vous avez jeté la carte sim ~o~" .. data.current.value.number)
				TriggerServerEvent('gcPhone:allUpdate')
			end

			menu2.close()
		  end, function(data2, menu2)
			menu2.close()
		  end)
  
		  end,
		  function(data, menu)
			  menu.close()
		  end
	  )	
	end)
  
end

function OpenPhoneMenu()

	ESX.UI.Menu.CloseAll()

	local elements = {
	  --{label = 'Ouvrir', value = 'open_phone'},
	  {label = 'Carte Sim', value = 'sim_phone'}
	}
  
	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'phone_actions',
	  {
		title    = 'Téléphone',
		elements = elements
	  },
	  function(data, menu)
  
		if data.current.value == 'open_phone' then
			ESX.UI.Menu.CloseAll()
			ESX.TriggerServerCallback('esx_cartesim:CheckSim', function(sim)
				if sim then
					TriggerEvent('gcphone:Open')
				else
					ESX.ShowNotification("Vous n'avez pas de carte sim !")
				end
			end)

		end

		if data.current.value == 'sim_phone' then
			OpenSimMenu()
		end
  
	  end,
	  function(data, menu)
  
		menu.close()
	  end
	)
  
end

Citizen.CreateThread(function() --ok

	while ESX == nil do
	  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	  Citizen.Wait(1)
	end

  end)

  --[[
Citizen.CreateThread(function() --ok
	while true do
		if IsControlJustReleased(0, 170) then
			OpenPhoneMenu()
		end
	  Citizen.Wait(1)
	end
  end)
--]]

RegisterNetEvent('NB:carteSIM')
AddEventHandler('NB:carteSIM', function()
	OpenSimMenu()
end)

---------------------------------
--------- ikNox#6088 ------------
---------------------------------