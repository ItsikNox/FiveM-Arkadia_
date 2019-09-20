--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_libs
--

--
-- Get all peds
--
function GetPeds()

  return GetEntities(FindFirstPed, FindNextPed, EndFindPed)

end

--
-- Get ped in direction
--
function GetPedInDirection(range)

    if type(range) ~= "number" then
        range = 20.0
    end
    local entity = GetEntityInDirection(range)
    if DoesEntityExist(entity) then
        if GetEntityType(entity) == 1 then
            return entity
        end
    end
    return false

end

--
-- Get peds in area
--
function GetPedsInArea(settings)

    local settings = settings or {}
    settings.entities = GetPeds()
    return GetEntitiesInArea(settings)

end

--
-- Get peds in around
--
function GetPedsInAround(settings)

    local settings = settings or {}
    settings.entities = GetPeds()
    local pedsInAround = GetEntitiesInAround(settings)

    -- Remove player ped
    local playerPed = GetPlayerPed()
    local key = TableContainsValue(pedsInAround, playerPed)
    if key ~= false then
        table.remove(pedsInAround, key)
    end

    return pedsInAround

end
