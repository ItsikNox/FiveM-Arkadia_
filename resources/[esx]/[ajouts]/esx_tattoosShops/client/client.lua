ESX = nil

local currentTattoos = {}
local cam = -1
local inMenu = false
Citizen.CreateThread(function()
	addBlips()
	while ESX == nil do
   	 TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
   	 Citizen.Wait(0)
  	end


	while true do
		Citizen.Wait(0)
		drawMarkers()
		if(isNearTattoosShop()) then
			Info(Config.TextToOpenMenu)
			if(IsControlJustPressed(1, Config.KeyToOpenMenu)) then
				inMenu = not inMenu
				ESX.UI.Menu.CloseAll()
				if(inMenu) then
					FreezeEntityPosition(GetPlayerPed(-1), true)
					openMenu()
				else
					FreezeEntityPosition(GetPlayerPed(-1), false)
					setPedSkin()
				end
			end
		end


		if(inMenu) then
			if(IsControlJustPressed(1, 177)) then
				ESX.UI.Menu.CloseAll()
				FreezeEntityPosition(GetPlayerPed(-1), false)
				RenderScriptCams(false, false, 0, 1, 0)
				DestroyCam(cam, false)
				setPedSkin()
				inMenu = false
			end
		elseif(DoesCamExist(cam)) then
			RenderScriptCams(false, false, 0, 1, 0)
			DestroyCam(cam, false)
		end
	end

end)








function openMenu()
	local elements = {}

	for _,k in pairs(tattoosCategories) do
		table.insert(elements, {label= k.name, value = k.value})
	end

	if(DoesCamExist(cam)) then
		RenderScriptCams(false, false, 0, 1, 0)
		DestroyCam(cam, false)
	end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'Tattoos_menu',
      {
        title    = 'Tattos',
        align    = 'left',
        elements = elements,
      },
      function(data, menu)
      	local currentLabel = data.current.label
      	local currentValue = data.current.value
      	if(data.current.value ~= nil) then
      		elements = {}

      		table.insert(elements, {label=Config.TextGoBackIntoMenu, value = nil})
      		for i,k in pairs(tattoosList[data.current.value]) do
      			table.insert(elements, {label= "Tattoo n°"..i.."	("..k.price..Config.MoneySymbol..")", value = i, price = k.price})
      		end

      		ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'Tattoos_Categories_menu',
				{
					title    = 'Tattos | '..currentLabel,
					align    = 'left',
					elements = elements,
				},
			function(data2, menu2)
				local price = data2.current.price
				if(data2.current.value ~= nil) then
					TriggerServerEvent("tattoos:save", currentTattoos, price, {collection = currentValue, texture = data2.current.value})
				else
					openMenu()
					RenderScriptCams(false, false, 0, 1, 0)
					DestroyCam(cam, false)
					cleanPlayer()
				end

			end,
			function(data2, menu2)
			    menu.close()
			    RenderScriptCams(false, false, 0, 1, 0)
				DestroyCam(cam, false)
				setPedSkin()
			end,
			function(data2,menu2)
				if(data2.current.value ~= nil) then
					drawTattoo(data2.current.value, currentValue)
				end
			end,
			function()

			end)

      	end

      end,
      function(data, menu)
        menu.close()
        setPedSkin()
      end
    )
end





function addBlips()

	for _,k in pairs(tattoosShops) do
		local blip = AddBlipForCoord(k.x, k.y, k.z)
		SetBlipSprite(blip, 75)
		SetBlipColour(blip, 1)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Tattoos Shop")
		EndTextCommandSetBlipName(blip)
	end

end


function drawMarkers()
	for _,k in pairs(tattoosShops) do
		DrawMarker(27,k.x,k.y,k.z-0.9,0,0,0,0,0,0,3.001,3.0001,0.5001,0,155,255,200,0,0,0,0)
	end
end

function isNearTattoosShop()

	for _,k in pairs(tattoosShops) do
		local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), k.x,k.y,k.z, true)

		if(distance < 3) then
			return true
		end
	end

	return false
end



function setPedSkin()
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        local model = nil

        if skin.sex == 0 then
          model = GetHashKey("mp_m_freemode_01")
        else
          model = GetHashKey("mp_f_freemode_01")
        end

        RequestModel(model)
        while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(1)
        end

        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)

        TriggerEvent('skinchanger:loadSkin', skin)
        TriggerEvent('esx:restoreLoadout')
    end)

    Citizen.Wait(1000)

    for _,k in pairs(currentTattoos) do
		ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(k.collection), GetHashKey(tattoosList[k.collection][k.texture].nameHash))
	end
end




function drawTattoo(current, collection)


	SetEntityHeading(GetPlayerPed(-1), 297.7296)

	ClearPedDecorations(GetPlayerPed(-1))
	for _,k in pairs(currentTattoos) do
		ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(k.collection), GetHashKey(tattoosList[k.collection][k.texture].nameHash))
	end

	if(GetEntityModel(GetPlayerPed(-1)) == -1667301416) then  -- GIRL SKIN
		SetPedComponentVariation(GetPlayerPed(-1), 8, 34,0, 2)
		SetPedComponentVariation(GetPlayerPed(-1), 3, 15,0, 2)
		SetPedComponentVariation(GetPlayerPed(-1), 11, 101,1, 2)
		SetPedComponentVariation(GetPlayerPed(-1), 4, 16,0, 2)
	else 													  -- BOY SKIN
		SetPedComponentVariation(GetPlayerPed(-1), 8, 15,0, 2)
		SetPedComponentVariation(GetPlayerPed(-1), 3, 15,0, 2)
		SetPedComponentVariation(GetPlayerPed(-1), 11, 91,0, 2)
		SetPedComponentVariation(GetPlayerPed(-1), 4, 14,0, 2)
	end



	ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(collection), GetHashKey(tattoosList[collection][current].nameHash))

	if(not DoesCamExist(cam)) then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)

		SetCamCoord(cam, GetEntityCoords(GetPlayerPed(-1)))
		SetCamRot(cam, 0.0, 0.0, 0.0)
		SetCamActive(cam,  true)
		RenderScriptCams(true,  false,  0,  true,  true)

		SetCamCoord(cam, GetEntityCoords(GetPlayerPed(-1)))
	end

	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))

	SetCamCoord(cam, x+tattoosList[collection][current].addedX, y+tattoosList[collection][current].addedY, z+tattoosList[collection][current].addedZ)
	SetCamRot(cam, 0.0, 0.0, tattoosList[collection][current].rotZ)
end




function cleanPlayer()
	ClearPedDecorations(GetPlayerPed(-1))
	for _,k in pairs(currentTattoos) do
		ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(k.collection), GetHashKey(tattoosList[k.collection][k.texture].nameHash))
	end
end


function Info(text, loop)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, loop, 1, 0)
end






RegisterNetEvent("tattoos:getPlayerTattoos")
AddEventHandler("tattoos:getPlayerTattoos", function(playerTattoosList)
	for _,k in pairs(playerTattoosList) do
		ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(k.collection), GetHashKey(tattoosList[k.collection][k.texture].nameHash))
	end
	currentTattoos = playerTattoosList
end)



local firstLoad = false
AddEventHandler("skinchanger:loadSkin", function(skin)
	if(not firstLoad) then
		Citizen.CreateThread(function()

			while not (GetEntityModel(GetPlayerPed(-1)) == GetHashKey("mp_m_freemode_01") or GetEntityModel(GetPlayerPed(-1)) == GetHashKey("mp_f_freemode_01")) do
				Citizen.Wait(10)
			end
			Citizen.Wait(750)
			TriggerServerEvent("tattoos:GetPlayerTattoos_s")
		end)
		firstLoad = true
	else
		Citizen.Wait(750)
		for _,k in pairs(currentTattoos) do
			ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(k.collection), GetHashKey(tattoosList[k.collection][k.texture].nameHash))
		end
	end
end)


RegisterNetEvent("tattoo:buySuccess")
AddEventHandler("tattoo:buySuccess", function(value)
	table.insert(currentTattoos, value)
end)