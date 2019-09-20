--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_libs
--

local markers = {}
local activeMarkers = {}
local currentMarkers = {}


--
-- Add Marker to activeMarkers table
--
function EnableMarker(...)

    local args = {...}
    local count = #args
    if count == 1 and type(args[1]) == "table" then

        for _, name in pairs(args[1]) do
            if markers[name] then
                activeMarkers[name] = true
            end
            Citizen.Wait(10)
        end

    elseif count == 1 then

        local name = args[1]
        if markers[name] then
            activeMarkers[name] = true
        end

    end

end

--
-- Remove Marker to activeMarkers table
--
function DisableMarker(...)

    local args = {...}
    local count = #args
    if count == 1 and type(args[1]) == "table"  then

        for _, name in pairs(args[1]) do
            activeMarkers[name] = nil
            currentMarkers[name] = nil
            Citizen.Wait(10)
        end

    elseif count == 1 then

        local name = args[1]
        activeMarkers[name] = nil
        currentMarkers[name] = nil

    end

end

--
-- Add or Remove Marker to activeMarkers table
--
function SwitchMarker(...)

    local args = {...}
    local count = #args
    if count == 1 and type(args[1]) == "table" then

        for name, status in pairs(args[1]) do
            if markers[name] ~= nil then
                if status == true then
                    EnableMarker(name)
                elseif status == false then
                    DisableMarker(name)
                end
            end
            Citizen.Wait(10)
        end

    elseif count == 2 then

        local name = args[1]
        local status = args[2]
        if markers[name] ~= nil then
            if status == true then
                EnableMarker(name)
            else
                DisableMarker(name)
            end
        end

    end

end

--
-- Add Marker in the markers table
--
function AddMarker(...)

    local args = {...}
    local count = #args
    if count == 1 and type(args[1]) == "table" then

        for name, value in pairs(args[1]) do
            if markers[name] == nil then
                markers[name] = marker.new(value)
                if value.enable == nil or value.enable == true then
                    EnableMarker(name)
                end
            end
            Citizen.Wait(10)
        end

    elseif count == 2 then

        local name = args[1]
        local value = args[2]
        if markers[name] == nil then
            markers[name] = marker.new(value)
            if value.enable == nil or value.enable == true then
                EnableMarker(name)
            end
        end

    end

end

--
-- Remove Marker in the markers table
--
function RemoveMarker(...)

    local args = {...}
    local count = #args
    if count == 1 and type(args[1]) == "table" then

        for _, name in ipairs(args[1]) do
            DisableMarker(name)
            markers[name] = nil
            Citizen.Wait(10)
        end

    elseif count == 1 then

        local name = args[1]
        DisableMarker(name)
        markers[name] = nil

    end

end

--
-- Set Marker
--
function SetMarker(...)

    local args = {...}
    local count = #args

    if count == 1 and type(args[1]) == "table" then

        for name, values in pairs(args[1]) do
            if markers[name] ~= nil then
                local marker = markers[name]
                for key, value in pairs(values) do
                    marker[key] = value
                end
            end
            Citizen.Wait(1)
        end

    elseif count == 2 then

        local name = args[1]
        local values = args[2]
        if markers[name] ~= nil then
            local marker = markers[name]
            for key, value in pairs(values) do
                marker[key] = value
            end
        end

    end

end

--
-- Get Current Marker
--
function CurrentMarker()

    return currentMarkers

end

--
-- Add check for global frame
--
function CheckMarkerThread()

    Citizen.CreateThread(function()

        while true do

            local playerCoords = GetPlayerCoords()
            for name, value in pairs(activeMarkers) do

                local target = markers[name]
                if target then
                    if GetDistanceBetween3DCoords(target.x, target.y, target.z, playerCoords.x, playerCoords.y, playerCoords.z) <= target.showDistance then
                        currentMarkers[name] = true
                    elseif currentMarkers[name] ~= nil then
                        currentMarkers[name] = nil
                    end
                end

            end

            Citizen.Wait(500)
        end

    end)

end

--
--
--
function ActiveMarkerThread()

    Citizen.CreateThread(function()

        while true do

            for name, value in pairs(currentMarkers) do
                local marker = markers[name]
                if marker and currentMarkers[name] ~= nil then
                    marker:Show()
                end
            end

            Citizen.Wait(5)
        end

    end)

end
