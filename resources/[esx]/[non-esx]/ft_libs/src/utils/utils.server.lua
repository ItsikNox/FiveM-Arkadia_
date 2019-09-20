--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_libs
--

--
-- Get SeamID
--
function GetSteamIDFormSource(source)

    assert(type(source) == "number", "source must be number")

    local identifier = GetPlayerIdentifiers(source)
    if identifier[1] ~= nil and string.find(identifier[1], "steam") then
        return identifier[1]
    end
	return false

end

--
-- Get IP
--
function GetIpFormSource(source)

    assert(type(source) == "number", "source must be number")

    local ip = GetPlayerEP(source)
    if ip ~= nil then
        return ip
    end
	return false

end

--
-- PrintTable event
--
RegisterServerEvent("ft_libs:PrintTable")
AddEventHandler('ft_libs:PrintTable', function(value)

    print("---------[ft_libs : Debug]---------")
    PrintTable(value)
    print("-------------------------")

end)

--
--
--
AddEventHandler('onServerResourceStart', function(resource)

    if resource == 'ft_libs' then
        debugMode = GetConvar("ft_debug", "false")

        if debugMode == "true" then
            print("[FT_LIBS] DEBUG MODE ENABLE")
            debugMode = true
        else
            debugMode = false
        end
    end

end)

--
--
--
RegisterServerEvent("ft_libs:OnClientReady")
AddEventHandler('ft_libs:OnClientReady', function()

	TriggerClientEvent("ft_libs:DebugMode", source, debugMode)

end)

--
-- Rcon comand
--
RegisterServerEvent("rconCommand")
AddEventHandler("rconCommand", function(command, args)

    if command == "ft_debugMode" then

        local count = #args
        if count == 0 then

            if debugMode == true then
                debugMode = false
            else
                debugMode = true
            end

        elseif count == 1 then

            local arg = args[1]
            if arg == "true" or arg == "1" then
                debugMode = true
            elseif arg == "false" or arg == "0" then
                debugMode = false
            end

        end

        -- Print to console
        if debugMode == true then
            print("[FT_LIBS] DEBUG MODE ENABLE")
        else
            print("[FT_LIBS] DEBUG MODE DISABLE")
        end

        TriggerClientEvent("ft_libs:DebugMode", -1, debugMode)
        CancelEvent()

    end

end)

