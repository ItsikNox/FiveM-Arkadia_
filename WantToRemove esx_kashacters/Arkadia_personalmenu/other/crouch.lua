local crouched = false
local GUI = {}
GUI.Time = 0

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        local plyPed = PlayerPedId()

        if DoesEntityExist(plyPed) and not IsEntityDead(plyPed) then 
            DisableControlAction(1, Config.crouch.clavier, true)

            if not IsPauseMenuActive() then 
                if IsDisabledControlJustPressed(1, Config.crouch.clavier) then 
                    RequestAnimSet("move_ped_crouched")

                    while not HasAnimSetLoaded("move_ped_crouched") do 
                        Citizen.Wait(100)
                    end 

                    if crouched == true then 
                        ResetPedMovementClipset(plyPed, 0)
                        crouched = false 
                    elseif crouched == false then
                        SetPedMovementClipset(plyPed, "move_ped_crouched", 0.25)
                        crouched = true 
                    end 
					
					GUI.Time = GetGameTimer()
                end
            end 
        end 
    end
end)