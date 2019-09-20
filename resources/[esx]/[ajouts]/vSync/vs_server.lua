------------------ change this -------------------

admins = {
    'steam:11000010dbee8b6', -- ikNox
}

-- Set this to false if you don't want the weather to change automatically every 10 minutes.
DynamicWeather = false

--------------------------------------------------
debugprint = false -- don't touch this unless you know what you're doing or you're being asked by Vespura to turn this on.
--------------------------------------------------







-------------------- DON'T CHANGE THIS --------------------
AvailableWeatherTypes = {
    'EXTRASUNNY', 
    'CLEAR', 
    'NEUTRAL', 
    'SMOG', 
    'FOGGY', 
    'OVERCAST', 
    'CLOUDS', 
    'CLEARING', 
    'RAIN', 
    'THUNDER', 
    'SNOW', 
    'BLIZZARD', 
    'SNOWLIGHT', 
    'XMAS', 
    'HALLOWEEN',
}
CurrentWeather = "EXTRASUNNY"
local baseTime = 0
local timeOffset = 0
local freezeTime = false
local blackout = false
local newWeatherTimer = 10

RegisterServerEvent('vSync:requestSync')
AddEventHandler('vSync:requestSync', function()
    TriggerClientEvent('vSync:updateWeather', -1, CurrentWeather, blackout)
    TriggerClientEvent('vSync:updateTime', -1, baseTime, timeOffset, freezeTime)
end)

function isAllowedToChange(player)
    local allowed = false
    for i,id in ipairs(admins) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if debugprint then print('admin id: ' .. id .. '\nplayer id:' .. pid) end
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end

RegisterCommand('freezetime', function(source, args)
    if source ~= 0 then
        if isAllowedToChange(source) then
            freezeTime = not freezeTime
            if freezeTime then
                TriggerClientEvent('vSync:notify', source, 'Time is now ~b~frozen~s~.')
            else
                TriggerClientEvent('vSync:notify', source, 'Time is ~y~no longer frozen~s~.')
            end
        else
            TriggerClientEvent('chatMessage', source, '', {255,255,255}, '^8Error: ^1Vous n\'etes pas autorisé a utiliser cette commande.')
        end
    else
        freezeTime = not freezeTime
        if freezeTime then
            print("Le temps est freeze.")
        else
            print("Le temps n\'est plus freeze .")
        end
    end
end)

RegisterCommand('freezeweather', function(source, args)
    if source ~= 0 then
        if isAllowedToChange(source) then
            DynamicWeather = not DynamicWeather
            if not DynamicWeather then
                TriggerClientEvent('vSync:notify', source, 'Changements métérologiques dynamiques ~r~desactivé~s~.')
            else
                TriggerClientEvent('vSync:notify', source, 'Changements métérologiques dynamiques ~b~activé~s~.')
            end
        else
            TriggerClientEvent('chatMessage', source, '', {255,255,255}, '^8Error: ^1Vous n\'etes pas autorisé a utiliser cette commande.')
        end
    else
        DynamicWeather = not DynamicWeather
        if not DynamicWeather then
            print("La météo est freeze.")
        else
            print("La météo n\'est plus freeze.")
        end
    end
end)

RegisterCommand('weather', function(source, args)
    if source == 0 then
        local validWeatherType = false
        if args[1] == nil then
            print("Commande invalide, la commande est: /weather <weathertype> ")
            return
        else
            for i,wtype in ipairs(AvailableWeatherTypes) do
                if wtype == string.upper(args[1]) then
                    validWeatherType = true
                end
            end
            if validWeatherType then
                print("Le temps à été mis a jour.")
                CurrentWeather = string.upper(args[1])
                newWeatherTimer = 10
                TriggerEvent('vSync:requestSync')
            else
                print("Météo invalide, les types de météos valides sont: \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ")
            end
        end
    else
        if isAllowedToChange(source) then
            local validWeatherType = false
            if args[1] == nil then
                TriggerClientEvent('chatMessage', source, '', {255,255,255}, '^8Error: ^1Invalid syntax, use ^0/weather <weatherType> ^1instead!')
            else
                for i,wtype in ipairs(AvailableWeatherTypes) do
                    if wtype == string.upper(args[1]) then
                        validWeatherType = true
                    end
                end
                if validWeatherType then
                    TriggerClientEvent('vSync:notify', source, 'Weather will change to: ~y~' .. string.lower(args[1]) .. "~s~.")
                    CurrentWeather = string.upper(args[1])
                    newWeatherTimer = 10
                    TriggerEvent('vSync:requestSync')
                else
                    TriggerClientEvent('chatMessage', source, '', {255,255,255}, '^8Error: ^1Invalid weather type, valid weather types are: ^0\nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ')
                end
            end
        else
            TriggerClientEvent('chatMessage', source, '', {255,255,255}, '^8Error: ^1You do not have access to that command.')
            print('Accès pour la commande /weather refusé.')
        end
    end
end, false)

RegisterCommand('blackout', function(source)
    if source == 0 then
        blackout = not blackout
        if blackout then
            print("Blackout activé.")
        else
            print("Blackout désactivé.")
        end
    else
        if isAllowedToChange(source) then
            blackout = not blackout
            if blackout then
                TriggerClientEvent('vSync:notify', source, 'Blackout is now ~b~enabled~s~.')
            else
                TriggerClientEvent('vSync:notify', source, 'Blackout is now ~r~disabled~s~.')
            end
            TriggerEvent('vSync:requestSync')
        end
    end
end)

RegisterCommand('morning', function(source)
    if source == 0 then
        print("Poue la console, utilisez \"/time <hh> <mm>\" à la place!")
        return
    end
    if isAllowedToChange(source) then
        ShiftToMinute(0)
        ShiftToHour(9)
        TriggerClientEvent('vSync:notify', source, 'Time set to ~y~morning~s~.')
        TriggerEvent('vSync:requestSync')
    end
end)
RegisterCommand('noon', function(source)
    if source == 0 then
        print("Pour la console, utilisez \"/time <hh> <mm>\" à la place!")
        return
    end
    if isAllowedToChange(source) then
        ShiftToMinute(0)
        ShiftToHour(12)
        TriggerClientEvent('vSync:notify', source, 'Time set to ~y~noon~s~.')
        TriggerEvent('vSync:requestSync')
    end
end)
RegisterCommand('evening', function(source)
    if source == 0 then
        print("Pour la console, utilisez \"/time <hh> <mm>\" à la place!")
        return
    end
    if isAllowedToChange(source) then
        ShiftToMinute(0)
        ShiftToHour(18)
        TriggerClientEvent('vSync:notify', source, 'Time set to ~y~evening~s~.')
        TriggerEvent('vSync:requestSync')
    end
end)
RegisterCommand('night', function(source)
    if source == 0 then
        print("Pour la console, utilisez \"/time <hh> <mm>\" à la place!")
        return
    end
    if isAllowedToChange(source) then
        ShiftToMinute(0)
        ShiftToHour(23)
        TriggerClientEvent('vSync:notify', source, 'Time set to ~y~night~s~.')
        TriggerEvent('vSync:requestSync')
    end
end)

function ShiftToMinute(minute)
    timeOffset = timeOffset - ( ( (baseTime+timeOffset) % 60 ) - minute )
end

function ShiftToHour(hour)
    timeOffset = timeOffset - ( ( ((baseTime+timeOffset)/60) % 24 ) - hour ) * 60
end

RegisterCommand('time', function(source, args, rawCommand)
    if source == 0 then
        if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil then
            local argh = tonumber(args[1])
            local argm = tonumber(args[2])
            if argh < 24 then
                ShiftToHour(argh)
            else
                ShiftToHour(0)
            end
            if argm < 60 then
                ShiftToMinute(argm)
            else
                ShiftToMinute(0)
            end
            print("L'heure est désormais " .. argh .. ":" .. argm .. ".")
            TriggerEvent('vSync:requestSync')
        else
            print("Syntax invalide, la syntaxe correcte est: time <hour> <minute> !")
        end
    elseif source ~= 0 then
        if isAllowedToChange(source) then
            if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil then
                local argh = tonumber(args[1])
                local argm = tonumber(args[2])
                if argh < 24 then
                    ShiftToHour(argh)
                else
                    ShiftToHour(0)
                end
                if argm < 60 then
                    ShiftToMinute(argm)
                else
                    ShiftToMinute(0)
                end
                local newtime = math.floor(((baseTime+timeOffset)/60)%24) .. ":"
				local minute = math.floor((baseTime+timeOffset)%60)
                if minute < 10 then
                    newtime = newtime .. "0" .. minute
                else
                    newtime = newtime .. minute
                end
                TriggerClientEvent('vSync:notify', source, 'Time was changed to: ~y~' .. newtime .. "~s~!")
                TriggerEvent('vSync:requestSync')
            else
                TriggerClientEvent('chatMessage', source, '', {255,255,255}, '^8Error: ^1Invalid syntax. Use ^0/time <hour> <minute> ^1instead!')
            end
        else
            TriggerClientEvent('chatMessage', source, '', {255,255,255}, '^8Error: ^1You do not have access to that command.')
            print('Accès a la commande /time refusé.')
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local newBaseTime = os.time(os.date("!*t"))/2 + 360
        if freezeTime then
            timeOffset = timeOffset + baseTime - newBaseTime			
        end
        baseTime = newBaseTime
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        TriggerClientEvent('vSync:updateTime', -1, baseTime, timeOffset, freezeTime)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(300000)
        TriggerClientEvent('vSync:updateWeather', -1, CurrentWeather, blackout)
    end
end)

Citizen.CreateThread(function()
    while true do
        newWeatherTimer = newWeatherTimer - 1
        Citizen.Wait(60000)
        if newWeatherTimer == 0 then
            if DynamicWeather then
                NextWeatherStage()
            end
            newWeatherTimer = 10
        end
    end
end)

function NextWeatherStage()
    if CurrentWeather == "CLEAR" or CurrentWeather == "CLOUDS" or CurrentWeather == "EXTRASUNNY"  then
        local new = math.random(1,2)
        if new == 1 then
            CurrentWeather = "CLEARING"
        else
            CurrentWeather = "OVERCAST"
        end
    elseif CurrentWeather == "CLEARING" or CurrentWeather == "OVERCAST" then
        local new = math.random(1,6)
        if new == 1 then
            if CurrentWeather == "CLEARING" then CurrentWeather = "FOGGY" else CurrentWeather = "RAIN" end
        elseif new == 2 then
            CurrentWeather = "CLOUDS"
        elseif new == 3 then
            CurrentWeather = "CLEAR"
        elseif new == 4 then
            CurrentWeather = "EXTRASUNNY"
        elseif new == 5 then
            CurrentWeather = "SMOG"
        else
            CurrentWeather = "FOGGY"
        end
    elseif CurrentWeather == "THUNDER" or CurrentWeather == "RAIN" then
        CurrentWeather = "CLEARING"
    elseif CurrentWeather == "SMOG" or CurrentWeather == "FOGGY" then
        CurrentWeather = "CLEAR"
    end
    TriggerEvent("vSync:requestSync")
    if debugprint then
        print("[vSync] Un nouveau type de météo aléatoire a été généré: " .. CurrentWeather .. ".\n")
        print("[vSync]  Réinitialiser la minuterie à 10 minutes.\n")
    end
end

