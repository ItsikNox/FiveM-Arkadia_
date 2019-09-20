CurrentWeather = 'FOGGY'
Time = {}
Time.h = 7
Time.m = 0


RegisterNetEvent('updateWeather')
AddEventHandler('updateWeather', function(NewWeather)
    CurrentWeather = NewWeather
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100) -- Wait 0 seconds to prevent crashing.
        ClearWeatherTypePersist()
        SetWeatherTypeNowPersist(CurrentWeather)
        SetWeatherTypeNow(CurrentWeather)
        SetWeatherTypePersist(CurrentWeather)
        if CurrentWeather == 'XMAS' then
            SetForceVehicleTrails(true)
            SetForcePedFootstepsTracks(true)
        else
            SetForceVehicleTrails(false)
            SetForcePedFootstepsTracks(false)
        end      
    end
end)

RegisterNetEvent('updateTime')
AddEventHandler('updateTime', function(hours, minutes)
    Time.h = hours
    Time.m = minutes
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        NetworkOverrideClockTime(Time.h, Time.m, 0)
        Time.m = Time.m + 1
        if Time.m > 59 then
            Time.m = 0
            Time.h = Time.h + 1
            if Time.h > 23 then
                Time.h = 0
            end
        end
    end
end)

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('requestSync')
end)

Citizen.CreateThread(function()
    while true 
    	do
    		-- These natives has to be called every frame.
        SetVehicleDensityMultiplierThisFrame(0.5)
		SetPedDensityMultiplierThisFrame(0.5)
		SetRandomVehicleDensityMultiplierThisFrame(0.5)
		SetParkedVehicleDensityMultiplierThisFrame(0.1)
		--SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
		
		-- These natives do not have to be called everyframe.
		SetGarbageTrucks(0)
		SetRandomBoats(1)
    	
		Citizen.Wait(1)
	end
end)

Citizen.CreateThread(function()
    RequestAnimDict('facials@gen_male@variations@normal')
    RequestAnimDict('mp_facial')

    while true do
        Citizen.Wait(300)
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