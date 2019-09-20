------------------------------
-- Server Password, Made by --
--  FAXES & GlitchDetector  --
------------------------------

--- CONFIG ---
password = "Password" -- Set server password here
kickMessage = "Mot de passe incorrecte" -- The invalid password kick message. Default: Invalid Password
timeRanOutMsg = "Vous n'avez plus le temps d'entrer le mot de passe" --Not active yet! Dont worry about this
timeoutMessage = "Mot de passe incorrecte. Veuillez attendre %s avant d'essayer de vous connecter à nouveau." -- Displayed if the user tries to attempt too many times, this locks them out of the server for x seconds
invalidPasswordTimeout = 5 * 60 -- Wait time before the player can re-join. Change the first value Not the '* 60'. Default: 5 minutes

---------------------------------------------------------------------------------------------------------------
local Timeouts = {}

function Timeout(source)
    Timeouts[GetPlayerIdentifier(source, 1)] = os.time() + invalidPasswordTimeout
end

function SecondsToClock(seconds)
    local seconds = tonumber(seconds)

    if seconds <= 0 then
        return "00", "00", "00", "00:00:00"
    else
        hours = string.format("%02.f", math.floor(seconds/3600));
        mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
        secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
        return hours, mins, secs, hours .. ":" .. mins .. ":" .. secs
    end
end

function TimesToSexy(m,s)
    local r = ""
    if m ~= "00" then
        r = r .. m .. "m"
    end
    if r ~= "" then r = r .. " " end
    r = r .. s .. "s"
    return r
end

function GetSexyTime(seconds)
    local _,m,s = SecondsToClock(seconds)
    return TimesToSexy(m,s)
end

---------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnecting", function(name, setMessage, deferrals)
    local source = source
    local timeout = Timeouts[GetPlayerIdentifier(source, 1)]
    if timeout then
        if timeout > os.time() then
			local sexytime = GetSexyTime(timeout - os.time())
            deferrals.defer()
            deferrals.update((timeoutMessage):format(sexytime))
            Wait(500)
            deferrals.done((timeoutMessage):format(sexytime))
        end
    end
end)

RegisterServerEvent("Fax:ServerPassword:Initialize")
AddEventHandler("Fax:ServerPassword:Initialize", function()
    local source = source
    if not IsPlayerAceAllowed(source, "Bypass") then
        TriggerClientEvent("Fax:ServerPassword:ShowPasswordPrompt", source)
    else
        TriggerClientEvent("Fax:ServerPassword:PassedPassword", source, true)
    end
end)

RegisterServerEvent('Fax:ServerPassword:CheckPassword')
AddEventHandler('Fax:ServerPassword:CheckPassword', function(Newpassword, attempts)
    local clPassword = Newpassword
    local s = source

    if clPassword == password then
        TriggerClientEvent("Fax:ServerPassword:PassedPassword", s)
    elseif password ~= clPassword then
        if attempts <= 0 then
            Timeout(s)
            DropPlayer(s, kickMessage)
        else
            TriggerClientEvent("Fax:ServerPassword:ShowPasswordPrompt", s)
        end
    else
        Timeout(s)
        DropPlayer(s, kickMessage)
    end
end)
-- A FaxDetector Project ;)