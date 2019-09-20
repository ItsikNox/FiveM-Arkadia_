local freeze = false
local shown = false

local radar =
{
	info = "~y~Initializing Radar Gun...~w~321...~y~Loaded! ",
}

Citizen.CreateThread( function()
	while true do
		Citizen.Wait(1) 
			if IsControlJustPressed(1, cfg.menuopen) then --246 = Y
     			if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey(cfg.radargun) then
					if shown == true then 
						shown = false 
						radar.info = string.format("~y~Initializing Radar Gun...~w~321...~y~Loaded! ")
					else 
						shown = true 	
     				end
   				end
  			end

		if IsControlJustPressed(1, cfg.bottomfreeze) then --38 = E
			freeze = false
		end

		if cfg.marker == true then
			if shown then
				if IsPlayerFreeAiming(PlayerId()) then
					local player = GetPlayerPed(-1)
					local coordA = GetOffsetFromEntityInWorldCoords(player, 0.0, 1.0, 1.0)
					local coordB = GetOffsetFromEntityInWorldCoords(player, 0.0, 105.0, 0.0)
					local frontcar = StartShapeTestCapsule(coordA, coordB, 15.0, 10, player, 7)
					local a, b, c, d, e = GetShapeTestResult(frontcar)
					local playerId = PlayerId()
					local pos = GetEntityCoords(e)
					if IsEntityAVehicle(e) then
						DrawMarker(cfg.markertype, pos.x,pos.y,pos.z+2.5, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 1.5001, 255, 165, 0,165, 0, 0, 0,0)
					end
				end
			end
		end

		if shown then
			if freeze == false then
				freeze = true
				local player = GetPlayerPed(-1)
				local coordA = GetOffsetFromEntityInWorldCoords(player, 0.0, 1.0, 1.0)
				local coordB = GetOffsetFromEntityInWorldCoords(player, 0.0, 105.0, 0.0)
				local frontcar = StartShapeTestCapsule(coordA, coordB, 3.0, 10, player, 7)
				local a, b, c, d, e = GetShapeTestResult(frontcar)
				local playerId = PlayerId()

				if IsEntityAVehicle(e) then
					if IsPlayerFreeAiming(playerId) then
						local fmodel = GetDisplayNameFromVehicleModel(GetEntityModel(e))
						PlaySoundFrontend(-1, "5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", false)
						if cfg.metric == true then
							local pos = GetEntityCoords(e)
							local fvspeed = GetEntitySpeed(e)*3.6  -- m/s to kmh
							local fplate = GetVehicleNumberPlateText(e)
							radar.info = string.format("~y~Plaque: ~w~%s  ~y~Model: ~w~%s  ~y~Vitesse: ~w~%s km/h", fplate, fmodel, math.ceil(fvspeed))
						else 
							local fvspeed = GetEntitySpeed(e)*2.23694 -- m/s to mph
							local fplate = GetVehicleNumberPlateText(e)
							radar.info = string.format("~y~Plaque: ~w~%s  ~y~Model: ~w~%s  ~y~Vitesse: ~w~%s mph", fplate, fmodel, math.ceil(fvspeed))
						end
					end
				end	
			end
			
			DrawRect(0.508, 0.94, 0.196, 0.116, 0, 0, 0, 150)
			DrawAdvancedText(0.600, 0.903, 0.005, 0.0028, 0.4, "Radar Gun", 0, 191, 255, 255, 6, 0)
			DrawAdvancedText(0.6, 0.928, 0.005, 0.0028, 0.4, radar.info, 255, 255, 255, 255, 6, 0)
		end			
	end
end)



function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end



Citizen.CreateThread( function()
    while true do
    	Citizen.Wait( 0 )
        if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey(cfg.radargun) then
            DisableControlAction( 0, 24, true ) -- Attack
            DisablePlayerFiring( GetPlayerPed( -1 ), true ) -- Disable weapon firing
            DisableControlAction( 0, 142, true ) -- MeleeAttackAlternate
        end
    end 
end )