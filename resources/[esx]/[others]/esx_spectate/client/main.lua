ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Wait(0)
	end
end)

local InSpectatorMode	= false
local TargetSpectate	= nil
local LastPosition		= nil
local polarAngleDeg		= 0;
local azimuthAngleDeg	= 90;
local radius			= -3.5;
local cam 				= nil
local PlayerDate		= {}
local ShowInfos			= false
local group

function polar3DToWorld3D(entityPosition, radius, polarAngleDeg, azimuthAngleDeg)
	-- convert degrees to radians
	local polarAngleRad   = polarAngleDeg   * math.pi / 180.0
	local azimuthAngleRad = azimuthAngleDeg * math.pi / 180.0

	local pos = {
		x = entityPosition.x + radius * (math.sin(azimuthAngleRad) * math.cos(polarAngleRad)),
		y = entityPosition.y - radius * (math.sin(azimuthAngleRad) * math.sin(polarAngleRad)),
		z = entityPosition.z - radius * math.cos(azimuthAngleRad)
	}

	return pos
end

function spectate(target)

	ESX.TriggerServerCallback('esx:getPlayerData', function(player)
		if not InSpectatorMode then
			LastPosition = GetEntityCoords(GetPlayerPed(-1))
		end

		local playerPed = GetPlayerPed(-1)

		SetEntityCollision(playerPed, false, false)
		SetEntityVisible(playerPed, false)

		PlayerData = player
		if ShowInfos then
			SendNUIMessage({
				type = 'infos',
				data = PlayerData
			})	
		end

		Citizen.CreateThread(function()

			if not DoesCamExist(cam) then
				cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
			end

			SetCamActive(cam, true)
			RenderScriptCams(true, false, 0, true, true)

			InSpectatorMode = true
			TargetSpectate  = target

		end)
	end, target)

end

function resetNormalCamera()
	InSpectatorMode = false
	TargetSpectate  = nil
	local playerPed = GetPlayerPed(-1)

	SetCamActive(cam,  false)
	RenderScriptCams(false, false, 0, true, true)

	SetEntityCollision(playerPed, true, true)
	SetEntityVisible(playerPed, true)
	SetEntityCoords(playerPed, LastPosition.x, LastPosition.y, LastPosition.z)
end

function getPlayersList()

	local players = ESX.Game.GetPlayers()
	local data = {}

	for i=1, #players, 1 do

		local _data = {
			id = GetPlayerServerId(players[i]),
			name = GetPlayerName(players[i])
		}
		table.insert(data, _data)
	end

	return data
end

function OpenAdminActionMenu(player)

    ESX.TriggerServerCallback('esx_spectate:getOtherPlayerData', function(data)

      local jobLabel    = nil
      local sexLabel    = nil
      local sex         = nil
      local dobLabel    = nil
      local heightLabel = nil
      local idLabel     = nil
	  local Money		= 0
	  local Bank		= 0
	  local blackMoney	= 0
	  local Inventory	= nil
	  
    for i=1, #data.accounts, 1 do
      if data.accounts[i].name == 'black_money' then
        blackMoney = data.accounts[i].money
      end
    end

	  if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
        jobLabel = 'Metier : ' .. data.job.label .. ' - ' .. data.job.grade_label
      else
        jobLabel = 'Metier : ' .. data.job.label
      end

      if data.sex ~= nil then
        if (data.sex == 'm') or (data.sex == 'M') then
          sex = 'Homme'
        else
          sex = 'Femme'
        end
        sexLabel = 'Sexe : ' .. sex
      else
        sexLabel = 'Sexe : Inconnu'
      end
	  
	  if data.money ~= nil then
		Money = data.money
		else
		Money = 'Pas de Donnée'
	  end

 	  if data.bank ~= nil then
		Bank = data.bank
		else
		Bank = 'Pas de Donnée'
	  end
	  
      if data.dob ~= nil then
        dobLabel = 'DOB : ' .. data.dob
      else
        dobLabel = 'DOB : Inconnu'
      end

      if data.height ~= nil then
        heightLabel = 'Taille : ' .. data.height
      else
        heightLabel = 'Taille : Inconnu'
      end

      if data.name ~= nil then
        idLabel = 'Steam ID : ' .. data.name
      else
        idLabel = 'Steam ID : Unknown'
      end
	  
      local elements = {
        {label = 'Nom: ' .. data.firstname .. " " .. data.lastname, value = nil},
        {label = 'Argent: '.. data.money, value = nil},
        {label = 'Banque: '.. data.bank, value = nil},
        {label = 'Argent Sale: '.. blackMoney, value = nil, itemType = 'item_account', amount = blackMoney},
		{label = jobLabel,    value = nil},
        {label = idLabel,     value = nil},
    }
	
    table.insert(elements, {label = '--- Inventaire ---', value = nil})

    for i=1, #data.inventory, 1 do
      if data.inventory[i].count > 0 then
        table.insert(elements, {
          label          = data.inventory[i].label .. ' x ' .. data.inventory[i].count,
          value          = nil,
          itemType       = 'item_standard',
          amount         = data.inventory[i].count,
        })
      end
    end
	
    table.insert(elements, {label = '--- Weapons ---', value = nil})

    for i=1, #data.weapons, 1 do
      table.insert(elements, {
        label          = ESX.GetWeaponLabel(data.weapons[i].name),
        value          = nil,
        itemType       = 'item_weapon',
        amount         = data.ammo,
      })
    end
      if data.licenses ~= nil then

        table.insert(elements, {label = '--- Licences ---', value = nil})

        for i=1, #data.licenses, 1 do
          table.insert(elements, {label = data.licenses[i].label, value = nil})
        end

      end

      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'citizen_interaction',
        {
          title    = 'Player Control',
          align    = 'left',
          elements = elements,
        },
        function(data, menu)

        end,
        function(data, menu)
          menu.close()
        end
      )

    end, GetPlayerServerId(player))
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		
		if IsControlJustReleased(1, 163) then
			print('triggered')
			if group ~= "user" then
				TriggerEvent('esx_spectate:spectate')
			end
		end
	end
end)

RegisterNetEvent('es_admin:setGroup')
AddEventHandler('es_admin:setGroup', function(g)
	print('group setted ' .. g)
	group = g
end)

RegisterNetEvent('esx_spectate:spectate')
AddEventHandler('esx_spectate:spectate', function()

	SetNuiFocus(true, true)

	SendNUIMessage({
		type = 'show',
		data = getPlayersList(),
		player = GetPlayerServerId(PlayerId())
	})

end)

RegisterNUICallback('select', function(data, cb)
	print("select UI " .. json.encode(data))
	spectate(data.id)
	SetNuiFocus(false)
end)

RegisterNUICallback('close', function(data, cb)
	print("closing UI")
	SetNuiFocus(false)
end)

RegisterNUICallback('quit', function(data, cb)
	SetNuiFocus(false)
	resetNormalCamera()
end)

RegisterNUICallback('kick', function(data, cb)
	SetNuiFocus(false)
	TriggerServerEvent('esx_spectate:kick', data.id, data.reason)
	TriggerEvent('esx_spectate:spectate')
end)



Citizen.CreateThread(function()

  	while true do

		Wait(0)

		if InSpectatorMode then

			local targetPlayerId = GetPlayerFromServerId(TargetSpectate)
			local playerPed	  = GetPlayerPed(-1)
			local targetPed	  = GetPlayerPed(targetPlayerId)
			local coords	 = GetEntityCoords(targetPed)

			for i=0, 32, 1 do
				if i ~= PlayerId() then
					local otherPlayerPed = GetPlayerPed(i)
					SetEntityNoCollisionEntity(playerPed,  otherPlayerPed,  true)
				end
			end

			if IsControlPressed(2, 241) then
				radius = radius + 2.0;
			end

			if IsControlPressed(2, 242) then
				radius = radius - 2.0;
			end

			if radius > -1 then
				radius = -1
			end

			local xMagnitude = GetDisabledControlNormal(0, 1);
			local yMagnitude = GetDisabledControlNormal(0, 2);

			polarAngleDeg = polarAngleDeg + xMagnitude * 10;

			if polarAngleDeg >= 360 then
				polarAngleDeg = 0
			end

			azimuthAngleDeg = azimuthAngleDeg + yMagnitude * 10;

			if azimuthAngleDeg >= 360 then
				azimuthAngleDeg = 0;
			end

			local nextCamLocation = polar3DToWorld3D(coords, radius, polarAngleDeg, azimuthAngleDeg)

			SetCamCoord(cam,  nextCamLocation.x,  nextCamLocation.y,  nextCamLocation.z)
			PointCamAtEntity(cam,  targetPed)
			SetEntityCoords(playerPed,  coords.x, coords.y, coords.z + 10)

			if IsControlPressed(2, 47) then
			OpenAdminActionMenu(targetPlayerId)
			end
			
-- taken from Easy Admin (thx to Bluethefurry)  --
			local text = {}
			-- cheat checks
			local targetGod = GetPlayerInvincible(targetPlayerId)
			if targetGod then
				table.insert(text,"Godmode: ~r~Found~w~")
			else
				table.insert(text,"Godmode: ~g~Not Found~w~")
			end
			if not CanPedRagdoll(targetPed) and not IsPedInAnyVehicle(targetPed, false) and (GetPedParachuteState(targetPed) == -1 or GetPedParachuteState(targetPed) == 0) and not IsPedInParachuteFreeFall(targetPed) then
				table.insert(text,"~r~Anti-Ragdoll~w~")
			end
			-- health info
			table.insert(text,"Health"..": "..GetEntityHealth(targetPed).."/"..GetEntityMaxHealth(targetPed))
			table.insert(text,"Armor"..": "..GetPedArmour(targetPed))

			for i,theText in pairs(text) do
				SetTextFont(0)
				SetTextProportional(1)
				SetTextScale(0.0, 0.30)
				SetTextDropshadow(0, 0, 0, 0, 255)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextDropShadow()
				SetTextOutline()
				SetTextEntry("STRING")
				AddTextComponentString(theText)
				EndTextCommandDisplayText(0.3, 0.7+(i/30))
			end
-- end of taken from easyadmin -- 
		end

  	end
end)