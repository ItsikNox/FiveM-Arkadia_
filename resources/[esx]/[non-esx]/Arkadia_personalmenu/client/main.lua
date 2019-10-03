ESX = nil

function notification(title, subject, msg)

	local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(-1))
  
	ESX.ShowAdvancedNotification(title, subject, msg, mugshotStr, 1)
  
	UnregisterPedheadshot(mugshot)
  
end

_menuPool = nil
local personalmenu = {}

local invItem, wepItem, billItem, mainMenu, itemMenu, weaponItemMenu = {}, {}, {}, nil, nil, nil

local isDead, inAnim = false, false

local playerGroup, noclip, godmode, visible = nil, false, false, false

local actualGPS, actualGPSIndex = _U('default_gps'), 1
local actualDemarche, actualDemarcheIndex = _U('default_demarche'), 1
local actualVoice, actualVoiceIndex = _U('default_voice'), 2

local societymoney, societymoney2 = nil, nil

local wepList = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	if Config.doublejob then
		while ESX.GetPlayerData().job2 == nil do
			Citizen.Wait(10)
		end
	end

	ESX.PlayerData = ESX.GetPlayerData()

	while playerGroup == nil do
		ESX.TriggerServerCallback('KorioZ-PersonalMenu:Admin_getUsergroup', function(group) playerGroup = group end)
		Citizen.Wait(10)
	end

	while actualSkin == nil do
		TriggerEvent('skinchanger:getSkin', function(skin) actualSkin = skin end)
		Citizen.Wait(10)
	end

	RefreshMoney()

	if Config.doublejob then
		RefreshMoney2()
	end

	wepList = ESX.GetWeaponList()

	_menuPool = NativeUI.CreatePool()

	mainMenu = NativeUI.CreateMenu(Config.servername, _U('mainmenu_subtitle'))
	itemMenu = NativeUI.CreateMenu(Config.servername, _U('inventory_actions_subtitle'))
	weaponItemMenu = NativeUI.CreateMenu(Config.servername, _U('loadout_actions_subtitle'))
	_menuPool:Add(mainMenu)
	_menuPool:Add(itemMenu)
	_menuPool:Add(weaponItemMenu)
end)

Citizen.CreateThread(function()
	local fixingVoice = true

	NetworkSetTalkerProximity(0.1)

	while true do
		NetworkSetTalkerProximity(8.0)
		if not fixingVoice then
			break
		end
		Citizen.Wait(10)
	end

	SetTimeout(10000, function()
		fixingVoice = false
	end)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

AddEventHandler('esx:onPlayerDeath', function()
	isDead = true
	_menuPool:CloseAllMenus()
	ESX.UI.Menu.CloseAll()
end)

AddEventHandler('playerSpawned', function()
	isDead = false
end)

--AddEventHandler('esx_ambulancejob:multicharacter', function()
--	isDead = false
--end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	RefreshMoney()
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	ESX.PlayerData.job2 = job2
	RefreshMoney2()
end)

function RefreshMoney()
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
		ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
			UpdateSocietyMoney(money)
		end, ESX.PlayerData.job.name)
	end
end

function RefreshMoney2()
	if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
		ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
			UpdateSociety2Money(money)
		end, ESX.PlayerData.job2.name)
	end
end

RegisterNetEvent('esx_addonaccount:setMoney')
AddEventHandler('esx_addonaccount:setMoney', function(society, money)
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' and 'society_' .. ESX.PlayerData.job.name == society then
		UpdateSocietyMoney(money)
	end
	if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' and 'society_' .. ESX.PlayerData.job2.name == society then
		UpdateSociety2Money(money)
	end
end)

function UpdateSocietyMoney(money)
	societymoney = ESX.Math.GroupDigits(money)
end

function UpdateSociety2Money(money)
	societymoney2 = ESX.Math.GroupDigits(money)
end

--Message text joueur
function Text(text)
	SetTextColour(186, 186, 186, 255)
	SetTextFont(0)
	SetTextScale(0.378, 0.378)
	SetTextWrap(0.0, 1.0)
	SetTextCentre(false)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 205)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.017, 0.977)
end

function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, "", inputText, "", "", "", maxLength)
	blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
		blockinput = false
        return result
    else
        Citizen.Wait(500)
		blockinput = false
        return nil
    end
end

-- Weapon Menu --

RegisterNetEvent("KorioZ-PersonalMenu:Weapon_addAmmoToPedC")
AddEventHandler("KorioZ-PersonalMenu:Weapon_addAmmoToPedC", function(value, quantity)
	local weaponHash = GetHashKey(value)

	if HasPedGotWeapon(plyPed, weaponHash, false) and value ~= 'WEAPON_UNARMED' then
		AddAmmoToPed(plyPed, value, quantity)
	end
end)

-- Admin Menu --

RegisterNetEvent('KorioZ-PersonalMenu:Admin_BringC')
AddEventHandler('KorioZ-PersonalMenu:Admin_BringC', function(plyPedCoords)
	SetEntityCoords(plyPed, plyPedCoords)
end)

-- GOTO JOUEUR
function admin_tp_toplayer()
	local plyId = KeyboardInput("KORIOZ_BOX_ID", _U('dialogbox_playerid'), "", 8)

	if plyId ~= nil then
		plyId = tonumber(plyId)
		
		if type(plyId) == 'number' then
			local targetPlyCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(plyId)))
			SetEntityCoords(plyPed, targetPlyCoords)
		end
	end
end
-- FIN GOTO JOUEUR

-- TP UN JOUEUR A MOI
function admin_tp_playertome()
	local plyId = KeyboardInput("KORIOZ_BOX_ID", _U('dialogbox_playerid'), "", 8)

	if plyId ~= nil then
		plyId = tonumber(plyId)
		
		if type(plyId) == 'number' then
			local plyPedCoords = GetEntityCoords(plyPed)
			TriggerServerEvent('KorioZ-PersonalMenu:Admin_BringS', plyId, plyPedCoords)
		end
	end
end
-- FIN TP UN JOUEUR A MOI

-- TP A POSITION
function admin_tp_pos()
	local pos = KeyboardInput("KORIOZ_BOX_XYZ", _U('dialogbox_xyz'), "", 50)

	if pos ~= nil and pos ~= '' then
		local _, _, x, y, z = string.find(pos, "([%d%.]+) ([%d%.]+) ([%d%.]+)")

		if x ~= nil and y ~= nil and z ~= nil then
			SetEntityCoords(plyPed, x + .0, y + .0, z + .0)
		end
	end
end
-- FIN TP A POSITION

-- FONCTION NOCLIP 
function admin_no_clip()
	noclip = not noclip

	if noclip then
		SetEntityInvincible(plyPed, true)
		SetEntityVisible(plyPed, false, false)
		notification("NoClip", "Administration", "NoClip ~g~Activé")
	else
		SetEntityInvincible(plyPed, false)
		SetEntityVisible(plyPed, true, false)
		notification("NoClip", "Administration", "NoClip ~r~Désactivé")
	end
end

function getPosition()
	local x, y, z = table.unpack(GetEntityCoords(plyPed, true))

	return x, y, z
end

function getCamDirection()
	local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(plyPed)
	local pitch = GetGameplayCamRelativePitch()

	local x = -math.sin(heading * math.pi/180.0)
	local y = math.cos(heading * math.pi/180.0)
	local z = math.sin(pitch * math.pi/180.0)

	local len = math.sqrt(x * x + y * y + z * z)

	if len ~= 0 then
		x = x/len
		y = y/len
		z = z/len
	end

	return x, y, z
end

function isNoclip()
	return noclip
end
-- FIN NOCLIP

-- GOD MODE
function admin_godmode()
	godmode = not godmode

	if godmode then
		SetEntityInvincible(plyPed, true)
		notification("GodMode", "Administration", "GodMode ~g~Activé")
	else
		SetEntityInvincible(plyPed, false)
		notification("GodMode", "Administration", "GodMode ~r~Désactivé")
	end
end
-- FIN GOD MODE

-- INVISIBLE
function admin_mode_fantome()
	invisible = not invisible

	if invisible then
		SetEntityVisible(plyPed, false, false)
		notification("Invisible", "Administration", "Mode Fantôme ~g~Activé")
	else
		SetEntityVisible(plyPed, true, false)
		notification("Invisible", "Administration", "Mode Fantôme ~r~Désactivé")
	end
end
-- FIN INVISIBLE

-- Réparer vehicule
function admin_vehicle_repair()
	local car = GetVehiclePedIsIn(plyPed, false)

	SetVehicleFixed(car)
	SetVehicleDirtLevel(car, 0.0)
end
-- FIN Réparer vehicule

-- Spawn vehicule
function admin_vehicle_spawn()
	local vehicleName = KeyboardInput("KORIOZ_BOX_VEHICLE_NAME", _U('dialogbox_vehiclespawner'), "", 50)

	if vehicleName ~= nil then
		vehicleName = tostring(vehicleName)
		
		if type(vehicleName) == 'string' then
			local car = GetHashKey(vehicleName)
				
			Citizen.CreateThread(function()
				RequestModel(car)

				while not HasModelLoaded(car) do
					Citizen.Wait(0)
				end

				local x, y, z = table.unpack(GetEntityCoords(plyPed, true))

				local veh = CreateVehicle(car, x, y, z, 0.0, true, false)
				local id = NetworkGetNetworkIdFromEntity(veh)

				SetEntityVelocity(veh, 2000)
				SetVehicleOnGroundProperly(veh)
				SetVehicleHasBeenOwnedByPlayer(veh, true)
				SetNetworkIdCanMigrate(id, true)
				SetVehRadioStation(veh, "OFF")
				SetPedIntoVehicle(plyPed, veh, -1)
			end)
		end
	end
end
-- FIN Spawn vehicule

-- flipVehicle
function admin_vehicle_flip()
	local plyCoords = GetEntityCoords(plyPed)
	local closestCar = GetClosestVehicle(plyCoords['x'], plyCoords['y'], plyCoords['z'], 10.0, 0, 70)
	local plyCoords = plyCoords + vector3(0, 2, 0)

	SetEntityCoords(closestCar, plyCoords)

	notification("Flip Véhicule", "Administration", "Retournement du véhicule ~g~effectué")
end
-- FIN flipVehicle

-- GIVE DE L'ARGENT
function admin_give_money()
	local amount = KeyboardInput("KORIOZ_BOX_AMOUNT", _U('dialogbox_amount'), "", 8)

	if amount ~= nil then
		amount = tonumber(amount)
		
		if type(amount) == 'number' then
			TriggerServerEvent('KorioZ-PersonalMenu:Admin_giveCash', amount)
		end
	end
end
-- FIN GIVE DE L'ARGENT

-- GIVE DE L'ARGENT EN BANQUE
function admin_give_bank()
	local amount = KeyboardInput("KORIOZ_BOX_AMOUNT", _U('dialogbox_amount'), "", 8)

	if amount ~= nil then
		amount = tonumber(amount)
		
		if type(amount) == 'number' then
			TriggerServerEvent('KorioZ-PersonalMenu:Admin_giveBank', amount)
		end
	end
end
-- FIN GIVE DE L'ARGENT EN BANQUE

-- GIVE DE L'ARGENT SALE
function admin_give_dirty()
	local amount = KeyboardInput("KORIOZ_BOX_AMOUNT", _U('dialogbox_amount'), "", 8)

	if amount ~= nil then
		amount = tonumber(amount)
		
		if type(amount) == 'number' then
			TriggerServerEvent('KorioZ-PersonalMenu:Admin_giveDirtyMoney', amount)
		end
	end
end
-- FIN GIVE DE L'ARGENT SALE

-- Afficher Coord
function modo_showcoord()
	showcoord = not showcoord
end
-- FIN Afficher Coord

-- Afficher Nom
function modo_showname()
	showname = not showname
end
-- FIN Afficher Nom

-- TP MARKER
function admin_tp_marker()
	local WaypointHandle = GetFirstBlipInfoId(8)

	if DoesBlipExist(WaypointHandle) then
		local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

		for height = 1, 1000 do
			SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

			local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

			if foundGround then
				SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

				break
			end

			Citizen.Wait(0)
		end

		notification("Téléportation", "Administration", "Téléportation ~g~Effectuée")
	else
		notification("Téléportation", "Administration", "Aucun ~r~Marqueur")
	end
end
-- FIN TP MARKER

-- HEAL JOUEUR
function admin_heal_player()
	local plyId = KeyboardInput("KORIOZ_BOX_ID", _U('dialogbox_playerid'), "", 8)

	if plyId ~= nil then
		plyId = tonumber(plyId)
		
		if type(plyId) == 'number' then
			TriggerServerEvent('esx_ambulancejob:revive', plyId)
		end
	end
end
-- FIN HEAL JOUEUR

function changer_skin()
	_menuPool:CloseAllMenus()
	Citizen.Wait(100)
	TriggerEvent('esx_skin:openSaveableMenu', source)
end

function save_skin()
	TriggerEvent('esx_skin:requestSaveSkin', source)
end

function startAttitude(lib, anim)
	Citizen.CreateThread(function()
		RequestAnimSet(anim)

		while not HasAnimSetLoaded(anim) do
			Citizen.Wait(0)
		end

		SetPedMotionBlur(plyPed, false)
		SetPedMovementClipset(plyPed, anim, true)
	end)
end

function startAnim(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(plyPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
	end)
end

function startAnimAction(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(plyPed, lib, anim, 8.0, 1.0, -1, 49, 0, false, false, false)
	end)
end

function startScenario(anim)
	TaskStartScenarioInPlace(plyPed, anim, 0, false)
end

function AddMenuInventoryMenu(menu)
	inventorymenu = _menuPool:AddSubMenu(menu, _U('inventory_title'))
	local invCount = {}

	for i=1, #ESX.PlayerData.inventory, 1 do
		local count = ESX.PlayerData.inventory[i].count

		if count > 0 then
			local label = ESX.PlayerData.inventory[i].label
			local value = ESX.PlayerData.inventory[i].name

			invCount = {}

			for i = 1, count, 1 do
				table.insert(invCount, i)
			end
			
			table.insert(invItem, value)

			invItem[value] = NativeUI.CreateListItem(label .. " (" .. count .. ")", invCount, 1)
			inventorymenu.SubMenu:AddItem(invItem[value])
		end
	end

	local useItem = NativeUI.CreateItem(_U('inventory_use_button'), "")
	itemMenu:AddItem(useItem)

	local giveItem = NativeUI.CreateItem(_U('inventory_give_button'), "")
	itemMenu:AddItem(giveItem)

	local dropItem = NativeUI.CreateItem(_U('inventory_drop_button'), "")
	dropItem:SetRightBadge(4)
	itemMenu:AddItem(dropItem)

	inventorymenu.SubMenu.OnListSelect = function(sender, item, index)
		_menuPool:CloseAllMenus(true)
		itemMenu:Visible(true)

		for i = 1, #ESX.PlayerData.inventory, 1 do
			local label	    = ESX.PlayerData.inventory[i].label
			local count	    = ESX.PlayerData.inventory[i].count
			local value	    = ESX.PlayerData.inventory[i].name
			local usable	= ESX.PlayerData.inventory[i].usable
			local canRemove = ESX.PlayerData.inventory[i].canRemove
			local quantity  = index

			if item == invItem[value] then
				itemMenu.OnItemSelect = function(sender, item, index)
					if item == useItem then
						if usable then
							TriggerServerEvent('esx:useItem', value)
						else
							notification("Inventaire", "Notification", _U('not_usable', label))
						end
					elseif item == giveItem then
						local foundPlayers = false
						personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

						if personalmenu.closestDistance ~= -1 and personalmenu.closestDistance <= 3 then
			 				foundPlayers = true
						end

						if foundPlayers == true then
							local closestPed = GetPlayerPed(personalmenu.closestPlayer)

							if not IsPedSittingInAnyVehicle(closestPed) then
								if quantity ~= nil and count > 0 then
									TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(personalmenu.closestPlayer), 'item_standard', value, quantity)
									_menuPool:CloseAllMenus()
								else
									notification("Inventaire", "Notification", _U('amount_invalid'))
								end
							else
								notification("Inventaire", "Notification", _U('in_vehicle_give', label))
							end
						else
							notification("Inventaire", "Notification", _U('players_nearby'))
						end
					elseif item == dropItem then
						if canRemove then
							if not IsPedSittingInAnyVehicle(plyPed) then
								if quantity ~= nil then
									TriggerServerEvent('esx:removeInventoryItem', 'item_standard', value, quantity)
									_menuPool:CloseAllMenus()
								else
									notification("Inventaire", "Notification", _U('amount_invalid'))
								end
							else
								notification("Téléportation", "Notification", _U('in_vehicle_drop', label))
							end
						else
							notification("Téléportation", "Notification", _U('not_droppable', label))
						end
					end
				end
			end
		end
	end
end

function AddMenuWeaponMenu(menu)
	weaponMenu = _menuPool:AddSubMenu(menu, _U('loadout_title'))

	for i = 1, #wepList, 1 do
		local weaponHash = GetHashKey(wepList[i].name)

		if HasPedGotWeapon(plyPed, weaponHash, false) and wepList[i].name ~= 'WEAPON_UNARMED' then
			local ammo 		= GetAmmoInPedWeapon(plyPed, weaponHash)
			local label	    = wepList[i].label .. ' [' .. ammo .. ']'
			local value	    = wepList[i].name

			wepItem[value] = NativeUI.CreateItem(label, "")
			weaponMenu.SubMenu:AddItem(wepItem[value])
		end
	end

	local giveItem = NativeUI.CreateItem(_U('loadout_give_button'), "")
	weaponItemMenu:AddItem(giveItem)

	local giveMunItem = NativeUI.CreateItem(_U('loadout_givemun_button'), "")
	weaponItemMenu:AddItem(giveMunItem)

	local dropItem = NativeUI.CreateItem(_U('loadout_drop_button'), "")
	dropItem:SetRightBadge(4)
	weaponItemMenu:AddItem(dropItem)

	weaponMenu.SubMenu.OnItemSelect = function(sender, item, index)
		_menuPool:CloseAllMenus(true)
		weaponItemMenu:Visible(true)

		for i = 1, #wepList, 1 do
			local weaponHash = GetHashKey(wepList[i].name)

			if HasPedGotWeapon(plyPed, weaponHash, false) and wepList[i].name ~= 'WEAPON_UNARMED' then
				local ammo 		= GetAmmoInPedWeapon(plyPed, weaponHash)
				local value	    = wepList[i].name
				local label	    = wepList[i].label

				if item == wepItem[value] then
					weaponItemMenu.OnItemSelect = function(sender, item, index)
						if item == giveItem then
							local foundPlayers = false
							personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

							if personalmenu.closestDistance ~= -1 and personalmenu.closestDistance <= 3 then
				 				foundPlayers = true
							end

							if foundPlayers == true then
								local closestPed = GetPlayerPed(personalmenu.closestPlayer)

								if not IsPedSittingInAnyVehicle(closestPed) then
									TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(personalmenu.closestPlayer), 'item_weapon', value, ammo)
									_menuPool:CloseAllMenus()
								else
									notification("Gestions Armes", "Notification", _U('in_vehicle_give', label))
								end
							else
								notification("Gestions Armes", "Notification", _U('players_nearby'))
							end
						elseif item == giveMunItem then
							local quantity = KeyboardInput("KORIOZ_BOX_AMMO_AMOUNT", _U('dialogbox_amount_ammo'), "", 8)

							if quantity ~= nil then
								local post = true
								quantity = tonumber(quantity)

								if type(quantity) == 'number' then
									quantity = ESX.Math.Round(quantity)

									if quantity <= 0 then
										post = false
									end
								end

								local foundPlayers = false
								personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

								if personalmenu.closestDistance ~= -1 and personalmenu.closestDistance <= 3 then
				 					foundPlayers = true
								end

								if foundPlayers == true then
									local closestPed = GetPlayerPed(personalmenu.closestPlayer)

									if not IsPedSittingInAnyVehicle(closestPed) then
										if ammo > 0 then
											if post == true then
												if quantity <= ammo and quantity >= 0 then
													local finalAmmo = math.floor(ammo - quantity)
													SetPedAmmo(plyPed, value, finalAmmo)
													TriggerServerEvent('KorioZ-PersonalMenu:Weapon_addAmmoToPedS', GetPlayerServerId(personalmenu.closestPlayer), value, quantity)

													ESX.ShowNotification(_U('gave_ammo', quantity, GetPlayerName(personalmenu.closestPlayer)))
													_menuPool:CloseAllMenus()
												else
													notification("Gestions Armes", "Notification", _U('not_enough_ammo'))
												end
											else
												notification("Gestions Armes", "Notification", _U('amount_invalid'))
											end
										else
											notification("Gestions Armes", "Notification", _U('no_ammo'))
										end
									else
										notification("Gestions Armes", "Notification", _U('in_vehicle_give', label))
									end
								else
									notification("Gestions Armes", "Notification", _U('players_nearby'))
								end
							end
						elseif item == dropItem then
							if not IsPedSittingInAnyVehicle(plyPed) then
								TriggerServerEvent('esx:removeInventoryItem', 'item_weapon', value)
								_menuPool:CloseAllMenus()
							else
								notification("Gestions Armes", "Notification", _U('players_nearby', label))
							end
						end
					end
				end
			end
		end
	end
end

function AddMenuWalletMenu(menu)
	personalmenu.moneyOption = {
		_U('wallet_option_give'),
		_U('wallet_option_drop')
	}

	walletmenu = _menuPool:AddSubMenu(menu, _U('wallet_title'))

	local walletJob = NativeUI.CreateItem(_U('wallet_job_button', ESX.PlayerData.job.label, ESX.PlayerData.job.grade_label), "")
	walletmenu.SubMenu:AddItem(walletJob)

	local walletJob2 = nil

	if Config.doublejob then
		walletJob2 = NativeUI.CreateItem(_U('wallet_job2_button', ESX.PlayerData.job2.label, ESX.PlayerData.job2.grade_label), "")
		walletmenu.SubMenu:AddItem(walletJob2)
	end

	local walletMoney = NativeUI.CreateListItem(_U('wallet_money_button', ESX.Math.GroupDigits(ESX.PlayerData.money)), personalmenu.moneyOption, 1)
	walletmenu.SubMenu:AddItem(walletMoney)

	local walletbankMoney = nil
	local walletdirtyMoney = nil

	for i = 1, #ESX.PlayerData.accounts, 1 do
		if ESX.PlayerData.accounts[i].name == 'bank' then
			walletbankMoney = NativeUI.CreateItem(_U('wallet_bankmoney_button', ESX.Math.GroupDigits(ESX.PlayerData.accounts[i].money)), "")
			walletmenu.SubMenu:AddItem(walletbankMoney)
		end

		if ESX.PlayerData.accounts[i].name == 'black_money' then
			walletdirtyMoney = NativeUI.CreateListItem(_U('wallet_blackmoney_button', ESX.Math.GroupDigits(ESX.PlayerData.accounts[i].money)), personalmenu.moneyOption, 1)
			walletmenu.SubMenu:AddItem(walletdirtyMoney)
		end
	end
	
	local showID = nil
	local showDriver = nil
	local showFirearms = nil
	local checkID = nil
	local checkDriver = nil
	local checkFirearms = nil

	if Config.EnableJsfourIDCard then
		showID = NativeUI.CreateItem(_U('wallet_show_idcard_button'), "")
		walletmenu.SubMenu:AddItem(showID)

		checkID = NativeUI.CreateItem(_U('wallet_check_idcard_button'), "")
		walletmenu.SubMenu:AddItem(checkID)
       
        showDriver = NativeUI.CreateItem(_U('wallet_show_driver_button'), "")
        walletmenu.SubMenu:AddItem(showDriver)
       
        checkDriver = NativeUI.CreateItem(_U('wallet_check_driver_button'), "")
        walletmenu.SubMenu:AddItem(checkDriver)
           
        showFirearms = NativeUI.CreateItem(_U('wallet_show_firearms_button'), "")
        walletmenu.SubMenu:AddItem(showFirearms)
       
        checkFirearms = NativeUI.CreateItem(_U('wallet_check_firearms_button'), "")
        walletmenu.SubMenu:AddItem(checkFirearms)
	end

	walletmenu.SubMenu.OnItemSelect = function(sender, item, index)
		if Config.EnableJsfourIDCard then
			if item == showID then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()
											
				if personalmenu.closestDistance ~= -1 and personalmenu.closestDistance <= 3.0 then
					TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(personalmenu.closestPlayer))
				else
					notification("Portefeuilles", "Notification", _U('players_nearby'))
				end
			elseif item == checkID then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
			elseif item == showDriver then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()
											
				if personalmenu.closestDistance ~= -1 and personalmenu.closestDistance <= 3.0 then
					TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(personalmenu.closestPlayer), 'driver')
				else
					notification("Portefeuilles", "Notification", _U('players_nearby'))
				end
			elseif item == checkDriver then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
			elseif item == showFirearms then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()
											
				if personalmenu.closestDistance ~= -1 and personalmenu.closestDistance <= 3.0 then
					TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(personalmenu.closestPlayer), 'weapon')
				else
					notification("Portefeuilles", "Notification", _U('players_nearby'))
				end
			elseif item == checkFirearms then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
			end
		end
	end

	walletmenu.SubMenu.OnListSelect = function(sender, item, index)
		if index == 1 then
			local quantity = KeyboardInput("KORIOZ_BOX_AMOUNT", _U('dialogbox_amount'), "", 8)

			if quantity ~= nil then
				local post = true
				quantity = tonumber(quantity)

				if type(quantity) == 'number' then
					quantity = ESX.Math.Round(quantity)

					if quantity <= 0 then
						post = false
					end
				end

				local foundPlayers = false
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestDistance ~= -1 and personalmenu.closestDistance <= 3 then
					foundPlayers = true
				end

				if foundPlayers == true then
					local closestPed = GetPlayerPed(personalmenu.closestPlayer)

					if not IsPedSittingInAnyVehicle(closestPed) then
						if post == true then
							if item == walletMoney then
								TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(personalmenu.closestPlayer), 'item_money', 'money', quantity)
								_menuPool:CloseAllMenus()
							elseif item == walletdirtyMoney then
								TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(personalmenu.closestPlayer), 'item_account', 'black_money', quantity)
								_menuPool:CloseAllMenus()
							end
						else
							ESX.ShowNotification(_U('amount_invalid'))
						end
					else
						if item == walletMoney then
							notification("Portefeuilles", "Notification", _U('in_vehicle_give', 'de l\'argent'))
							elseif item == walletdirtyMoney then
							notification("Portefeuilles", "Notification", _U('in_vehicle_give', 'de l\'argent sale'))
						end
					end
				else
					notification("Portefeuilles", "Notification", _U('players_nearby'))
				end
			end
		elseif index == 2 then
			local quantity = KeyboardInput("KORIOZ_BOX_AMOUNT", _U('dialogbox_amount'), "", 8)

			if quantity ~= nil then
				local post = true
				quantity = tonumber(quantity)

				if type(quantity) == 'number' then
					quantity = ESX.Math.Round(quantity)

					if quantity <= 0 then
						post = false
					end
				end

				if not IsPedSittingInAnyVehicle(plyPed) then
					if post == true then
						if item == walletMoney then
							TriggerServerEvent('esx:removeInventoryItem', 'item_money', 'money', quantity)
							_menuPool:CloseAllMenus()
						elseif item == walletdirtyMoney then
							TriggerServerEvent('esx:removeInventoryItem', 'item_account', 'black_money', quantity)
							_menuPool:CloseAllMenus()
						end
					else
						notification("Portefeuilles", "Notification", _U('amount_invalid'))
					end
				else
					if item == walletMoney then
						notification("Portefeuilles", "Notification", _U('in_vehicle_drop', 'de l\'argent'))
						elseif item == walletdirtyMoney then
						notification("Portefeuilles", "Notification", _U('in_vehicle_drop', 'de l\'argent sale'))
					end
				end
			end
		end
	end
end



function AddMenuCleMenu(menu)
	cleMenu = _menuPool:AddSubMenu(menu, ('🔑 ~o~Mes Clés'))

	local cleItem = NativeUI.CreateItem(('Gestion des clés'), "")
	cleMenu.SubMenu:AddItem(cleItem)

	cleMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == cleItem then
			TriggerEvent("esx_menu:key")
			_menuPool:CloseAllMenus()
		end
	end
end

function AddMenuSIMMenu(menu)
	simMenu = _menuPool:AddSubMenu(menu, ('📲 ~o~Carte SIM'))

	local simItem = NativeUI.CreateItem(('Gestion des cartes SIM'), "")
	simMenu.SubMenu:AddItem(simItem)

	simMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == simItem then
			openCarteSIM()
			_menuPool:CloseAllMenus()
		end
	end
end

-- Hide/Show HUD
local interface = false
local source = true

function openInterface()
	interface = not interface
	if not interface then -- hide
  		TriggerEvent('ui:toggle', source,false)
	elseif interface then -- show
	  	TriggerEvent('ui:toggle', source,true)
	end
  end


  local ragdoll = false
  function setRagdoll(flag)
	ragdoll = flag
  end
  Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(0)
	  if ragdoll then
		SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
	  end
	end
  end)
  
  ragdol = true
  RegisterNetEvent("Ragdoll")
  AddEventHandler("Ragdoll", function()
	  if ( ragdol ) then
		  setRagdoll(true)
		  ragdol = false
	  else
		  setRagdoll(false)
		  ragdol = true
	  end
  end)

  function Ragdoll()
	TriggerEvent("Ragdoll", source)
end



function AddMenuDiversMenu(menu)
	DiversMenu = _menuPool:AddSubMenu(menu, ('~r~🔩 Divers'))
	
	local Description = "Afficher ou Cacher l'HUD"
	local Description1 = "Dormir ou Se Réveiller"
	
    local hudItem = NativeUI.CreateCheckboxItem("Afficher | Cacher l'HUD", Hud, Description, 1)
	DiversMenu.SubMenu:AddItem(hudItem)
	local ragdollItem = NativeUI.CreateItem(('Dormir | Se Réveiller'), Description1)
	DiversMenu.SubMenu:AddItem(ragdollItem)
	
    DiversMenu.SubMenu.OnCheckboxChange = function(sender, item, checked_)
	    if item == hudItem then
			source = checked_
			openInterface()
		end
	end

DiversMenu.SubMenu.OnItemSelect = function(sender, item, index)
	if item == ragdollItem then
		Ragdoll()
		end
	end
end

function AddMenuFacturesMenu(menu)
	billMenu = _menuPool:AddSubMenu(menu, _U('bills_title'))
	billItem = {}

	ESX.TriggerServerCallback('KorioZ-PersonalMenu:Bill_getBills', function(bills)
		for i = 1, #bills, 1 do
			local label = bills[i].label
			local amount = bills[i].amount
			local value = bills[i].id

			table.insert(billItem, value)

			billItem[value] = NativeUI.CreateItem(label, "")
			billItem[value]:RightLabel("$" .. ESX.Math.GroupDigits(amount))
			billMenu.SubMenu:AddItem(billItem[value])
		end

		billMenu.SubMenu.OnItemSelect = function(sender, item, index)
			for i = 1, #bills, 1 do
				local label  = bills[i].label
				local value = bills[i].id

				if item == billItem[value] then
					ESX.TriggerServerCallback('esx_billing:payBill', function()
						_menuPool:CloseAllMenus()
					end, value)
				end
			end
		end
	end)
end

function AddMenuClothesMenu(menu)
	clothesMenu = _menuPool:AddSubMenu(menu, _U('clothes_title'))

	local torsoItem = NativeUI.CreateItem(_U('clothes_top'), "")
	clothesMenu.SubMenu:AddItem(torsoItem)
	local pantsItem = NativeUI.CreateItem(_U('clothes_pants'), "")
	clothesMenu.SubMenu:AddItem(pantsItem)
	local shoesItem = NativeUI.CreateItem(_U('clothes_shoes'), "")
	clothesMenu.SubMenu:AddItem(shoesItem)
	local bagItem = NativeUI.CreateItem(_U('clothes_bag'), "")
	clothesMenu.SubMenu:AddItem(bagItem)
	local bproofItem = NativeUI.CreateItem(_U('clothes_bproof'), "")
	clothesMenu.SubMenu:AddItem(bproofItem)

	clothesMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == torsoItem then
			setUniform('torso', plyPed)
		elseif item == pantsItem then
			setUniform('pants', plyPed)
		elseif item == shoesItem then
			setUniform('shoes', plyPed)
		elseif item == bagItem then
			setUniform('bag', plyPed)
		elseif item == bproofItem then
			setUniform('bproof', plyPed)
		end
	end
end

function setUniform(value, plyPed)
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:getSkin', function(skina)
			if value == 'torso' then
				startAnimAction("clothingtie", "try_tie_neutral_a")
				Citizen.Wait(1000)
				ClearPedTasks(plyPed)

				if skin.torso_1 ~= skina.torso_1 then
					TriggerEvent('skinchanger:loadClothes', skina, {['torso_1'] = skin.torso_1, ['torso_2'] = skin.torso_2, ['tshirt_1'] = skin.tshirt_1, ['tshirt_2'] = skin.tshirt_2, ['arms'] = skin.arms})
				else
					TriggerEvent('skinchanger:loadClothes', skina, {['torso_1'] = 15, ['torso_2'] = 0, ['tshirt_1'] = 15, ['tshirt_2'] = 0, ['arms'] = 15})
				end
			elseif value == 'pants' then
				if skin.pants_1 ~= skina.pants_1 then
					TriggerEvent('skinchanger:loadClothes', skina, {['pants_1'] = skin.pants_1, ['pants_2'] = skin.pants_2})
				else
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skina, {['pants_1'] = 61, ['pants_2'] = 1})
					else
						TriggerEvent('skinchanger:loadClothes', skina, {['pants_1'] = 15, ['pants_2'] = 0})
					end
				end
			elseif value == 'shoes' then
				if skin.shoes_1 ~= skina.shoes_1 then
					TriggerEvent('skinchanger:loadClothes', skina, {['shoes_1'] = skin.shoes_1, ['shoes_2'] = skin.shoes_2})
				else
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skina, {['shoes_1'] = 34, ['shoes_2'] = 0})
					else
						TriggerEvent('skinchanger:loadClothes', skina, {['shoes_1'] = 35, ['shoes_2'] = 0})
					end
				end
			elseif value == 'bag' then
				if skin.bags_1 ~= skina.bags_1 then
					TriggerEvent('skinchanger:loadClothes', skina, {['bags_1'] = skin.bags_1, ['bags_2'] = skin.bags_2})
				else
					TriggerEvent('skinchanger:loadClothes', skina, {['bags_1'] = 0, ['bags_2'] = 0})
				end
			elseif value == 'bproof' then
				startAnimAction("clothingtie", "try_tie_neutral_a")
				Citizen.Wait(1000)
				ClearPedTasks(plyPed)

				if skin.bproof_1 ~= skina.bproof_1 then
					TriggerEvent('skinchanger:loadClothes', skina, {['bproof_1'] = skin.bproof_1, ['bproof_2'] = skin.bproof_2})
				else
					TriggerEvent('skinchanger:loadClothes', skina, {['bproof_1'] = 0, ['bproof_2'] = 0})
				end
			end
		end)
	end)
end

function AddMenuAccessoryMenu(menu)
	accessoryMenu = _menuPool:AddSubMenu(menu, _U('accessories_title'))

	local earsItem = NativeUI.CreateItem(_U('accessories_ears'), "")
	accessoryMenu.SubMenu:AddItem(earsItem)
	local glassesItem = NativeUI.CreateItem(_U('accessories_glasses'), "")
	accessoryMenu.SubMenu:AddItem(glassesItem)
	local helmetItem = NativeUI.CreateItem(_U('accessories_helmet'), "")
	accessoryMenu.SubMenu:AddItem(helmetItem)
	local maskItem = NativeUI.CreateItem(_U('accessories_mask'), "")
	accessoryMenu.SubMenu:AddItem(maskItem)

	accessoryMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == earsItem then
			SetUnsetAccessory('Ears')
		elseif item == glassesItem then
			SetUnsetAccessory('Glasses')
		elseif item == helmetItem then
			SetUnsetAccessory('Helmet')
		elseif item == maskItem then
			SetUnsetAccessory('Mask')
		end
	end
end

function SetUnsetAccessory(accessory)
	ESX.TriggerServerCallback('esx_accessories:get', function(hasAccessory, accessorySkin)
		local _accessory = string.lower(accessory)

		if hasAccessory then
			TriggerEvent('skinchanger:getSkin', function(skin)
				local mAccessory = -1
				local mColor = 0

				if _accessory == 'ears' then
				elseif _accessory == "glasses" then
					mAccessory = 0
					startAnimAction("clothingspecs", "try_glasses_positive_a")
					Citizen.Wait(1000)
					ClearPedTasks(plyPed)
				elseif _accessory == 'helmet' then
					startAnimAction("missfbi4", "takeoff_mask")
					Citizen.Wait(1000)
					ClearPedTasks(plyPed)
				elseif _accessory == "mask" then
					mAccessory = 0
					startAnimAction("missfbi4", "takeoff_mask")
					Citizen.Wait(850)
					ClearPedTasks(plyPed)
				end

				if skin[_accessory .. '_1'] == mAccessory then
					mAccessory = accessorySkin[_accessory .. '_1']
					mColor = accessorySkin[_accessory .. '_2']
				end

				local accessorySkin = {}
				accessorySkin[_accessory .. '_1'] = mAccessory
				accessorySkin[_accessory .. '_2'] = mColor
				TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
			end)
		else
			if _accessory == 'ears' then
				ESX.ShowNotification(_U('accessories_no_ears'))
			elseif _accessory == 'glasses' then
				ESX.ShowNotification(_U('accessories_no_glasses'))
			elseif _accessory == 'helmet' then
				ESX.ShowNotification(_U('accessories_no_helmet'))
			elseif _accessory == 'mask' then
				ESX.ShowNotification(_U('accessories_no_mask'))
			end
		end

	end, accessory)
end

function AddMenuAnimationMenu(menu)
	animMenu = _menuPool:AddSubMenu(menu, _U('animation_title'))

	AddStopAnim(animMenu)
	AddSubMenuPartyMenu(animMenu)
	AddSubMenuSaluteMenu(animMenu)
	AddSubMenuWorkMenu(animMenu)
	AddSubMenuMoodMenu(animMenu)
	AddSubMenuSportsMenu(animMenu)
	AddSubMenuOtherMenu(animMenu)
	AddSubMenuPEGI21Menu(animMenu)
end

function AddStopAnim(menu)
	plyPed = PlayerPedId()
	
	animStopMenu = _menuPool:AddSubMenu(menu.SubMenu, ('Stop Animation'))
	
	local stopAnim = NativeUI.CreateItem(('Stop Animation'), "")
	animStopMenu.SubMenu:AddItem(stopAnim)

	animStopMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == stopAnim then
			ClearPedTasks(plyPed)
		end
	end
end

function AddSubMenuPartyMenu(menu)
	animPartyMenu = _menuPool:AddSubMenu(menu.SubMenu, _U('animation_party_title'))

	local cigaretteItem = NativeUI.CreateItem(_U('animation_party_smoke'), "")
	animPartyMenu.SubMenu:AddItem(cigaretteItem)
	local musiqueItem = NativeUI.CreateItem(_U('animation_party_playsong'), "")
	animPartyMenu.SubMenu:AddItem(musiqueItem)
	local DJItem = NativeUI.CreateItem(_U('animation_party_dj'), "")
	animPartyMenu.SubMenu:AddItem(DJItem)
	local dancingItem = NativeUI.CreateItem(_U('animation_party_dancing'), "")
	animPartyMenu.SubMenu:AddItem(dancingItem)
	local guitarItem = NativeUI.CreateItem(_U('animation_party_airguitar'), "")
	animPartyMenu.SubMenu:AddItem(guitarItem)
	local shaggingItem = NativeUI.CreateItem(_U('animation_party_shagging'), "")
	animPartyMenu.SubMenu:AddItem(shaggingItem)
	local rockItem = NativeUI.CreateItem(_U('animation_party_rock'), "")
	animPartyMenu.SubMenu:AddItem(rockItem)
	local bourreItem = NativeUI.CreateItem(_U('animation_party_drunk'), "")
	animPartyMenu.SubMenu:AddItem(bourreItem)
	local vomitItem = NativeUI.CreateItem(_U('animation_party_vomit'), "")
	animPartyMenu.SubMenu:AddItem(vomitItem)

	animPartyMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == cigaretteItem then
			startScenario("WORLD_HUMAN_SMOKING")
		elseif item == musiqueItem then
			startScenario("WORLD_HUMAN_MUSICIAN")
		elseif item == DJItem then
			startAnim("anim@mp_player_intcelebrationmale@dj", "dj")
		elseif item == dancingItem then
			startScenario("WORLD_HUMAN_PARTYING")
		elseif item == guitarItem then
			startAnim("anim@mp_player_intcelebrationmale@air_guitar", "air_guitar")
		elseif item == shaggingItem then
			startAnim("anim@mp_player_intcelebrationfemale@air_shagging", "air_shagging")
		elseif item == rockItem then
			startAnim("mp_player_int_upperrock", "mp_player_int_rock")
		elseif item == bourreItem then
			startAnim("amb@world_human_bum_standing@drunk@idle_a", "idle_a")
		elseif item == vomitItem then
			startAnim("oddjobs@taxi@tie", "vomit_outside")
		end
	end
end

function AddSubMenuSaluteMenu(menu)
	animSaluteMenu = _menuPool:AddSubMenu(menu.SubMenu, _U('animation_salute_title'))

	local saluerItem = NativeUI.CreateItem(_U('animation_salute_saluate'), "")
	animSaluteMenu.SubMenu:AddItem(saluerItem)
	local serrerItem = NativeUI.CreateItem(_U('animation_salute_serrer'), "")
	animSaluteMenu.SubMenu:AddItem(serrerItem)
	local tchekItem = NativeUI.CreateItem(_U('animation_salute_tchek'), "")
	animSaluteMenu.SubMenu:AddItem(tchekItem)
	local banditItem = NativeUI.CreateItem(_U('animation_salute_bandit'), "")
	animSaluteMenu.SubMenu:AddItem(banditItem)
	local militaryItem = NativeUI.CreateItem(_U('animation_salute_military'), "")
	animSaluteMenu.SubMenu:AddItem(militaryItem)

	animSaluteMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == saluerItem then
			startAnim("gestures@m@standing@casual", "gesture_hello")
		elseif item == serrerItem then
			startAnim("mp_common", "givetake1_a")
		elseif item == tchekItem then
			startAnim("mp_ped_interaction", "handshake_guy_a")
		elseif item == banditItem then
			startAnim("mp_ped_interaction", "hugs_guy_a")
		elseif item == militaryItem then
			startAnim("mp_player_int_uppersalute", "mp_player_int_salute")
		end
	end
end

function AddSubMenuWorkMenu(menu)
	animWorkMenu = _menuPool:AddSubMenu(menu.SubMenu, _U('animation_work_title'))

	local suspectItem = NativeUI.CreateItem(_U('animation_work_suspect'), "")
	animWorkMenu.SubMenu:AddItem(suspectItem)
	local fishermanItem = NativeUI.CreateItem(_U('animation_work_fisherman'), "")
	animWorkMenu.SubMenu:AddItem(fishermanItem)
	local pInspectItem = NativeUI.CreateItem(_U('animation_work_inspect'), "")
	animWorkMenu.SubMenu:AddItem(pInspectItem)
	local pRadioItem = NativeUI.CreateItem(_U('animation_work_radio'), "")
	animWorkMenu.SubMenu:AddItem(pRadioItem)
	local pCirculationItem = NativeUI.CreateItem(_U('animation_work_circulation'), "")
	animWorkMenu.SubMenu:AddItem(pCirculationItem)
	local pBinocularsItem = NativeUI.CreateItem(_U('animation_work_binoculars'), "")
	animWorkMenu.SubMenu:AddItem(pBinocularsItem)
	local aHarvestItem = NativeUI.CreateItem(_U('animation_work_harvest'), "")
	animWorkMenu.SubMenu:AddItem(aHarvestItem)
	local dRepairItem = NativeUI.CreateItem(_U('animation_work_repair'), "")
	animWorkMenu.SubMenu:AddItem(dRepairItem)
	local mObserveItem = NativeUI.CreateItem(_U('animation_work_observe'), "")
	animWorkMenu.SubMenu:AddItem(mObserveItem)
	local tTalkItem = NativeUI.CreateItem(_U('animation_work_talk'), "")
	animWorkMenu.SubMenu:AddItem(tTalkItem)
	local tBillItem = NativeUI.CreateItem(_U('animation_work_bill'), "")
	animWorkMenu.SubMenu:AddItem(tBillItem)
	local eBuyItem = NativeUI.CreateItem(_U('animation_work_buy'), "")
	animWorkMenu.SubMenu:AddItem(eBuyItem)
	local bShotItem = NativeUI.CreateItem(_U('animation_work_shot'), "")
	animWorkMenu.SubMenu:AddItem(bShotItem)
	local jPictureItem = NativeUI.CreateItem(_U('animation_work_picture'), "")
	animWorkMenu.SubMenu:AddItem(jPictureItem)
	local NotesItem = NativeUI.CreateItem(_U('animation_work_notes'), "")
	animWorkMenu.SubMenu:AddItem(NotesItem)
	local HammerItem = NativeUI.CreateItem(_U('animation_work_hammer'), "")
	animWorkMenu.SubMenu:AddItem(HammerItem)
	local sdfBegItem = NativeUI.CreateItem(_U('animation_work_beg'), "")
	animWorkMenu.SubMenu:AddItem(sdfBegItem)
	local sdfStatueItem = NativeUI.CreateItem(_U('animation_work_statue'), "")
	animWorkMenu.SubMenu:AddItem(sdfStatueItem)

	animWorkMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == suspectItem then
			startAnim("random@arrests@busted", "idle_c")
		elseif item == fishermanItem then
			startScenario("world_human_stand_fishing")
		elseif item == pInspectItem then
			startAnim("amb@code_human_police_investigate@idle_b", "idle_f")
		elseif item == pRadioItem then
			startAnim("random@arrests", "generic_radio_chatter")
		elseif item == pCirculationItem then
			startScenario("WORLD_HUMAN_CAR_PARK_ATTENDANT")
		elseif item == pBinocularsItem then
			startScenario("WORLD_HUMAN_BINOCULARS")
		elseif item == aHarvestItem then
			startScenario("world_human_gardener_plant")
		elseif item == dRepairItem then
			startAnim("mini@repair", "fixing_a_ped")
		elseif item == mObserveItem then
			startScenario("CODE_HUMAN_MEDIC_KNEEL")
		elseif item == tTalkItem then
			startAnim("oddjobs@taxi@driver", "leanover_idle")
		elseif item == tBillItem then
			startAnim("oddjobs@taxi@cyi", "std_hand_off_ps_passenger")
		elseif item == eBuyItem then
			startAnim("mp_am_hold_up", "purchase_beerbox_shopkeeper")
		elseif item == bShotItem then
			startAnim("mini@drinking", "shots_barman_b")
		elseif item == jPictureItem then
			startScenario("WORLD_HUMAN_PAPARAZZI")
		elseif item == NotesItem then
			startScenario("WORLD_HUMAN_CLIPBOARD")
		elseif item == HammerItem then
			startScenario("WORLD_HUMAN_HAMMERING")
		elseif item == sdfBegItem then
			startScenario("WORLD_HUMAN_BUM_FREEWAY")
		elseif item == sdfStatueItem then
			startScenario("WORLD_HUMAN_HUMAN_STATUE")
		end
	end
end

function AddSubMenuMoodMenu(menu)
	animMoodMenu = _menuPool:AddSubMenu(menu.SubMenu, _U('animation_mood_title'))

	local felicitateItem = NativeUI.CreateItem(_U('animation_mood_felicitate'), "")
	animMoodMenu.SubMenu:AddItem(felicitateItem)
	local niceItem = NativeUI.CreateItem(_U('animation_mood_nice'), "")
	animMoodMenu.SubMenu:AddItem(niceItem)
	local youItem = NativeUI.CreateItem(_U('animation_mood_you'), "")
	animMoodMenu.SubMenu:AddItem(youItem)
	local comeItem = NativeUI.CreateItem(_U('animation_mood_come'), "")
	animMoodMenu.SubMenu:AddItem(comeItem)
	local whatItem = NativeUI.CreateItem(_U('animation_mood_what'), "")
	animMoodMenu.SubMenu:AddItem(whatItem)
	local meItem = NativeUI.CreateItem(_U('animation_mood_me'), "")
	animMoodMenu.SubMenu:AddItem(meItem)
	local seriouslyItem = NativeUI.CreateItem(_U('animation_mood_seriously'), "")
	animMoodMenu.SubMenu:AddItem(seriouslyItem)
	local tiredItem = NativeUI.CreateItem(_U('animation_mood_tired'), "")
	animMoodMenu.SubMenu:AddItem(tiredItem)
	local shitItem = NativeUI.CreateItem(_U('animation_mood_shit'), "")
	animMoodMenu.SubMenu:AddItem(shitItem)
	local facepalmItem = NativeUI.CreateItem(_U('animation_mood_facepalm'), "")
	animMoodMenu.SubMenu:AddItem(facepalmItem)
	local calmItem = NativeUI.CreateItem(_U('animation_mood_calm'), "")
	animMoodMenu.SubMenu:AddItem(calmItem)
	local whyItem = NativeUI.CreateItem(_U('animation_mood_why'), "")
	animMoodMenu.SubMenu:AddItem(whyItem)
	local fearItem = NativeUI.CreateItem(_U('animation_mood_fear'), "")
	animMoodMenu.SubMenu:AddItem(fearItem)
	local fightItem = NativeUI.CreateItem(_U('animation_mood_fight'), "")
	animMoodMenu.SubMenu:AddItem(fightItem)
	local notpossibleItem = NativeUI.CreateItem(_U('animation_mood_notpossible'), "")
	animMoodMenu.SubMenu:AddItem(notpossibleItem)
	local embraceItem = NativeUI.CreateItem(_U('animation_mood_embrace'), "")
	animMoodMenu.SubMenu:AddItem(embraceItem)
	local fuckyouItem = NativeUI.CreateItem(_U('animation_mood_fuckyou'), "")
	animMoodMenu.SubMenu:AddItem(fuckyouItem)
	local wankerItem = NativeUI.CreateItem(_U('animation_mood_wanker'), "")
	animMoodMenu.SubMenu:AddItem(wankerItem)
	local suicideItem = NativeUI.CreateItem(_U('animation_mood_suicide'), "")
	animMoodMenu.SubMenu:AddItem(suicideItem)

	animMoodMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == felicitateItem then
			startScenario("WORLD_HUMAN_CHEERING")
		elseif item == niceItem then
			startAnim("mp_action", "thanks_male_06")
		elseif item == youItem then
			startAnim("gestures@m@standing@casual", "gesture_point")
		elseif item == comeItem then
			startAnim("gestures@m@standing@casual", "gesture_come_here_soft")
		elseif item == whatItem then
			startAnim("gestures@m@standing@casual", "gesture_bring_it_on")
		elseif item == meItem then
			startAnim("gestures@m@standing@casual", "gesture_me")
		elseif item == seriouslyItem then
			startAnim("anim@am_hold_up@male", "shoplift_high")
		elseif item == tiredItem then
			startAnim("amb@world_human_jog_standing@male@idle_b", "idle_d")
		elseif item == shitItem then
			startAnim("amb@world_human_bum_standing@depressed@idle_a", "idle_a")
		elseif item == facepalmItem then
			startAnim("anim@mp_player_intcelebrationmale@face_palm", "face_palm")
		elseif item == calmItem then
			startAnim("gestures@m@standing@casual", "gesture_easy_now")
		elseif item == whyItem then
			startAnim("oddjobs@assassinate@multi@", "react_big_variations_a")
		elseif item == fearItem then
			startAnim("amb@code_human_cower_stand@male@react_cowering", "base_right")
		elseif item == fightItem then
			startAnim("anim@deathmatch_intros@unarmed", "intro_male_unarmed_e")
		elseif item == notpossibleItem then
			startAnim("gestures@m@standing@casual", "gesture_damn")
		elseif item == embraceItem then
			startAnim("mp_ped_interaction", "kisses_guy_a")
		elseif item == fuckyouItem then
			startAnim("mp_player_int_upperfinger", "mp_player_int_finger_01_enter")
		elseif item == wankerItem then
			startAnim("mp_player_int_upperwank", "mp_player_int_wank_01")
		elseif item == suicideItem then
			startAnim("mp_suicide", "pistol")
		end
	end
end

function AddSubMenuSportsMenu(menu)
	animSportMenu = _menuPool:AddSubMenu(menu.SubMenu, _U('animation_sports_title'))

	local muscleItem = NativeUI.CreateItem(_U('animation_sports_muscle'), "")
	animSportMenu.SubMenu:AddItem(muscleItem)
	local weightbarItem = NativeUI.CreateItem(_U('animation_sports_weightbar'), "")
	animSportMenu.SubMenu:AddItem(weightbarItem)
	local pushupItem = NativeUI.CreateItem(_U('animation_sports_pushup'), "")
	animSportMenu.SubMenu:AddItem(pushupItem)
	local absItem = NativeUI.CreateItem(_U('animation_sports_abs'), "")
	animSportMenu.SubMenu:AddItem(absItem)
	local yogaItem = NativeUI.CreateItem(_U('animation_sports_yoga'), "")
	animSportMenu.SubMenu:AddItem(yogaItem)

	animSportMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == muscleItem then
			startAnim("amb@world_human_muscle_flex@arms_at_side@base", "base")
		elseif item == weightbarItem then
			startAnim("amb@world_human_muscle_free_weights@male@barbell@base", "base")
		elseif item == pushupItem then
			startAnim("amb@world_human_push_ups@male@base", "base")
		elseif item == absItem then
			startAnim("amb@world_human_sit_ups@male@base", "base")
		elseif item == yogaItem then
			startAnim("amb@world_human_yoga@male@base", "base_a")
		end
	end
end

function AddSubMenuOtherMenu(menu)
	animOtherMenu = _menuPool:AddSubMenu(menu.SubMenu, _U('animation_other_title'))

	local beerItem = NativeUI.CreateItem(_U('animation_other_beer'), "")
	animOtherMenu.SubMenu:AddItem(beerItem)
	local sitItem = NativeUI.CreateItem(_U('animation_other_sit'), "")
	animOtherMenu.SubMenu:AddItem(sitItem)
	local waitwallItem = NativeUI.CreateItem(_U('animation_other_waitwall'), "")
	animOtherMenu.SubMenu:AddItem(waitwallItem)
	local onthebackItem = NativeUI.CreateItem(_U('animation_other_ontheback'), "")
	animOtherMenu.SubMenu:AddItem(onthebackItem)
	local stomachItem = NativeUI.CreateItem(_U('animation_other_stomach'), "")
	animOtherMenu.SubMenu:AddItem(stomachItem)
	local cleanItem = NativeUI.CreateItem(_U('animation_other_clean'), "")
	animOtherMenu.SubMenu:AddItem(cleanItem)
	local cookingItem = NativeUI.CreateItem(_U('animation_other_cooking'), "")
	animOtherMenu.SubMenu:AddItem(cookingItem)
	local searchItem = NativeUI.CreateItem(_U('animation_other_search'), "")
	animOtherMenu.SubMenu:AddItem(searchItem)
	local selfieItem = NativeUI.CreateItem(_U('animation_other_selfie'), "")
	animOtherMenu.SubMenu:AddItem(selfieItem)
	local doorItem = NativeUI.CreateItem(_U('animation_other_door'), "")
	animOtherMenu.SubMenu:AddItem(doorItem)

	animOtherMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == beerItem then
			startScenario("WORLD_HUMAN_DRINKING")
		elseif item == sitItem then
			startAnim("anim@heists@prison_heistunfinished_biztarget_idle", "target_idle")
		elseif item == waitwallItem then
			startScenario("world_human_leaning")
		elseif item == onthebackItem then
			startScenario("WORLD_HUMAN_SUNBATHE_BACK")
		elseif item == stomachItem then
			startScenario("WORLD_HUMAN_SUNBATHE")
		elseif item == cleanItem then
			startScenario("world_human_maid_clean")
		elseif item == cookingItem then
			startScenario("PROP_HUMAN_BBQ")
		elseif item == searchItem then
			startAnim("mini@prostitutes@sexlow_veh", "low_car_bj_to_prop_female")
		elseif item == selfieItem then
			startScenario("world_human_tourist_mobile")
		elseif item == doorItem then
			startAnim("mini@safe_cracking", "idle_base")
		end
	end
end

function AddSubMenuPEGI21Menu(menu)
	animPegiMenu = _menuPool:AddSubMenu(menu.SubMenu, _U('animation_pegi_title'))

	local hSuckItem = NativeUI.CreateItem(_U('animation_pegi_hsuck'), "")
	animPegiMenu.SubMenu:AddItem(hSuckItem)
	local fSuckItem = NativeUI.CreateItem(_U('animation_pegi_fsuck'), "")
	animPegiMenu.SubMenu:AddItem(fSuckItem)
	local hFuckItem = NativeUI.CreateItem(_U('animation_pegi_hfuck'), "")
	animPegiMenu.SubMenu:AddItem(hFuckItem)
	local fFuckItem = NativeUI.CreateItem(_U('animation_pegi_ffuck'), "")
	animPegiMenu.SubMenu:AddItem(fFuckItem)
	local scratchItem = NativeUI.CreateItem(_U('animation_pegi_scratch'), "")
	animPegiMenu.SubMenu:AddItem(scratchItem)
	local charmItem = NativeUI.CreateItem(_U('animation_pegi_charm'), "")
	animPegiMenu.SubMenu:AddItem(charmItem)
	local golddiggerItem = NativeUI.CreateItem(_U('animation_pegi_golddigger'), "")
	animPegiMenu.SubMenu:AddItem(golddiggerItem)
	local breastItem = NativeUI.CreateItem(_U('animation_pegi_breast'), "")
	animPegiMenu.SubMenu:AddItem(breastItem)
	local strip1Item = NativeUI.CreateItem(_U('animation_pegi_strip1'), "")
	animPegiMenu.SubMenu:AddItem(strip1Item)
	local strip2Item = NativeUI.CreateItem(_U('animation_pegi_strip2'), "")
	animPegiMenu.SubMenu:AddItem(strip2Item)
	local stripfloorItem = NativeUI.CreateItem(_U('animation_pegi_stripfloor'), "")
	animPegiMenu.SubMenu:AddItem(stripfloorItem)

	animPegiMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == hSuckItem then
			startAnim("oddjobs@towing", "m_blow_job_loop")
		elseif item == fSuckItem then
			startAnim("oddjobs@towing", "f_blow_job_loop")
		elseif item == hFuckItem then
			startAnim("mini@prostitutes@sexlow_veh", "low_car_sex_loop_player")
		elseif item == fFuckItem then
			startAnim("mini@prostitutes@sexlow_veh", "low_car_sex_loop_female")
		elseif item == scratchItem then
			startAnim("mp_player_int_uppergrab_crotch", "mp_player_int_grab_crotch")
		elseif item == charmItem then
			startAnim("mini@strip_club@idles@stripper", "stripper_idle_02")
		elseif item == golddiggerItem then
			startScenario("WORLD_HUMAN_PROSTITUTE_HIGH_CLASS")
		elseif item == breastItem then
			startAnim("mini@strip_club@backroom@", "stripper_b_backroom_idle_b")
		elseif item == strip1Item then
			startAnim("mini@strip_club@lap_dance@ld_girl_a_song_a_p1", "ld_girl_a_song_a_p1_f")
		elseif item == strip2Item then
			startAnim("mini@strip_club@private_dance@part2", "priv_dance_p2")
		elseif item == stripfloorItem then
			startAnim("mini@strip_club@private_dance@part3", "priv_dance_p3")
		end
	end
end

function AddMenuVehicleMenu(menu)
	personalmenu.frontLeftDoorOpen = false
	personalmenu.frontRightDoorOpen = false
	personalmenu.backLeftDoorOpen = false
	personalmenu.backRightDoorOpen = false
	personalmenu.hoodDoorOpen = false
	personalmenu.trunkDoorOpen = false
	personalmenu.doorList = {
		_U('vehicle_door_frontleft'),
		_U('vehicle_door_frontright'),
		_U('vehicle_door_backleft'),
		_U('vehicle_door_backright')
	}

	vehicleMenu = _menuPool:AddSubMenu(menu, _U('vehicle_title'))

	local vehEngineItem = NativeUI.CreateItem(_U('vehicle_engine_button'), "")
	vehicleMenu.SubMenu:AddItem(vehEngineItem)
	local vehDoorListItem = NativeUI.CreateListItem(_U('vehicle_door_button'), personalmenu.doorList, 1)
	vehicleMenu.SubMenu:AddItem(vehDoorListItem)
	local vehHoodItem = NativeUI.CreateItem(_U('vehicle_hood_button'), "")
	vehicleMenu.SubMenu:AddItem(vehHoodItem)
	local vehTrunkItem = NativeUI.CreateItem(_U('vehicle_trunk_button'), "")
	vehicleMenu.SubMenu:AddItem(vehTrunkItem)

	vehicleMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if not IsPedSittingInAnyVehicle(plyPed) then
			ESX.ShowNotification(_U('no_vehicle'))
		elseif IsPedSittingInAnyVehicle(plyPed) then
			plyVehicle = GetVehiclePedIsIn(plyPed, false)
			if item == vehEngineItem then
				if GetIsVehicleEngineRunning(plyVehicle) then
					SetVehicleEngineOn(plyVehicle, false, false, true)
					SetVehicleUndriveable(plyVehicle, true)
				elseif not GetIsVehicleEngineRunning(plyVehicle) then
					SetVehicleEngineOn(plyVehicle, true, false, true)
					SetVehicleUndriveable(plyVehicle, false)
				end
			elseif item == vehHoodItem then
				if not personalmenu.hoodDoorOpen then
					personalmenu.hoodDoorOpen = true
					SetVehicleDoorOpen(plyVehicle, 4, false, false)
				elseif personalmenu.hoodDoorOpen then
					personalmenu.hoodDoorOpen = false
					SetVehicleDoorShut(plyVehicle, 4, false, false)
				end
			elseif item == vehTrunkItem then
				if not personalmenu.trunkDoorOpen then
					personalmenu.trunkDoorOpen = true
					SetVehicleDoorOpen(plyVehicle, 5, false, false)
				elseif personalmenu.trunkDoorOpen then
					personalmenu.trunkDoorOpen = false
					SetVehicleDoorShut(plyVehicle, 5, false, false)
				end
			end
		end
	end

	vehicleMenu.SubMenu.OnListSelect = function(sender, item, index)
		if not IsPedSittingInAnyVehicle(plyPed) then
			ESX.ShowNotification(_U('no_vehicle'))
		elseif IsPedSittingInAnyVehicle(plyPed) then
			plyVehicle = GetVehiclePedIsIn(plyPed, false)
			if item == vehDoorListItem then
				if index == 1 then
					if not personalmenu.frontLeftDoorOpen then
						personalmenu.frontLeftDoorOpen = true
						SetVehicleDoorOpen(plyVehicle, 0, false, false)
					elseif personalmenu.frontLeftDoorOpen then
						personalmenu.frontLeftDoorOpen = false
						SetVehicleDoorShut(plyVehicle, 0, false, false)
					end
				elseif index == 2 then
					if not personalmenu.frontRightDoorOpen then
						personalmenu.frontRightDoorOpen = true
						SetVehicleDoorOpen(plyVehicle, 1, false, false)
					elseif personalmenu.frontRightDoorOpen then
						personalmenu.frontRightDoorOpen = false
						SetVehicleDoorShut(plyVehicle, 1, false, false)
					end
				elseif index == 3 then
					if not personalmenu.backLeftDoorOpen then
						personalmenu.backLeftDoorOpen = true
						SetVehicleDoorOpen(plyVehicle, 2, false, false)
					elseif personalmenu.backLeftDoorOpen then
						personalmenu.backLeftDoorOpen = false
						SetVehicleDoorShut(plyVehicle, 2, false, false)
					end
				elseif index == 4 then
					if not personalmenu.backRightDoorOpen then
						personalmenu.backRightDoorOpen = true
						SetVehicleDoorOpen(plyVehicle, 3, false, false)
					elseif personalmenu.backRightDoorOpen then
						personalmenu.backRightDoorOpen = false
						SetVehicleDoorShut(plyVehicle, 3, false, false)
					end
				end
			end
		end
	end
end

function AddMenuBossMenu(menu)
	bossMenu = _menuPool:AddSubMenu(menu, _U('bossmanagement_title', ESX.PlayerData.job.label))

	local coffreItem = nil

	if societymoney ~= nil then
		coffreItem = NativeUI.CreateItem(_U('bossmanagement_chest_button'), "")
		coffreItem:RightLabel("$" .. societymoney)
		bossMenu.SubMenu:AddItem(coffreItem)
	end

	local recruterItem = NativeUI.CreateItem(_U('bossmanagement_hire_button'), "")
	bossMenu.SubMenu:AddItem(recruterItem)
	local virerItem = NativeUI.CreateItem(_U('bossmanagement_fire_button'), "")
	bossMenu.SubMenu:AddItem(virerItem)
	local promouvoirItem = NativeUI.CreateItem(_U('bossmanagement_promote_button'), "")
	bossMenu.SubMenu:AddItem(promouvoirItem)
	local destituerItem = NativeUI.CreateItem(_U('bossmanagement_demote_button'), "")
	bossMenu.SubMenu:AddItem(destituerItem)

	bossMenu.SubMenu.OnItemSelect = function(sender, item, index)
		if item == recruterItem then
			if ESX.PlayerData.job.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					notification("Entreprise", "Notification", _U('players_nearby'))
				else
					TriggerServerEvent('KorioZ-PersonalMenu:Boss_recruterplayer', GetPlayerServerId(personalmenu.closestPlayer), ESX.PlayerData.job.name, 0)
				end
			else
				notification("Entreprise", "Notification", _U('missing_rights'))
			end
		elseif item == virerItem then
			if ESX.PlayerData.job.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					notification("Entreprise", "Notification", _U('players_nearby'))
				else
					TriggerServerEvent('KorioZ-PersonalMenu:Boss_virerplayer', GetPlayerServerId(personalmenu.closestPlayer))
				end
			else
				notification("Entreprise", "Notification", _U('missing_rights'))
			end
		elseif item == promouvoirItem then
			if ESX.PlayerData.job.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					notification("Entreprise", "Notification", _U('players_nearby'))
				else
					TriggerServerEvent('KorioZ-PersonalMenu:Boss_promouvoirplayer', GetPlayerServerId(personalmenu.closestPlayer))
				end
			else
				notification("Entreprise", "Notification", _U('missing_rights'))
			end
		elseif item == destituerItem then
			if ESX.PlayerData.job.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					notification("Entreprise", "Notification", _U('players_nearby'))
				else
					TriggerServerEvent('KorioZ-PersonalMenu:Boss_destituerplayer', GetPlayerServerId(personalmenu.closestPlayer))
				end
			else
				notification("Entreprise", "Notification", _U('missing_rights'))
			end
		end
	end
end

function AddMenuBossMenu2(menu)
	bossMenu2 = _menuPool:AddSubMenu(menu, _U('bossmanagement2_title', ESX.PlayerData.job2.label))

	local coffre2Item = nil

	if societymoney2 ~= nil then
		coffre2Item = NativeUI.CreateItem(_U('bossmanagement2_chest_button'), "")
		coffre2Item:RightLabel("$" .. societymoney2)
		bossMenu2.SubMenu:AddItem(coffre2Item)
	end

	local recruter2Item = NativeUI.CreateItem(_U('bossmanagement2_hire_button'), "")
	bossMenu2.SubMenu:AddItem(recruter2Item)
	local virer2Item = NativeUI.CreateItem(_U('bossmanagement2_fire_button'), "")
	bossMenu2.SubMenu:AddItem(virer2Item)
	local promouvoir2Item = NativeUI.CreateItem(_U('bossmanagement2_promote_button'), "")
	bossMenu2.SubMenu:AddItem(promouvoir2Item)
	local destituer2Item = NativeUI.CreateItem(_U('bossmanagement2_demote_button'), "")
	bossMenu2.SubMenu:AddItem(destituer2Item)

	bossMenu2.SubMenu.OnItemSelect = function(sender, item, index)
		if item == recruter2Item then
			if ESX.PlayerData.job2.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					notification("Entreprise", "Notification", _U('players_nearby'))
				else
					TriggerServerEvent('KorioZ-PersonalMenu:Boss_recruterplayer2', GetPlayerServerId(personalmenu.closestPlayer), ESX.PlayerData.job2.name, 0)
				end
			else
				notification("Entreprise", "Notification", _U('missing_rights'))
			end
		elseif item == virer2Item then
			if ESX.PlayerData.job2.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					notification("Entreprise", "Notification", _U('players_nearby'))
				else
					TriggerServerEvent('KorioZ-PersonalMenu:Boss_virerplayer2', GetPlayerServerId(personalmenu.closestPlayer))
				end
			else
				notification("Entreprise", "Notification", _U('missing_rights'))
			end
		elseif item == promouvoir2Item then
			if ESX.PlayerData.job2.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					notification("Entreprise", "Notification", _U('players_nearby'))
				else
					TriggerServerEvent('KorioZ-PersonalMenu:Boss_promouvoirplayer2', GetPlayerServerId(personalmenu.closestPlayer))
				end
			else
				notification("Entreprise", "Notification", _U('missing_rights'))
			end
		elseif item == destituer2Item then
			if ESX.PlayerData.job2.grade_name == 'boss' then
				personalmenu.closestPlayer, personalmenu.closestDistance = ESX.Game.GetClosestPlayer()

				if personalmenu.closestPlayer == -1 or personalmenu.closestDistance > 3.0 then
					notification("Entreprise", "Notification", _U('players_nearby'))
				else
					TriggerServerEvent('KorioZ-PersonalMenu:Boss_destituerplayer2', GetPlayerServerId(personalmenu.closestPlayer))
				end
			else
				notification("Entreprise", "Notification", _U('missing_rights'))
			end
		end
	end
end

function AddMenuDemarcheVoixGPS(menu)
    personalmenu.gps = {
		"Aucun",
		"Poste de Police",
		"Garage Central",
        "Hôpital",
		"Concessionnaire",
        "Benny's Custom",
		"Pôle Emploie",
        "Auto école",
		"Téquila-la"
	}

	personalmenu.demarche = {
		"Normal",
		"Homme effiminer",
		"Bouffiasse",
		"Dépressif",
		"Dépressive",
		"Muscle",
		"Hipster",
		"Business",
		"Intimide",
		"Bourrer",
		"Malheureux",
		"Triste",
		"Choc",
		"Sombre",
		"Fatiguer",
		"Presser",
		"Frimeur",
		"Fier",
		"Petite course",
		"Pupute",
		"Impertinente",
		"Arrogante",
		"Blesser",
		"Trop manger",
		"Casual",
		"Determiner",
		"Peureux",
		"Trop Swag",
		"Travailleur",
		"Brute",
		"Rando",
		"Gangstère",
		"Gangster"
	}

	personalmenu.nivVoix = {
		_U('voice_whisper'),
		_U('voice_normal'),
		_U('voice_cry')
	}

	local gpsItem = NativeUI.CreateListItem(_U('mainmenu_gps_button'), personalmenu.gps, actualGPSIndex)
	menu:AddItem(gpsItem)
	local demarcheItem = NativeUI.CreateListItem(_U('mainmenu_approach_button'), personalmenu.demarche, actualDemarcheIndex)
	menu:AddItem(demarcheItem)
	local voixItem = NativeUI.CreateListItem(_U('mainmenu_voice_button'), personalmenu.nivVoix, actualVoiceIndex)
	menu:AddItem(voixItem)

	menu.OnListSelect = function(sender, item, index)
		if item == gpsItem then
			actualGPS = item:IndexToItem(index)
			actualGPSIndex = index

			ESX.ShowNotification(_U('gps', actualGPS))

			if actualGPS == "Aucun" then
				local plyCoords = GetEntityCoords(plyPed)
				SetNewWaypoint(plyCoords.x, plyCoords.y)
			elseif actualGPS == "Poste de Police" then
				SetNewWaypoint(425.13, -979.55)
			elseif actualGPS == "Hôpital" then
				SetNewWaypoint(-449.67, -340.83)
			elseif actualGPS == "Concessionnaire" then
				SetNewWaypoint(-33.88, -1102.37)
			elseif actualGPS == "Garage Central" then
				SetNewWaypoint(215.06, -791.56)
			elseif actualGPS == "Benny's Custom" then
				SetNewWaypoint(-212.13, -1325.27)
			elseif actualGPS == "Pôle Emploie" then
				SetNewWaypoint(-264.83, -964.54)
			elseif actualGPS == "Auto école" then
				SetNewWaypoint(-829.22, -696.99)
			elseif actualGPS == "Téquila-la" then
				SetNewWaypoint(-565.09, 273.45)
			elseif actualGPS == "Bahama Mamas" then
				SetNewWaypoint(-1391.06, -590.34)
			end
		elseif item == demarcheItem then
			TriggerEvent('skinchanger:getSkin', function(skin)
				actualDemarche = item:IndexToItem(index)
				actualDemarcheIndex = index

				ESX.ShowNotification(_U('approach', actualDemarche))

				if actualDemarche == "Normal" then
					if skin.sex == 0 then
						startAttitude("move_m@multiplayer", "move_m@multiplayer")
					elseif skin.sex == 1 then
						startAttitude("move_f@multiplayer", "move_f@multiplayer")
					end
				elseif actualDemarche == "Homme effiminer" then
					startAttitude("move_m@confident", "move_m@confident")
				elseif actualDemarche == "Bouffiasse" then
					startAttitude("move_f@heels@c","move_f@heels@c")
				elseif actualDemarche == "Dépressif" then
					startAttitude("move_m@depressed@a","move_m@depressed@a")
				elseif actualDemarche == "Dépressive" then
					startAttitude("move_f@depressed@a","move_f@depressed@a")
				elseif actualDemarche == "Muscle" then
					startAttitude("move_m@muscle@a","move_m@muscle@a")
				elseif actualDemarche == "Hipster" then
					startAttitude("move_m@hipster@a","move_m@hipster@a")
				elseif actualDemarche == "Business" then
					startAttitude("move_m@business@a","move_m@business@a")
				elseif actualDemarche == "Intimide" then
					startAttitude("move_m@hurry@a","move_m@hurry@a")
				elseif actualDemarche == "Bourrer" then
					startAttitude("move_m@hobo@a","move_m@hobo@a")
				elseif actualDemarche == "Malheureux" then
					startAttitude("move_m@sad@a","move_m@sad@a")
				elseif actualDemarche == "Triste" then
					startAttitude("move_m@leaf_blower","move_m@leaf_blower")
				elseif actualDemarche == "Choc" then
					startAttitude("move_m@shocked@a","move_m@shocked@a")
				elseif actualDemarche == "Sombre" then
					startAttitude("move_m@shadyped@a","move_m@shadyped@a")
				elseif actualDemarche == "Fatiguer" then
					startAttitude("move_m@buzzed","move_m@buzzed")
				elseif actualDemarche == "Presser" then
					startAttitude("move_m@hurry_butch@a","move_m@hurry_butch@a")
				elseif actualDemarche == "Frimeur" then
					startAttitude("move_m@money","move_m@money")
				elseif actualDemarche == "Fier" then
					startAttitude("move_m@posh@","move_m@posh@")
				elseif actualDemarche == "Petite course" then
					startAttitude("move_m@quick","move_m@quick")
				elseif actualDemarche == "Pupute" then
					startAttitude("move_f@maneater","move_f@maneater")
				elseif actualDemarche == "Impertinente" then
					startAttitude("move_f@sassy","move_f@sassy")
				elseif actualDemarche == "Arrogante" then
					startAttitude("move_f@arrogant@a","move_f@arrogant@a")
				elseif actualDemarche == "Blesser" then
					startAttitude("move_m@injured","move_m@injured")
				elseif actualDemarche == "Trop manger" then
					startAttitude("move_m@fat@a","move_m@fat@a")
				elseif actualDemarche == "Casual" then
					startAttitude("move_m@casual@a","move_m@casual@a")
				elseif actualDemarche == "Determiner" then
					startAttitude("move_m@brave@a","move_m@brave@a")
				elseif actualDemarche == "Peureux" then
					startAttitude("move_m@scared","move_m@scared")
				elseif actualDemarche == "Trop Swag" then
					startAttitude("move_m@swagger@b","move_m@swagger@b")
				elseif actualDemarche == "Travailleur" then
					startAttitude("move_m@tool_belt@a","move_m@tool_belt@a")
				elseif actualDemarche == "Brute" then
					startAttitude("move_m@tough_guy@","move_m@tough_guy@")
				elseif actualDemarche == "Rando" then
					startAttitude("move_m@hiking","move_m@hiking")
				elseif actualDemarche == "Gangstère" then
					startAttitude("move_m@gangster@ng","move_m@gangster@ng")
				elseif actualDemarche == "Gangster" then
					startAttitude("move_m@gangster@generic","move_m@gangster@generic")
				end
			end)
		elseif item == voixItem then
			actualVoice = item:IndexToItem(index)
			actualVoiceIndex = index

			ESX.ShowNotification(_U('voice', actualVoice))

			if index == 1 then
				NetworkSetTalkerProximity(1.0)
			elseif index == 2 then
				NetworkSetTalkerProximity(8.0)
			elseif index == 3 then
				NetworkSetTalkerProximity(14.0)
			end
		end
	end
end

function AddMenuAdminMenu(menu)
	adminMenu = _menuPool:AddSubMenu(menu, _U('admin_title'))

	if playerGroup == 'mod' then
		local tptoPlrItem = NativeUI.CreateItem(_U('admin_goto_button'), "")
		adminMenu.SubMenu:AddItem(tptoPlrItem)
		local tptoMeItem = NativeUI.CreateItem(_U('admin_bring_button'), "")
		adminMenu.SubMenu:AddItem(tptoMeItem)
		local noclipItem = NativeUI.CreateItem(_U('admin_noclip_button'), "")
		adminMenu.SubMenu:AddItem(noclipItem)
		local showXYZItem = NativeUI.CreateItem(_U('admin_showxyz_button'), "")
		adminMenu.SubMenu:AddItem(showXYZItem)
		local showPlrNameItem = NativeUI.CreateItem(_U('admin_showname_button'), "")
		adminMenu.SubMenu:AddItem(showPlrNameItem)

		adminMenu.SubMenu.OnItemSelect = function(sender, item, index)
			if item == tptoPlrItem then
				admin_tp_toplayer()
				_menuPool:CloseAllMenus()
			elseif item == tptoMeItem then
				admin_tp_playertome()
				_menuPool:CloseAllMenus()
			elseif item == noclipItem then
				admin_no_clip()
				_menuPool:CloseAllMenus()
			elseif item == showXYZItem then
				modo_showcoord()
			elseif item == showPlrNameItem then
				modo_showname()
			end
		end
	elseif playerGroup == 'admin' then
		local tptoPlrItem = NativeUI.CreateItem(_U('admin_goto_button'), "")
		adminMenu.SubMenu:AddItem(tptoPlrItem)
		local tptoMeItem = NativeUI.CreateItem(_U('admin_bring_button'), "")
		adminMenu.SubMenu:AddItem(tptoMeItem)
		local noclipItem = NativeUI.CreateItem(_U('admin_noclip_button'), "")
		adminMenu.SubMenu:AddItem(noclipItem)
		local repairVehItem = NativeUI.CreateItem(_U('admin_repairveh_button'), "")
		adminMenu.SubMenu:AddItem(repairVehItem)
		local returnVehItem = NativeUI.CreateItem(_U('admin_flipveh_button'), "")
		adminMenu.SubMenu:AddItem(returnVehItem)
		local showXYZItem = NativeUI.CreateItem(_U('admin_showxyz_button'), "")
		adminMenu.SubMenu:AddItem(showXYZItem)
		local showPlrNameItem = NativeUI.CreateItem(_U('admin_showname_button'), "")
		adminMenu.SubMenu:AddItem(showPlrNameItem)
		local tptoWaypointItem = NativeUI.CreateItem(_U('admin_tpmarker_button'), "")
		adminMenu.SubMenu:AddItem(tptoWaypointItem)
		local revivePlrItem = NativeUI.CreateItem(_U('admin_revive_button'), "")
		adminMenu.SubMenu:AddItem(revivePlrItem)

		adminMenu.SubMenu.OnItemSelect = function(sender, item, index)
			if item == tptoPlrItem then
				admin_tp_toplayer()
				_menuPool:CloseAllMenus()
			elseif item == tptoMeItem then
				admin_tp_playertome()
				_menuPool:CloseAllMenus()
			elseif item == noclipItem then
				admin_no_clip()
				_menuPool:CloseAllMenus()
			elseif item == repairVehItem then
				admin_vehicle_repair()
			elseif item == returnVehItem then
				admin_vehicle_flip()
			elseif item == showXYZItem then
				modo_showcoord()
			elseif item == showPlrNameItem then
				modo_showname()
			elseif item == tptoWaypointItem then
				admin_tp_marker()
			elseif item == revivePlrItem then
				admin_heal_player()
				_menuPool:CloseAllMenus()
			end
		end
	elseif playerGroup == 'superadmin' or playerGroup == 'owner' then
		local tptoPlrItem = NativeUI.CreateItem(_U('admin_goto_button'), "")
		adminMenu.SubMenu:AddItem(tptoPlrItem)
		local tptoMeItem = NativeUI.CreateItem(_U('admin_bring_button'), "")
		adminMenu.SubMenu:AddItem(tptoMeItem)
		local tptoXYZItem = NativeUI.CreateItem(_U('admin_tpxyz_button'), "")
		adminMenu.SubMenu:AddItem(tptoXYZItem)
		local noclipItem = NativeUI.CreateItem(_U('admin_noclip_button'), "")
		adminMenu.SubMenu:AddItem(noclipItem)
		local godmodeItem = NativeUI.CreateItem(_U('admin_godmode_button'), "")
		adminMenu.SubMenu:AddItem(godmodeItem)
		local ghostmodeItem = NativeUI.CreateItem(_U('admin_ghostmode_button'), "")
		adminMenu.SubMenu:AddItem(ghostmodeItem)
		local spawnVehItem = NativeUI.CreateItem(_U('admin_spawnveh_button'), "")
		adminMenu.SubMenu:AddItem(spawnVehItem)
		local repairVehItem = NativeUI.CreateItem(_U('admin_repairveh_button'), "")
		adminMenu.SubMenu:AddItem(repairVehItem)
		local returnVehItem = NativeUI.CreateItem(_U('admin_flipveh_button'), "")
		adminMenu.SubMenu:AddItem(returnVehItem)
		local givecashItem = NativeUI.CreateItem(_U('admin_givemoney_button'), "")
		adminMenu.SubMenu:AddItem(givecashItem)
		local givebankItem = NativeUI.CreateItem(_U('admin_givebank_button'), "")
		adminMenu.SubMenu:AddItem(givebankItem)
		local givedirtyItem = NativeUI.CreateItem(_U('admin_givedirtymoney_button'), "")
		adminMenu.SubMenu:AddItem(givedirtyItem)
		local showXYZItem = NativeUI.CreateItem(_U('admin_showxyz_button'), "")
		adminMenu.SubMenu:AddItem(showXYZItem)
		local showPlrNameItem = NativeUI.CreateItem(_U('admin_showname_button'), "")
		adminMenu.SubMenu:AddItem(showPlrNameItem)
		local tptoWaypointItem = NativeUI.CreateItem(_U('admin_tpmarker_button'), "")
		adminMenu.SubMenu:AddItem(tptoWaypointItem)
		local revivePlrItem = NativeUI.CreateItem(_U('admin_revive_button'), "")
		adminMenu.SubMenu:AddItem(revivePlrItem)
		local skinPlrItem = NativeUI.CreateItem(_U('admin_changeskin_button'), "")
		adminMenu.SubMenu:AddItem(skinPlrItem)
		local saveSkinPlrItem = NativeUI.CreateItem(_U('admin_saveskin_button'), "")
		adminMenu.SubMenu:AddItem(saveSkinPlrItem)

		adminMenu.SubMenu.OnItemSelect = function(sender, item, index)
			if item == tptoPlrItem then
				admin_tp_toplayer()
				_menuPool:CloseAllMenus()
			elseif item == tptoMeItem then
				admin_tp_playertome()
				_menuPool:CloseAllMenus()
			elseif item == tptoXYZItem then
				admin_tp_pos()
				_menuPool:CloseAllMenus()
			elseif item == noclipItem then
				admin_no_clip()
				_menuPool:CloseAllMenus()
			elseif item == godmodeItem then
				admin_godmode()
			elseif item == ghostmodeItem then
				admin_mode_fantome()
			elseif item == spawnVehItem then
				admin_vehicle_spawn()
				_menuPool:CloseAllMenus()
			elseif item == repairVehItem then
				admin_vehicle_repair()
			elseif item == returnVehItem then
				admin_vehicle_flip()
			elseif item == givecashItem then
				admin_give_money()
				_menuPool:CloseAllMenus()
			elseif item == givebankItem then
				admin_give_bank()
				_menuPool:CloseAllMenus()
			elseif item == givedirtyItem then
				admin_give_dirty()
				_menuPool:CloseAllMenus()
			elseif item == showXYZItem then
				modo_showcoord()
			elseif item == showPlrNameItem then
				modo_showname()
			elseif item == tptoWaypointItem then
				admin_tp_marker()
			elseif item == revivePlrItem then
				admin_heal_player()
				_menuPool:CloseAllMenus()
			elseif item == skinPlrItem then
				changer_skin()
			elseif item == saveSkinPlrItem then
				save_skin()
			end
		end
	end
end

function GeneratePersonalMenu()	
	AddMenuInventoryMenu(mainMenu)
	AddMenuSIMMenu(mainMenu)
	AddMenuWalletMenu(mainMenu)
	AddMenuFacturesMenu(mainMenu)
	AddMenuWeaponMenu(mainMenu)
	AddMenuClothesMenu(mainMenu)
	AddMenuAccessoryMenu(mainMenu)
	AddMenuAnimationMenu(mainMenu)
	AddMenuCleMenu(mainMenu)

	if IsPedSittingInAnyVehicle(plyPed) then
		if (GetPedInVehicleSeat(GetVehiclePedIsIn(plyPed, false), -1) == plyPed) then
			AddMenuVehicleMenu(mainMenu)
		end
	end

	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
		AddMenuBossMenu(mainMenu)
	end

	if Config.doublejob then
		if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
			AddMenuBossMenu2(mainMenu)
		end
	end

	AddMenuDemarcheVoixGPS(mainMenu)
	AddMenuDiversMenu(mainMenu)

	if playerGroup ~= nil and (playerGroup == 'mod' or playerGroup == 'admin' or playerGroup == 'superadmin' or playerGroup == 'owner') then
		AddMenuAdminMenu(mainMenu)
	end


	_menuPool:RefreshIndex()
end

Citizen.CreateThread(function()
	while true do
		if IsControlJustReleased(0, Config.Menu.clavier) and not isDead then
			if mainMenu ~= nil and not mainMenu:Visible() then
				ESX.PlayerData = ESX.GetPlayerData()
				GeneratePersonalMenu()
				mainMenu:Visible(true)
				Citizen.Wait(10)
			end
		end
		
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		if _menuPool ~= nil then
			_menuPool:ProcessMenus()
		end
		
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		while _menuPool ~= nil and _menuPool:IsAnyMenuOpen() do
			Citizen.Wait(0)

			if not _menuPool:IsAnyMenuOpen() then
				mainMenu:Clear()
				itemMenu:Clear()
				weaponItemMenu:Clear()

				_menuPool:Clear()
				_menuPool:Remove()

				personalmenu = {}

				invItem = {}
				wepItem = {}
				billItem = {}

				collectgarbage()

				_menuPool = NativeUI.CreatePool()

				mainMenu = NativeUI.CreateMenu(Config.servername, _U('mainmenu_subtitle'))
				itemMenu = NativeUI.CreateMenu(Config.servername, _U('inventory_actions_subtitle'))
				weaponItemMenu = NativeUI.CreateMenu(Config.servername, _U('loadout_actions_subtitle'))
				_menuPool:Add(mainMenu)
				_menuPool:Add(itemMenu)
				_menuPool:Add(weaponItemMenu)
			end
		end

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		if ESX ~= nil then
			ESX.TriggerServerCallback('KorioZ-PersonalMenu:Admin_getUsergroup', function(group) playerGroup = group end)

			Citizen.Wait(30 * 1000)
		else
			Citizen.Wait(100)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		plyPed = PlayerPedId()
		
		if IsControlJustReleased(0, Config.stopAnim.clavier) and GetLastInputMethod(2) and not isDead then
			ClearPedTasks(plyPed)
		end

		if playerGroup ~= nil and (playerGroup == 'mod' or playerGroup == 'admin' or playerGroup == 'superadmin' or playerGroup == 'owner') then
			if IsControlPressed(1, Config.TPMarker.clavier1) and IsControlJustReleased(1, Config.TPMarker.clavier2) and GetLastInputMethod(2) and not isDead then
				admin_tp_marker()
			end
		end

		if showcoord then
			local playerPos = GetEntityCoords(plyPed)
			local playerHeading = GetEntityHeading(plyPed)
			Text("~r~X~s~: " .. playerPos.x .. " ~b~Y~s~: " .. playerPos.y .. " ~g~Z~s~: " .. playerPos.z .. " ~y~Angle~s~: " .. playerHeading)
		end

		if noclip then
			local x, y, z = getPosition()
			local dx, dy, dz = getCamDirection()
			local speed = Config.noclip_speed

			SetEntityVelocity(plyPed, 0.0001, 0.0001, 0.0001)

			if IsControlPressed(0, 32) then
				x = x + speed * dx
				y = y + speed * dy
				z = z + speed * dz
			end

			if IsControlPressed(0, 269) then
				x = x - speed * dx
				y = y - speed * dy
				z = z - speed * dz
			end

			SetEntityCoordsNoOffset(plyPed, x, y, z, true, true, true)
		end

		if showname then
			for id = 0, 256 do
				if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= plyPed then
					local headId = Citizen.InvokeNative(0xBFEFE3321A3F5015, GetPlayerPed(id), (GetPlayerServerId(id) .. ' - ' .. GetPlayerName(id)), false, false, "", false)
				end
			end
		end
		
		Citizen.Wait(0)
	end
end)

function openCarteSIM()
	TriggerEvent('NB:closeAllSubMenu')
	TriggerEvent('NB:closeAllMenu')
	TriggerEvent('NB:closeMenuKey')
	
	TriggerEvent('NB:carteSIM')
end

---------------------------------
--------- ikNox#6088 ------------
---------------------------------