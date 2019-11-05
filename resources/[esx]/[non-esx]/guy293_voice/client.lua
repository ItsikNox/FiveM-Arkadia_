----------------------------------------------------------------
-- Copyright © 2019 by Guy Shefer
-- Made By: Guy293
-- GitHub: https://github.com/Guy293
-- Fivem Forum: https://forum.fivem.net/u/guy293/
----------------------------------------------------------------





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


local voice = {default = 12.0, shout = 26.0, whisper = 2.0, current = 0, level = nil}
local voicecar = {incar = 5.0, nexttocar = 18.0, current = 0, level = nil}
local voicepolice = {incar = 5.0, nexttocar = 18.0, speaker = 200.0, current = 0, level = nil}

Citizen.CreateThread(function()
    RequestAnimDict('facials@gen_male@variations@normal')
    RequestAnimDict('mp_facial')

    local talkingPlayers = {}
    
    while true do
        Citizen.Wait(100)
        local myId = PlayerId()

        for _,player in ipairs(GetActivePlayers()) do
            local boolTalking = NetworkIsPlayerTalking(player)

            if player ~= myId then
                if boolTalking and not talkingPlayers[player] then
                    PlayFacialAnim(GetPlayerPed(player), 'mic_chatter', 'mp_facial')
                    talkingPlayers[player] = true
                elseif not boolTalking and talkingPlayers[player] then
                    PlayFacialAnim(GetPlayerPed(player), 'mood_normal_1', 'facials@gen_male@variations@normal')
                    talkingPlayers[player] = nil
                end
            end
        end
    end
end) 

-- 8.0 will be the default range, change it if you want
Citizen.CreateThread(function()
	NetworkSetTalkerProximity(12.0)
end)

function drawLevel(r, g, b, a)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(0.5, 0.5)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()

	BeginTextCommandDisplayText("STRING")
	
	
	if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) and GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1)), -1) == GetPlayerPed(-1) then
		AddTextComponentSubstringPlayerName('~g~Mode Police - Voix: ~s~' .. voicepolice.level)
	elseif IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		AddTextComponentSubstringPlayerName('~g~Mode Voiture - Voix: ~s~' .. voicecar.level)
	else
		AddTextComponentSubstringPlayerName('~g~Voix: ~s~' .. voice.level)
	end
	EndTextCommandDisplayText(0.165, 0.965)
end

AddEventHandler('onClientMapStart', function()
	if voice.current == 0 then
		NetworkSetTalkerProximity(voice.default)
	elseif voice.current == 1 then
		NetworkSetTalkerProximity(voice.shout)
	elseif voice.current == 2 then
		NetworkSetTalkerProximity(voice.whisper)
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		 if IsControlPressed(0, Keys['H']) and IsControlPressed(0, Keys['LEFTSHIFT']) then
			local pos = GetEntityCoords(GetPlayerPed(-1), true)
			if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) and GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1)), -1) == GetPlayerPed(-1) then
				if voicepolice.current == 0 then
					DrawMarker(1,pos.x,pos.y,pos.z - 0.5, 0, 0, 0, 0, 0, 0, voicepolice.incar, voicepolice.incar, 1.5, 255, 255, 178, 0, 0, true, 2, 0, 0, 0, 0)
				elseif voicepolice.current == 1 then
					DrawMarker(1,pos.x,pos.y,pos.z - 0.5, 0, 0, 0, 0, 0, 0, voicepolice.nexttocar, voicepolice.nexttocar, 1.5, 255, 255, 178, 0, 0, true, 2, 0, 0, 0, 0)
				elseif voicepolice.current == 2 then
					DrawMarker(1,pos.x,pos.y,pos.z - 0.5, 0, 0, 0, 0, 0, 0, voicepolice.speaker, voicepolice.speaker, 1.5, 255, 255, 178, 0, 0, true, 2, 0, 0, 0, 0)
				end
			elseif IsPedInAnyVehicle(GetPlayerPed(-1), false) then
				if voicecar.current == 0 then
					DrawMarker(1,pos.x,pos.y,pos.z - 0.5, 0, 0, 0, 0, 0, 0, voicecar.incar, voicecar.incar, 1.5, 255, 255, 178, 0, 0, true, 2, 0, 0, 0, 0)
				elseif voicecar.current == 1 then
					DrawMarker(1,pos.x,pos.y,pos.z - 0.5, 0, 0, 0, 0, 0, 0, voicecar.nexttocar, voicecar.nexttocar, 1.5, 255, 255, 178, 0, 0, true, 2, 0, 0, 0, 0)
				end
			else
				if voice.current == 1 then
					DrawMarker(1,pos.x,pos.y,pos.z - 0.95, 0, 0, 0, 0, 0, 0, voice.shout, voice.shout, 1.5, 255, 255, 178, 0, 0, true, 2, 0, 0, 0, 0)
				elseif voice.current == 2 then
					DrawMarker(1,pos.x,pos.y,pos.z - 0.95, 0, 0, 0, 0, 0, 0, voice.whisper, voice.whisper, 1.5, 255, 178, 0, 105, 0, true, 2, 0, 0, 0, 0)
				elseif voice.current == 0 then
					DrawMarker(1,pos.x,pos.y,pos.z - 0.95, 0, 0, 0, 0, 0, 0, voice.default, voice.default, 1.5, 255, 178, 0, 105, 0, true, 2, 0, 0, 0, 0)
				end
			end	
		end
	end
end)





Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
			if IsControlJustPressed(1, Keys['H']) and IsControlPressed(1, Keys['LEFTSHIFT']) then
				if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) and GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1)), -1) == GetPlayerPed(-1) then
					voicepolice.current = (voicepolice.current + 1) % 3
					if voicepolice.current == 0 then
						NetworkSetTalkerProximity(voicepolice.incar)
						voicepolice.level = 'Dans le véhicule'
					elseif voicepolice.current == 1 then
						NetworkSetTalkerProximity(voicepolice.nexttocar)
						voicepolice.level = 'À côté du véhicule'
					elseif voicepolice.current == 2 then
						NetworkSetTalkerProximity(voicepolice.speaker)
						voicepolice.level = 'Mégaphone'
					end	
					
				elseif IsPedInAnyVehicle(GetPlayerPed(-1), false) then
					voicecar.current = (voicecar.current + 1) % 2
					if voicecar.current == 0 then
						NetworkSetTalkerProximity(voicecar.incar)
						voicecar.level = 'Dans le véhicule'
					elseif voicecar.current == 1 then
						NetworkSetTalkerProximity(voicecar.nexttocar)
						voicecar.level ='À côté du véhicule'
					end	
					
				else
					voice.current = (voice.current + 1) % 3
					if voice.current == 0 then
						NetworkSetTalkerProximity(voice.default)
						voice.level = 'Normale'
					elseif voice.current == 1 then
						NetworkSetTalkerProximity(voice.shout)
						voice.level = 'Crier'
					elseif voice.current == 2 then
						NetworkSetTalkerProximity(voice.whisper)
						voice.level = 'Chuchoter'
					end	
					
				end
			end

		if voice.current == 0 then
			voice.level = 'Normale'
		elseif voice.current == 1 then
			voice.level = 'Crier'
		elseif voice.current == 2 then
			voice.level = 'Chuchoter'
		end
		
		if voicecar.current == 0 then
			voicecar.level = 'Dans le véhicule'
		elseif voicecar.current == 1 then
			voicecar.level = 'À côté du véhicule'
		end	
		
		if voicepolice.current == 0 then
			voicepolice.level = 'Dans le véhicule'
		elseif voicepolice.current == 1 then
			voicepolice.level = 'À côté du véhicule'
		elseif voicepolice.current == 2 then
			voicepolice.level = 'Mégaphone'
		end	
		
		if NetworkIsPlayerTalking(PlayerId()) then
			drawLevel(255, 178, 0, 255)
		elseif not NetworkIsPlayerTalking(PlayerId()) then
			drawLevel(127, 127, 127, 255)
		end
	end
end)
