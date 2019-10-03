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

local handsup = false

function getSurrenderStatus()
	return handsup
end

RegisterNetEvent('KZ:getSurrenderStatusPlayer')
AddEventHandler('KZ:getSurrenderStatusPlayer', function(event, source)
	if handsup then
		TriggerServerEvent("KZ:reSendSurrenderStatus", event, source, true)
	else
		TriggerServerEvent("KZ:reSendSurrenderStatus", event, source, false)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local plyPed = PlayerPedId()

		if (IsControlJustPressed(1, Config.handsUP.clavier) or IsDisabledControlJustPressed(1, Config.handsUP.clavier)) then
			if DoesEntityExist(plyPed) and not IsEntityDead(plyPed) then
				if not IsPedInAnyVehicle(plyPed, false) and not IsPedSwimming(plyPed) and not IsPedShooting(plyPed) and not IsPedClimbing(plyPed) and not IsPedCuffed(plyPed) and not IsPedDiving(plyPed) and not IsPedFalling(plyPed) and not IsPedJumpingOutOfVehicle(plyPed) and not IsPedUsingAnyScenario(plyPed) and not IsPedInParachuteFreeFall(plyPed) then
					RequestAnimDict("random@mugging3")

					while not HasAnimDictLoaded("random@mugging3") do
						Citizen.Wait(100)
					end

					if not handsup then
						handsup = true
						TaskPlayAnim(plyPed, "random@mugging3", "handsup_standing_base", 8.0, -8, -1, 49, 0, 0, 0, 0)
					elseif handsup then
						handsup = false
						ClearPedSecondaryTask(plyPed)
					end
				end
			end
		end
	end
end)