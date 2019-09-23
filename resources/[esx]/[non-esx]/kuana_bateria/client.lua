ESX = nil

local bateria = 50 -- dont touch
-- Settings --

local teclatele = 57 --Touche: F10, when the phone dont have batery it block that key

local recarregar = {
	{x = -42.74, y = -1754.99, z = 28.45}, -- Emplacement de recharge
}


-- End Settings --


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
	TriggerServerEvent("kuana:updatebateriat")
end)



Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		if bateria > 1 then
			Citizen.Wait(60000)
			TriggerServerEvent("kuana:updatebateria")
		else
			DisableControlAction(0, teclatele, true) -- Disable phone
		end
	end
end)

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		for _,v in pairs(recarregar) do
			local ped = GetPlayerPed(-1)
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = GetDistanceBetweenCoords(v.x, v.y, v.z, x, y, z, 1)
			if distance <= 5 then
				Drawing.draw3DText(v.x, v.y, v.z, "[~g~Zone de charge~w~] ~n~Restez dans le ~b~cercle~w~ ~n~pour charger le ~y~téléphone~w~", 4, 0.15, 0.05, 255, 255, 255, 255)
				DrawMarker(27, v.x, v.y, v.z + 0.2, 0, 0, 0, 0, 0, 0, 0.5,0.5,0.5, 0, 232, 255, 155, 0, 0, 0, 0, 0, 0, 0)
			end
			if bateria < 99 and distance <= 1.3 then
				ESX.ShowNotification("[~g~Batterie de téléphone portable~w~]~n~Chargement du téléphone portable. Batterie: ~g~"..bateria.."%~w~")
				TriggerServerEvent("kuana:updatebateriat")
				Citizen.Wait(2000)
				TriggerServerEvent("kuana:updatebateriacarr")
			end
		end

		if (IsControlJustReleased(1, teclatele)) then
			local colorbat = "~w~"
			if bateria >= 60 then
				colorbat = "~g~"
			elseif bateria < 60 and bateria > 20 then
				colorbat = "~y~"
			elseif bateria <= 20 then
				colorbat = "~r~"
			end
			ESX.ShowNotification("[~g~Batterie de téléphone portable~w~]~n~Votre téléphone a "..colorbat..""..bateria.."%~w~~n~ de batterie")
		end
	end
end)

RegisterNetEvent('kuana:setbateria')
AddEventHandler('kuana:setbateria', function(check)
	
	bateria = check

end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer

	TriggerServerEvent("kuana:createdb")
end)

Drawing = setmetatable({}, Drawing)
Drawing.__index = Drawing

function Drawing.draw3DText(x,y,z,textInput,fontId,scaleX,scaleY,r, g, b, a)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*14
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(r, g, b, a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+1, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end