--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_libs
--

local blips = {}
local activeBlips = {}

--
--
--
function ShowBlip(...)

    local args = {...}
    local count = #args

    if count == 1 and type(args[1]) == "table" then
        for _, name in ipairs(args[1]) do
            Citizen.Wait(1)
            if blips[name] ~= nil and activeBlips[name] == nil then
                blips[name]:Show()
                blips[name].enable = true
                activeBlips[name] = true
            end
        end
    elseif count == 1 then
        local name = args[1]
        if blips[name] ~= nil and activeBlips[name] == nil then
            blips[name]:Show()
            blips[name].enable = true
            activeBlips[name] = true
        end
    end

end

--
--
--
function HideBlip(...)

    local args = {...}
    local count = #args

    if count == 1 and type(args[1]) == "table" then
        for _, name in ipairs(args[1]) do
            Citizen.Wait(1)
            if blips[name] ~= nil and activeBlips[name] == true then
                blips[name]:Hide()
                blips[name].enable = false
                blips[name].blip = nil
                activeBlips[name] = nil
            end
        end
    elseif count == 1 then
        local name = args[1]
        if blips[name] ~= nil and activeBlips[name] == true then
            blips[name]:Hide()
            blips[name].enable = false
            blips[name].blip = nil
            activeBlips[name] = nil
        end
    end

end

--
--
--
function AddBlip(...)

    local args = {...}
    local count = #args

    if count == 1 and type(args[1]) == "table" then
        for name, value in pairs(args[1]) do
            if blips[name] == nil then
                blips[name] = blip.new(value)
                if blips[name].enable then
                    ShowBlip(name)
                end
            end
            Citizen.Wait(10)
        end
    elseif count == 2 then
        local name = args[1]
        local value = args[2]
        if blips[name] == nil then
            blips[name] = blip.new(value)
            if blips[name].enable then
                ShowBlip(name)
            end
        end
    end

end

--
--
--
function RemoveBlip(...)

    local args = {...}
    local count = #args

    if count == 1 and type(args[1]) == "table" then
        for _, name in ipairs(args[1]) do
            if blips[name] ~= nil then
                HideBlip(name)
                blips[name] = nil
            end
           Citizen.Wait(10)
        end
    elseif count == 1 then
        local name = args[1]
        if blips[name] ~= nil then
            HideBlip(name)
            blips[name] = nil
        end
    end

end

--
-- Set Blip
--
function SetBlip(...)

    local args = {...}
    local count = #args

    if count == 1 and type(args[1]) == "table" then

        for name, values in pairs(args[1]) do
            if blips[name] ~= nil then
                local blip = blips[name]
                for key, value in pairs(values) do
                    blip[key] = value
                end
            end
            Citizen.Wait(1)
        end

    elseif count == 2 then

        local name = args[1]
        local values = args[2]
        if blips[name] ~= nil then
            local blip = blips[name]
            for key, value in pairs(values) do
                blip[key] = value
            end
        end

    end

end
