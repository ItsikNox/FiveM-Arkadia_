CurrentWeather = 'EXTRASUNNY'
local lastWeather = CurrentWeather
local baseTime = 0
local timeOffset = 0
local timer = 0
local freezeTime = true
local blackout = false

RegisterNetEvent('vSync:updateWeather')
AddEventHandler('vSync:updateWeather', function(NewWeather, newblackout)
    CurrentWeather = NewWeather
    blackout = newblackout
end)

Citizen.CreateThread(function()
    while true do
        if lastWeather ~= CurrentWeather then
            lastWeather = CurrentWeather
            SetWeatherTypeOverTime(CurrentWeather, 15.0)
            Citizen.Wait(15000)
        end
        Citizen.Wait(100) -- Wait 0 seconds to prevent crashing.
        SetBlackout(blackout)
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypePersist(lastWeather)
        SetWeatherTypeNow(lastWeather)
        SetWeatherTypeNowPersist(lastWeather)
        if lastWeather == 'XMAS' then
            SetForceVehicleTrails(true)
            SetForcePedFootstepsTracks(true)
        else
            SetForceVehicleTrails(false)
            SetForcePedFootstepsTracks(false)
        end
    end
end)

RegisterNetEvent('vSync:updateTime')
AddEventHandler('vSync:updateTime', function(base, offset, freeze)
    freezeTime = freeze
    timeOffset = offset
    baseTime = base
end)

Citizen.CreateThread(function()
    local hour = 0
    local minute = 0
    while true do
        Citizen.Wait(0)
        local newBaseTime = baseTime
        if GetGameTimer() - 500  > timer then
            newBaseTime = newBaseTime + 0.25
            timer = GetGameTimer()
        end
        if freezeTime then
            timeOffset = timeOffset + baseTime - newBaseTime			
        end
        baseTime = newBaseTime
        hour = math.floor(((baseTime+timeOffset)/60)%24)
        minute = math.floor((baseTime+timeOffset)%60)
        NetworkOverrideClockTime(hour, minute, 0)
    end
end)

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('vSync:requestSync')
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/weather', 'Changer le temps.', {{ name="weatherType", help="Types de temps: extrasunny, clear, neutral, smog, foggy, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas & halloween"}})
    TriggerEvent('chat:addSuggestion', '/time', 'Changer l\'heure.', {{ name="hours", help="Un chiffre entre 0 - 23"}, { name="minutes", help="Un chiffre entre 0 - 59"}})
    TriggerEvent('chat:addSuggestion', '/freezetime', 'Freeze / défreeze l\'heure.')
    TriggerEvent('chat:addSuggestion', '/freezeweather', 'Activé/désactivé les changements météorologiques dynamiques.')
    TriggerEvent('chat:addSuggestion', '/morning', 'Changer l\'heure pour 09:00')
    TriggerEvent('chat:addSuggestion', '/noon', 'Changer l\'heure pour 12:00')
    TriggerEvent('chat:addSuggestion', '/evening', 'Changer l\'heure pour 18:00')
    TriggerEvent('chat:addSuggestion', '/night', 'Changer l\'heure pour 23:00')
    TriggerEvent('chat:addSuggestion', '/blackout', 'Mode blackout.')
end)

-- Display a notification above the minimap.
function ShowNotification(text, blink)
    if blink == nil then blink = false end
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(blink, false)
end

RegisterNetEvent('vSync:notify')
AddEventHandler('vSync:notify', function(message, blink)
    ShowNotification(message, blink)
end)

---------------------------------
--------- ikNox#6088 ------------
---------------------------------