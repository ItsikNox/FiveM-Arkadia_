local callActive = false
local haveTarget = false
local isCall = false
local work = {}
local target = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        -- if IsControlJustPressed(1, 56) then
        --     local plyPos = GetEntityCoords(GetPlayerPed(-1), true)
        --     TriggerServerEvent("call:makeCall", "uber", {x=plyPos.x,y=plyPos.y,z=plyPos.z})
        -- end

        -- Press Y key to get the call
        if IsControlJustPressed(1, 246) and callActive then
			if isCall == false then
				TriggerServerEvent("call:getCall", work)
				SendNotification("~b~Vous avez pris l'appel !")
				target.blip = AddBlipForCoord(target.pos.x, target.pos.y, target.pos.z)
				SetBlipRoute(target.blip, true)
				haveTarget = true
				isCall = true
				callActive = false
			else
				SendNotification("~r~Vous avez déjà un appel en cours !")
			end
        -- Press L key to decline the call
        elseif IsControlJustPressed(1, 249) and callActive then
            SendNotification("~r~Vous avez refusé l'appel.")
            callActive = false
        end
        if haveTarget then
            DrawMarker(1, target.pos.x, target.pos.y, target.pos.z-1, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 255, 255, 0, 200, 0, 0, 0, 0)
            local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
            if Vdist(target.pos.x, target.pos.y, target.pos.z, playerPos.x, playerPos.y, playerPos.z) < 2.0 then
                RemoveBlip(target.blip)
                haveTarget = false
				isCall = false
            end
        end
    end
end)

RegisterNetEvent("call:cancelCall")
AddEventHandler("call:cancelCall", function()
	if haveTarget then
		RemoveBlip(target.blip)
        haveTarget = false
		isCall = false
	else
		TriggerEvent("itinerance:notif", "~r~Vous n'avez aucun appel en cours !")
	end
end)

RegisterNetEvent("call:callIncoming")
AddEventHandler("call:callIncoming", function(job, pos, msg)
    callActive = true
    work = job
    target.pos = pos
	SendNotification("Appuyez sur ~b~Y~s~ pour prendre l'appel ou ~r~N~s~ pour le refuser")
	if work == "police" then
		SendNotification("~b~APPEL EN COURS:~w~ " ..tostring(msg))
		--SendNotification("Appuyez sur ~g~Y~s~ pour prendre l'appel ou ~g~L~s~ pour le refuser")
	elseif work == "mecano" then
		SendNotification("~o~APPEL EN COURS:~w~ " ..tostring(msg))
	elseif work == "taxi" then
		SendNotification("~y~APPEL EN COURS:~w~ " ..tostring(msg))
		--SendNotification("Appuyez sur ~g~Y~s~ pour prendre l'appel ou ~g~L~s~ pour le refuser")
	elseif work == "ambulance" then
		SendNotification("~r~APPEL EN COURS:~w~ " ..tostring(msg))
	elseif work == "fib" then
		SendNotification("~r~APPEL EN COURS:~w~ " ..tostring(msg))
	elseif work == "pilot" then
		SendNotification("~r~APPEL EN COURS:~w~ " ..tostring(msg))
	elseif work == "epicerie" then
		SendNotification("~r~APPEL EN COURS:~w~ " ..tostring(msg))
	elseif work == "brinks" then
		SendNotification("~r~APPEL EN COURS:~w~ " ..tostring(msg))
	elseif work == "army" then
		SendNotification("~r~APPEL EN COURS:~w~ " ..tostring(msg))
	elseif work == "realestateagent" then
		SendNotification("~r~APPEL EN COURS:~w~ " ..tostring(msg))
	elseif work == "unicorn" then
		SendNotification("~r~APPEL EN COURS:~w~ " ..tostring(msg))
	elseif work == "journaliste" then
		SendNotification("~r~APPEL EN COURS:~w~ " ..tostring(msg))
	elseif work == "state" then
		SendNotification("~r~APPEL EN COURS:~w~ " ..tostring(msg))
	end
end)

RegisterNetEvent("call:taken")
AddEventHandler("call:taken", function()
    callActive = false
    SendNotification("L'appel a été pris")
end)

RegisterNetEvent("target:call:taken")
AddEventHandler("target:call:taken", function(taken)
    if taken == 1 then
        SendNotification("~b~Quelqu'un arrive !")
    elseif taken == 0 then
        SendNotification("~r~Personne ne peut venir !")
    elseif taken == 2 then
        SendNotification("~o~Veuillez rappeler dans quelques instants.")
    end
end)

-- If player disconnect, remove him from the inService server table
AddEventHandler('playerDropped', function()
	TriggerServerEvent("player:serviceOff", nil)
end)

function SendNotification(message)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(message)
    DrawNotification(false, false)
end
