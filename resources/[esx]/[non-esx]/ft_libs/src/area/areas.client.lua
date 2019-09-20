--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_libs
--

local areas = {}

--
--
--
function EnableArea(...)

    local args = {...}
    local count = #args

    if count == 1 and type(args[1]) == "table" then

        for _, name in ipairs(args[1]) do

            if areas[name] ~= nil then
                for _, area in pairs(areas[name]) do
                    area:Enable()
                    area.enable = true
                    Citizen.Wait(10)
                end
            end
            Citizen.Wait(10)

        end

    elseif count == 1 then

        local name = args[1]
        if areas[name] ~= nil then
            for _, area in pairs(areas[name]) do
                area:Enable()
                area.enable = true
                Citizen.Wait(10)
            end
        end

    end

end

--
--
--
function DisableArea(...)

    local args = {...}
    local count = #args

    if count == 1 and type(args[1]) == "table" then

        for _, name in ipairs(args[1]) do

            if areas[name] ~= nil then
                for _, area in pairs(areas[name]) do
                    area:Disable()
                    area.enable = false
                    Citizen.Wait(10)
                end
            end
            Citizen.Wait(10)

        end

    elseif count == 1 then

        local name = args[1]
        if areas[name] ~= nil then
            for _, area in pairs(areas[name]) do
                area:Disable()
                area.enable = false
                Citizen.Wait(10)
            end
        end

    end

end

--
--
--
function SwitchArea(...)

    local args = {...}
    local count = #args

    if count == 1 and type(args[1]) == "table" then

        for name, status in ipairs(args[1]) do

            if areas[name] ~= nil then
                if status == true then
                    EnableArea(name)
                elseif status == false then
                    DisableArea(name)
                end
            end
            Citizen.Wait(10)

        end

    elseif count == 2 then

        local name = args[1]
        local status = args[2]
        if areas[name] ~= nil then
            for _, area in pairs(areas[name]) do
                if status == true then
                    EnableArea(name)
                elseif status == false then
                    DisableArea(name)
                end
            end
        end

    end

end

--
--
--
function AddArea(...)

    local args = {...}
    local count = #args
    local array = {}

    if count == 1 and type(args[1]) == "table" then

        for name, value in pairs(args[1]) do
            if areas[name] == nil then
                areas[name] = {}

                local trigger = value.trigger
                local blip = value.blip
                local marker = value.marker

                for key, location in pairs(value.locations) do
                    local newArea = {}
                    newArea.x = location.x
                    newArea.y = location.y
                    newArea.z = location.z
                    newArea.enable = value.enable
                    newArea.blip = Copy(blip)
                    newArea.marker = Copy(marker)
                    newArea.trigger = Copy(trigger)
                    areas[name][key] = area.new(name .. "_" .. key, newArea)
                    Citizen.Wait(10)
                end
            end
            Citizen.Wait(10)

        end

    elseif count == 2 then

        local name = args[1]
        local value = args[2]
        if areas[name] == nil then

            areas[name] = {}

            local trigger = value.trigger
            local blip = value.blip
            local marker = value.marker
            for key, location in pairs(value.locations) do
                local newArea = {}
                newArea.x = location.x
                newArea.y = location.y
                newArea.z = location.z
                newArea.enable = value.enable
                newArea.blip = Copy(blip)
                newArea.marker = Copy(marker)
                newArea.trigger = Copy(trigger)
                areas[name][key] = area.new(name .. "_" .. key, newArea)
                Citizen.Wait(10)
            end

        end

    end

end

--
--
--
function RemoveArea(...)

    local args = {...}
    local count = #args
    local array = {}

    if count == 1 and type(args[1]) == "table" then

        for _, name in ipairs(args[1]) do

            if areas[name] ~= nil then

                for _, area in pairs(areas[name]) do
                    DisableArea(name)
                    area:Remove()
                    Citizen.Wait(10)
                end

                areas[name] = nil
            end
            Citizen.Wait(10)

        end

    elseif count == 1 then

        local name = args[1]

        if areas[name] ~= nil then

            for _, area in pairs(areas[name]) do
                DisableArea(name)
                area:Remove()
                Citizen.Wait(10)
            end

            areas[name] = nil

        end

    end

end

--
-- Set areas values
--
function SetArea(...)

    local args = {...}
    local count = #args

    if count == 1 and type(args[1]) == "table" then

        for name, values in pairs(args[1]) do
            if areas[name] ~= nil then

                local area = Copy(areas[name])
                RemoveArea(name)

                local trigger = values.trigger or area.trigger
                local blip = values.blip or area.blip
                local marker = values.marker or area.marker
                local locations = values.locations or area.locations
                for key, location in pairs(locations) do
                    local newArea = {}
                    newArea.x = location.x
                    newArea.y = location.y
                    newArea.z = location.z
                    newArea.enable = value.enable
                    newArea.blip = Copy(blip)
                    newArea.marker = Copy(marker)
                    newArea.trigger = Copy(trigger)
                    areas[name][key] = area.new(name .. "_" .. key, newArea)
                    Citizen.Wait(10)
                end

            end
            Citizen.Wait(1)
        end

    elseif count == 2 then

        local name = args[1]
        local values = args[2]
        if areas[name] ~= nil then

            local area = Copy(areas[name])
            RemoveArea(name)

            local trigger = values.trigger or area.trigger
            local blip = values.blip or area.blip
            local marker = values.marker or area.marker
            local locations = values.locations or area.locations
            for key, location in pairs(locations) do
                local newArea = {}
                newArea.x = location.x
                newArea.y = location.y
                newArea.z = location.z
                newArea.enable = value.enable
                newArea.blip = Copy(blip)
                newArea.marker = Copy(marker)
                newArea.trigger = Copy(trigger)
                areas[name][key] = area.new(name .. "_" .. key, newArea)
                Citizen.Wait(10)
            end

        end

    end

end
