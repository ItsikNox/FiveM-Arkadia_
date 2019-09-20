Citizen.CreateThread(function()
	while true do
		SetDiscordAppId(DiscordAppID)
		SetDiscordRichPresenceAsset('logo')
        SetDiscordRichPresenceAssetText('Arkadia, Rejoingnez-nous !.')
        SetDiscordRichPresenceAssetSmall('info')
        SetDiscordRichPresenceAssetSmallText('https://discord.gg/')
		Citizen.Wait(60000)
	end
end)
Citizen.CreateThread(function()
	while true do
		local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
		if VehName == "NULL" then VehName = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))) end
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
		local StreetHash = GetStreetNameAtCoord(x, y, z)
		local pId = GetPlayerServerId(PlayerId())
		local pName = GetPlayerName(PlayerId())
		Citizen.Wait(15000)
		if StreetHash ~= nil then
			StreetName = GetStreetNameFromHashKey(StreetHash)
			if IsPedOnFoot(PlayerPedId()) and not IsEntityInWater(PlayerPedId()) then
				if IsPedSprinting(PlayerPedId()) then
					SetRichPresence("ID: "..pId.." | "..pName.." court sur "..StreetName)
				elseif IsPedRunning(PlayerPedId()) then
					SetRichPresence("ID: "..pId.." | "..pName.." s'épuise sur "..StreetName)
				elseif IsPedWalking(PlayerPedId()) then
					SetRichPresence("ID: "..pId.." | "..pName.." marche sur "..StreetName)
				elseif IsPedStill(PlayerPedId()) then
					SetRichPresence("ID: "..pId.." | "..pName.." est debout sur "..StreetName.."")
				end
			elseif GetVehiclePedIsUsing(PlayerPedId()) ~= nil and not IsPedInAnyHeli(PlayerPedId()) and not IsPedInAnyPlane(PlayerPedId()) and not IsPedOnFoot(PlayerPedId()) and not IsPedInAnySub(PlayerPedId()) and not IsPedInAnyBoat(PlayerPedId()) then
				local MPH = math.ceil(GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())) * 2.236936)
				if MPH > 50 then
					SetRichPresence("ID: "..pId.." | "..pName.." accélère sur "..StreetName.." à "..MPH.."KM/H dans un(e) "..VehName)
				elseif MPH <= 50 and MPH > 0 then
					SetRichPresence("ID: "..pId.." | "..pName.." est en croisière vers "..StreetName.." à "..MPH.."KM/H dans un(e) "..VehName)
				elseif MPH == 0 then
					SetRichPresence("ID: "..pId.." | "..pName.." est garé sur "..StreetName.." dans un(e) "..VehName)
				end
			elseif IsPedInAnyHeli(PlayerPedId()) or IsPedInAnyPlane(PlayerPedId()) then
				if IsEntityInAir(GetVehiclePedIsUsing(PlayerPedId())) or GetEntityHeightAboveGround(GetVehiclePedIsUsing(PlayerPedId())) > 5.0 then
					SetRichPresence("ID: "..pId.." | "..pName.." est en train de survoler "..StreetName.." dans un(e) "..VehName)
				else
					SetRichPresence("ID: "..pId.." | "..pName.." à atterri sur "..StreetName.." dans un(e) "..VehName)
				end
			elseif IsEntityInWater(PlayerPedId()) then
				SetRichPresence("ID: "..pId.." | "..pName.." nage")
			elseif IsPedInAnyBoat(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
				SetRichPresence("ID: "..pId.." | "..pName.." navigue dans un "..VehName)
			elseif IsPedInAnySub(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
				SetRichPresence("ID: "..pId.." | "..pName.." est dans un sous-marin jaune")
			end
		end
	end
end)

---------------------------------
--------- ikNox#6088 ------------
---------------------------------