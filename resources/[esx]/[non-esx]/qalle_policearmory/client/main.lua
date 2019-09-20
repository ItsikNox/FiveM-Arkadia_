ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(5)

		TriggerEvent("esx:getSharedObject", function(library)
			ESX = library
		end)
    end

    if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()

		RefreshPed()
    end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(response)
	ESX.PlayerData = response

	RefreshPed()
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(response)
	ESX.PlayerData["job"] = response
end)

Citizen.CreateThread(function()
	Citizen.Wait(100)

	while true do
		local sleepThread = 500

		if not Config.OnlyPolicemen or (Config.OnlyPolicemen and ESX.PlayerData["job"] and ESX.PlayerData["job"]["name"] == "police") then

			local ped = PlayerPedId()
			local pedCoords = GetEntityCoords(ped)

			local dstCheck = GetDistanceBetweenCoords(pedCoords, Config.Armory["x"], Config.Armory["y"], Config.Armory["z"], true)

			if dstCheck <= 5.0 then
				sleepThread = 5

				local text = "Armurerie"

				if dstCheck <= 0.5 then
					text = "[~g~E~s~] Armurerie"

					if IsControlJustPressed(0, 38) then
						OpenPoliceArmory()
					end
				end

				ESX.Game.Utils.DrawText3D(Config.Armory, text, 0.6)
			end
		end

		Citizen.Wait(sleepThread)
	end
end)

OpenPoliceArmory = function()
	PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)

	local elements = {
		{ ["label"] = "Stockage Armes", ["action"] = "weapon_storage" },
		{ ["label"] = "Déposé Armes", ["action"] = "weapon_supp" }
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "police_armory_menu",
		{
			title    = "Armurerie Police",
			align    = "center",
			elements = elements
		},
	function(data, menu)
		local action = data.current["action"]

		if action == "weapon_storage" then
			OpenWeaponStorage()
		elseif action == "weapon_supp" then
			RemoveAllPedWeapons(GetPlayerPed(-1), true)
			ESX.ShowNotification("Vous avez déposé vos armes.")
		end		
	end, function(data, menu)
		PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)

		menu.close()
	end, function(data, menu)
		PlaySoundFrontend(-1, 'NAV', 'HUD_AMMO_SHOP_SOUNDSET', false)
	end)
end

OpenWeaponStorage = function()
	PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)

	local elements = {}

	local Location = Config.Armory
	local PedLocation = Config.ArmoryPed

	for i = 1, #Config.ArmoryWeapons, 1 do
		local weapon = Config.ArmoryWeapons[i]

		table.insert(elements, { ["label"] = ESX.GetWeaponLabel(weapon["hash"]), ["weapon"] = weapon })
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "police_armory_weapon_menu",
		{
			title    = "Armurerie armes police",
			align    = "center",
			elements = elements
		},
	function(data, menu)
		local anim = data.current["weapon"]["type"]
		local weaponHash = data.current["weapon"]["hash"]

		ESX.UI.Menu.CloseAll()

		local closestPed, closestPedDst = ESX.Game.GetClosestPed(PedLocation)

		if (DoesEntityExist(closestPed) and closestPedDst >= 5.0) or IsPedAPlayer(closestPed) then
			RefreshPed(true) -- failsafe if the ped somehow dissapear.

			ESX.ShowNotification("Veuillez réessayer.")

			return
		end

		if IsEntityPlayingAnim(closestPed, "mp_cop_armoury", "pistol_on_counter_cop", 3) or IsEntityPlayingAnim(closestPed, "mp_cop_armoury", "rifle_on_counter_cop", 3) then
			ESX.ShowNotification("Attendez votre tour, s'il vous plaît.")
			return
		end

		if not NetworkHasControlOfEntity(closestPed) then
			NetworkRequestControlOfEntity(closestPed)

			Citizen.Wait(1000)
		end

		SetEntityCoords(closestPed, PedLocation["x"], PedLocation["y"], PedLocation["z"] - 0.985)
		SetEntityHeading(closestPed, PedLocation["h"])

		SetEntityCoords(PlayerPedId(), Location["x"], Location["y"], Location["z"] - 0.985)
		SetEntityHeading(PlayerPedId(), Location["h"])
		SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"), true)

		local animLib = "mp_cop_armoury"

		LoadModels({ animLib })

		if DoesEntityExist(closestPed) and closestPedDst <= 5.0 then
			TaskPlayAnim(closestPed, animLib, anim .. "_on_counter_cop", 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)

			Citizen.Wait(1100)

			GiveWeaponToPed(closestPed, GetHashKey(weaponHash), 1, false, true)
			SetCurrentPedWeapon(closestPed, GetHashKey(weaponHash), true)

			TaskPlayAnim(PlayerPedId(), animLib, anim .. "_on_counter", 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)

			Citizen.Wait(3100)

			RemoveWeaponFromPed(closestPed, GetHashKey(weaponHash))

			Citizen.Wait(15)

			GiveWeaponToPed(PlayerPedId(), GetHashKey(weaponHash), Config.ReceiveAmmo, false, true)
			SetCurrentPedWeapon(PlayerPedId(), GetHashKey(weaponHash), true)

			ClearPedTasks(closestPed)

			TriggerServerEvent("qalle_policearmory:giveWeapon", weaponHash)
		end

		UnloadModels()
	end, function(data, menu)
		PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)

		menu.close()
	end, function(data, menu)
		PlaySoundFrontend(-1, 'NAV', 'HUD_AMMO_SHOP_SOUNDSET', false)
	end)
end

RefreshPed = function(spawn)
	local Location = Config.ArmoryPed

	ESX.TriggerServerCallback("qalle_policearmory:pedExists", function(Exists)
		if Exists and not spawn then
			return
		else
			LoadModels({ GetHashKey(Location["hash"]) })

			local pedId = CreatePed(5, Location["hash"], Location["x"], Location["y"], Location["z"] - 0.985, Location["h"], true)

			SetPedCombatAttributes(pedId, 46, true)                     
			SetPedFleeAttributes(pedId, 0, 0)                      
			SetBlockingOfNonTemporaryEvents(pedId, true)
			
			SetEntityAsMissionEntity(pedId, true, true)
			SetEntityInvincible(pedId, true)

			FreezeEntityPosition(pedId, true)
		end
	end)
end

local CachedModels = {}

LoadModels = function(models)
	for modelIndex = 1, #models do
		local model = models[modelIndex]

		table.insert(CachedModels, model)

		if IsModelValid(model) then
			while not HasModelLoaded(model) do
				RequestModel(model)
	
				Citizen.Wait(10)
			end
		else
			while not HasAnimDictLoaded(model) do
				RequestAnimDict(model)
	
				Citizen.Wait(10)
			end    
		end
	end
end

UnloadModels = function()
	for modelIndex = 1, #CachedModels do
		local model = CachedModels[modelIndex]

		if IsModelValid(model) then
			SetModelAsNoLongerNeeded(model)
		else
			RemoveAnimDict(model)   
		end

		table.remove(CachedModels, modelIndex)
	end
end