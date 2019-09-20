----------------------------
-- By K3rhos & DoluTattoo --
----------------------------


-- Coords for the first elevator prop (doesnt need heading)
local elevatorBaseX = -223.5853
local elevatorBaseY = -1327.158
local elevatorBaseZ = 29.8
----

-- Coords for the second elevator prop
local elevator2BaseX = -213.460
local elevator2BaseY = -1313.18
local elevator2BaseZ = 29.8
local elevator2BaseHeading = 270.0
-----


local elevatorProp = nil
local elevatorUp = false
local elevatorDown = false
local elevator2Prop = nil
local elevator2Up = false
local elevator2Down = false
local la_nacelle_estelle_la = false -- la nacelle n'est pas là par defaut

function deleteObject(object)
	return Citizen.InvokeNative(0x539E0AE3E6634B9F, Citizen.PointerValueIntInitialized(object))
end

function createObject(model, x, y, z)
	RequestModel(model)
	while (not HasModelLoaded(model)) do
		Citizen.Wait(0)
	end
	return CreateObject(model, x, y, z, true, true, false)
end

function spawnProp(propName, x, y, z)
	local model = GetHashKey(propName)
	
	if IsModelValid(model) then
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
	
		local forward = 5.0
		local heading = GetEntityHeading(GetPlayerPed(-1))
		local xVector = forward * math.sin(math.rad(heading)) * -1.0
		local yVector = forward * math.cos(math.rad(heading))
		
		elevatorProp = createObject(model, x, y, z)
		local propNetId = ObjToNet(elevatorProp)
		SetNetworkIdExistsOnAllMachines(propNetId, true)
		NetworkSetNetworkIdDynamic(propNetId, true)
		SetNetworkIdCanMigrate(propNetId, false)
		
		SetEntityLodDist(elevatorProp, 0xFFFF)
		SetEntityCollision(elevatorProp, true, true)
		FreezeEntityPosition(elevatorProp, true)
		SetEntityCoords(elevatorProp, x, y, z, false, false, false, false) -- Patch un bug pour certains props.

		la_nacelle_estelle_la = true -- la nacelle est là
	end
end

function spawnProp2(propName, x, y, z)
	local model = GetHashKey(propName)
	
	if IsModelValid(model) then
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
	
		local forward = 5.0
		local heading = GetEntityHeading(GetPlayerPed(-1))
		local xVector = forward * math.sin(math.rad(heading)) * -1.0
		local yVector = forward * math.cos(math.rad(heading))
		
		elevator2Prop = createObject(model, x, y, z)
		local propNetId = ObjToNet(elevator2Prop)
		SetNetworkIdExistsOnAllMachines(propNetId, true)
		NetworkSetNetworkIdDynamic(propNetId, true)
		SetNetworkIdCanMigrate(propNetId, false)
		
		SetEntityLodDist(elevator2Prop, 0xFFFF)
		SetEntityCollision(elevator2Prop, true, true)
		FreezeEntityPosition(elevator2Prop, true)
		SetEntityCoords(elevator2Prop, x, y, z, false, false, false, false) -- Patch un bug pour certains props.
		SetEntityHeading(elevator2Prop, elevator2BaseHeading)

		la_nacelle_estelle_la = true -- la nacelle est là
	end
end

-- Affichage menu du pont 

function Main()
    Menu.SetupMenu("mainmenu", "BENNY'S")
    Menu.Switch(nil, "mainmenu")

    local elevator_up = Language[Config.Locale]['elevator_up']
    local elevator_stop = Language[Config.Locale]['elevator_stop']
    local elevator_down = Language[Config.Locale]['elevator_down']
    local delete_elevator = Language[Config.Locale]['delete_elevator']

	Menu.addOption("mainmenu", function() if (Menu.Option(elevator_up)) then
		if elevatorProp ~= nil then
			elevatorDown = false
			elevatorUp = true
			elevatorStop = false
		end
	end end)

	Menu.addOption("mainmenu", function() if (Menu.Option(elevator_stop)) then
		if elevatorProp ~= nil then
			elevatorUp = false
			elevatorDown = false
		end
	end end)
	
    Menu.addOption("mainmenu", function() if (Menu.Option(elevator_down)) then
		if elevatorProp ~= nil then
			elevatorUp = false
			elevatorDown = true
			elevatorStop = false
		end
	end end)

    if Config.debug then
		Menu.addOption("mainmenu", function() if (Menu.Option(delete_elevator)) then
			deleteObject(elevatorProp)
			deleteObject(elevator2Prop)
		end end)
	end
end

function Main2()
    Menu.SetupMenu("mainmenu", "BENNY'S")
    Menu.Switch(nil, "mainmenu")

    local elevator_up = Language[Config.Locale]['elevator_up']
    local elevator_stop = Language[Config.Locale]['elevator_stop']
    local elevator_down = Language[Config.Locale]['elevator_down']
    local delete_elevator = Language[Config.Locale]['delete_elevator']

	Menu.addOption("mainmenu", function() if (Menu.Option(elevator_up)) then
		if elevator2Prop ~= nil then
			elevator2Down = false
			elevator2Up = true
			elevator2Stop = false
		end
	end end)

	Menu.addOption("mainmenu", function() if (Menu.Option(elevator_stop)) then
		if elevator2Prop ~= nil then
			elevator2Up = false
			elevator2Down = false
		end
	end end)
	
    Menu.addOption("mainmenu", function() if (Menu.Option(elevator_down)) then
		if elevator2Prop ~= nil then
			elevator2Up = false
			elevator2Down = true
			elevator2Stop = false
		end
	end end)

    if Config.debug then
		Menu.addOption("mainmenu", function() if (Menu.Option(delete_elevator)) then
			deleteObject(elevatorProp)
			deleteObject(elevator2Prop)
		end end)
	end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		--pont1
		local elevatorCoords = GetEntityCoords(elevatorProp, false)
		
		if elevatorUp then
			if elevatorCoords.z < Config.max then -- hauteur max de la nacelle
				if (elevatorCoords.z > Config.beforemax) then -- juste avant la hauteur max de la nacelle
					elevatorBaseZ = elevatorBaseZ + Config.speed_up_slow -- de combien de Z on monte à chaque fois (= vitesse de monte)
					SetEntityCoords(elevatorProp, elevatorBaseX, elevatorBaseY, elevatorBaseZ, false, false, false, false)
				else
					elevatorBaseZ = elevatorBaseZ + Config.speed_up -- de combien de Z on monte à chaque fois (= vitesse de monte)
					SetEntityCoords(elevatorProp, elevatorBaseX, elevatorBaseY, elevatorBaseZ, false, false, false, false)
				end
			end
		end
		
		if elevatorDown then
			if elevatorCoords.z > Config.min then -- hauteur min de la nacelle
				if (elevatorCoords.z < Config.beforemin) then -- juste avant la hauteur min de la nacelle
					elevatorBaseZ = elevatorBaseZ - Config.speed_down_slow -- de combien de Z on descend à chaque fois (= vitesse de monte)
					SetEntityCoords(elevatorProp, elevatorBaseX, elevatorBaseY, elevatorBaseZ, false, false, false, false)
				else
					elevatorBaseZ = elevatorBaseZ - Config.speed_down -- de combien de Z on descend à chaque fois (= vitesse de monte)
					SetEntityCoords(elevatorProp, elevatorBaseX, elevatorBaseY, elevatorBaseZ, false, false, false, false)
				end 
			end
		end

		--pont2
		local elevator2Coords = GetEntityCoords(elevator2Prop, false)
		
		if elevator2Up then
			-- TriggerServerEvent('InteractSound_CL:PlayOnOne', 'PontMecano_Monte', 1.0)
			if elevator2Coords.z < Config.max then -- hauteur max de la nacelle
				if (elevator2Coords.z > Config.beforemax) then -- juste avant la hauteur max de la nacelle
					elevator2BaseZ = elevator2BaseZ + Config.speed_up_slow -- de combien de Z on monte à chaque fois (= vitesse de monte)
					SetEntityCoords(elevator2Prop, elevator2BaseX, elevator2BaseY, elevator2BaseZ, false, false, false, false)
				else
					elevator2BaseZ = elevator2BaseZ + Config.speed_up -- de combien de Z on monte à chaque fois (= vitesse de monte)
					SetEntityCoords(elevator2Prop, elevator2BaseX, elevator2BaseY, elevator2BaseZ, false, false, false, false)
				end
			end
		elseif elevator2Down then
			-- TriggerServerEvent('InteractSound_CL:PlayOnOne', 'PontMecano_Descente', 1.0)
			if elevator2Coords.z > Config.min then -- hauteur min de la nacelle
				if (elevator2Coords.z < Config.beforemin) then -- juste avant la hauteur min de la nacelle
					elevator2BaseZ = elevator2BaseZ - Config.speed_down_slow -- de combien de Z on descend à chaque fois (= vitesse de monte)
					SetEntityCoords(elevator2Prop, elevator2BaseX, elevator2BaseY, elevator2BaseZ, false, false, false, false)
				else
					elevator2BaseZ = elevator2BaseZ - Config.speed_up -- de combien de Z on descend à chaque fois (= vitesse de monte)
					SetEntityCoords(elevator2Prop, elevator2BaseX, elevator2BaseY, elevator2BaseZ, false, false, false, false)
				end
			end
		end
    end
end)


-- key controls
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		
		local pos = GetEntityCoords(GetPlayerPed(-1), false)
		
		if (Vdist(-219.3204, -1326.43, 29.89041, pos.x, pos.y, pos.z - 1) < 1.5) then -- Si on est a moins de 1.5 de distance de cette coordonnée
			if IsControlJustReleased(1, Config.Open_key) then -- Si on appuis sur E
				garage_menu = not garage_menu -- on s'assure que le menu soit fermé
				Main() -- ouverture du menu
			end
		elseif (Vdist(-212.798, -1317.543, 30.890, pos.x, pos.y, pos.z - 1) < 1.5) then -- Si on est a moins de 1.5 de distance de cette coordonnée
			if IsControlJustReleased(1, Config.Open_key) then -- Si on appuis sur E
				garage_menu = not garage_menu -- on s'assure que le menu soit fermé
				Main2() -- ouverture du menu
			end
		else
			if (prevMenu == nil) then
				Menu.Switch(nil, "")
				menuOpen = false
				if garage_menu then
					garage_menu = false
				end
				currentOption = 1
			elseif not (prevMenu == nil) then
				if not Menus[prevMenu].previous == nil then
					currentOption = 1
					Menu.Switch(nil, prevMenu)
				else
					if Menus[prevMenu].optionCount < currentOption then
						currentOption = Menus[prevMenu].optionCount
					end
					Menu.Switch(Menus[prevMenu].previous, prevMenu)
				end
			end
		end

		-- On fait apparaitre la nacelle toute les demi seconde si jamais elle n'est pas là
	    if not la_nacelle_estelle_la and (Vdist(-219.3204, -1326.43, 29.89041, pos.x, pos.y, pos.z - 1) < Config.spawndistance) then
	    	spawnProp("nacelle", elevatorBaseX, elevatorBaseY, elevatorBaseZ)
	    	spawnProp2("nacelle", elevator2BaseX, elevator2BaseY, elevator2BaseZ)
	    	Wait(1000)
	    end
		
        if garage_menu then -- on désactive des touchez pendant que le menu est ouvert
			DisableControlAction(1, 22, true)
			DisableControlAction(1, 0, true)
			DisableControlAction(1, 27, true)
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(1, 20, true)
			
			DisableControlAction(1, 187, true)
			
			DisableControlAction(1, 80, true)
			DisableControlAction(1, 95, true)
			DisableControlAction(1, 96, true)
			DisableControlAction(1, 97, true)
			DisableControlAction(1, 98, true)
			
			DisableControlAction(1, 81, true)
			DisableControlAction(1, 82, true)
			DisableControlAction(1, 83, true)
			DisableControlAction(1, 84, true)
			DisableControlAction(1, 85, true)
			
			DisableControlAction(1, 74, true)
			
			HideHelpTextThisFrame()
			SetCinematicButtonActive(false)
            Menu.DisplayCurMenu()
        end
    end
end)
----------------------------
-- By K3rhos & DoluTattoo --
----------------------------
