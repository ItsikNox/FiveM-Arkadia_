--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_libs
--

--
-- Get all vehicles
--
function GetVehicles()

  return GetEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)

end

--
-- Get vehicle in direction
--
function GetVehicleInDirection(range)

    if type(range) ~= "number" then
        range = 20.0
    end
    local entity = GetEntityInDirection(range)
    if DoesEntityExist(entity) then
        if GetEntityType(entity) == 2 then
            return entity
        end
    end
    return false

end

--
-- Get vehicles in area
--
function GetVehiclesInArea(settings)

    local settings = settings or {}
    settings.entities = GetVehicles()
    return GetEntitiesInArea(settings)

end

--
-- Get vehicles in around
--
function GetVehiclesInAround(settings)

    local settings = settings or {}
    settings.entities = GetVehicles()
    return GetEntitiesInAround(settings)

end
