-- Copyright © Vespura 2018
-- Edit it if you want, but don't re-release this without my permission, and never claim it to be yours!


------- Configurable options  -------

-- set the opacity of the clouds
local cloudOpacity = 0.01 -- (default: 0.01)

-- setting this to false will NOT mute the sound as soon as the game loads 
-- (you will hear background noises while on the loading screen, so not recommended)
local muteSound = true -- (default: true)



------- Code -------

-- Mutes or un-mutes the game's sound using a short fade in/out transition.
function ToggleSound(state)
    if state then
        StartAudioScene("MP_LEADERBOARD_SCENE");
    else
        StopAudioScene("MP_LEADERBOARD_SCENE");
    end
end

-- Runs the initial setup whenever the script is loaded.
function InitialSetup()
    -- Stopping the loading screen from automatically being dismissed.
    SetManualShutdownLoadingScreenNui(true)
    -- Disable sound (if configured)
    ToggleSound(muteSound)
    -- Switch out the player if it isn't already in a switch state.
    if not IsPlayerSwitchInProgress() then
        SwitchOutPlayer(PlayerPedId(), 0, 1)
    end
end


-- Hide radar & HUD, set cloud opacity, and use a hacky way of removing third party resource HUD elements.
function ClearScreen()
    SetCloudHatOpacity(cloudOpacity)
    HideHudAndRadarThisFrame()
    
    -- nice hack to 'hide' HUD elements from other resources/scripts. kinda buggy though.
    SetDrawOrigin(0.0, 0.0, 0.0, 0)
end

-- Sometimes this gets called too early, but sometimes it's perfectly timed,
-- we need this to be as early as possible, without it being TOO early, it's a gamble!
InitialSetup()


Citizen.CreateThread(function()

    -- In case it was called too early before, call it again just in case.
    InitialSetup()
    
    -- Wait for the switch cam to be in the sky in the 'waiting' state (5).
    while GetPlayerSwitchState() ~= 5 do
        Citizen.Wait(0)
        ClearScreen()
    end
    
    -- Shut down the game's loading screen (this is NOT the NUI loading screen).
    ShutdownLoadingScreen()
    
    ClearScreen()
    Citizen.Wait(0)
    DoScreenFadeOut(0)
    
    -- Shut down the NUI loading screen.
    ShutdownLoadingScreenNui()
    
    ClearScreen()
    Citizen.Wait(0)
    ClearScreen()
    DoScreenFadeIn(500)
    while not IsScreenFadedIn() do
        Citizen.Wait(0)
        ClearScreen()
    end
    
    local timer = GetGameTimer()
    
    -- Re-enable the sound in case it was muted.
    ToggleSound(false)
    
    while true do
        ClearScreen()
        Citizen.Wait(0)
        
        -- wait 5 seconds before starting the switch to the player
        if GetGameTimer() - timer > 5000 then
            
            -- Switch to the player.
            SwitchInPlayer(PlayerPedId())
            
            ClearScreen()
            
            -- Wait for the player switch to be completed (state 12).
            while GetPlayerSwitchState() ~= 12 do
                Citizen.Wait(0)
                ClearScreen()
            end
            -- Stop the infinite loop.
            break
        end
    end
    
    -- Reset the draw origin, just in case (allowing HUD elements to re-appear correctly)
    ClearDrawOrigin()
end)
