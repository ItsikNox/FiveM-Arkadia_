--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_libs
--

--
-- Get all entities
--
function GetEntities(findFirst, findNext, endFind)

    local entities = {}

    local iter, id = findFirst()
    table.insert(entities, id)

    while true do

        local iter, id = findNext(iter)
        table.insert(entities, id)
        if endFind(iter) == false or id == 0 or not id then
            break
        end
        Citizen.Wait(10)

    end

    return entities

end

--
--  Shape Test Ray
--
function CastRayPlayerPedToPoint(range, type)

    local playerPed = GetPlayerPed()
    local playerCoords = GetPlayerCoords()
    local entityWorld = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, range, 0.0)
    local rayHandle = StartShapeTestRay(playerCoords.x, playerCoords.y, playerCoords.z, entityWorld.x, entityWorld.y, entityWorld.z, type, playerPed, 0)
    local a, b, c, d, entity = GetRaycastResult(rayHandle)
    if entity ~= nil then
        return entity
    end
    return false

end

--
-- Get entity in direction
--
function GetEntityInDirection(range)

    if type(range) ~= "number" then
        range = 20.0
    end
    return CastRayPlayerPedToPoint(range, 10)

end

--
-- Get object in direction
--
function GetEntityObjectInDirection(range)

    if type(range) ~= "number" then
        range = 20.0
    end
    return CastRayPlayerPedToPoint(range, 16)

end

--
-- Get entity in coords
--
function GetEntitiesInArea(settings)

    local settings = settings or {}
    assert(type(settings.entities) == "table", "GetEntitiesInArea : entities must be table")
    assert(type(settings.coords) == "table" or type(settings.coords) == "vector3", "GetEntitiesInArea : coords must be table")
    assert(type(settings.coords.x) == "number", "GetEntitiesInArea : coords x must be number")
    assert(type(settings.coords.y) == "number", "GetEntitiesInArea : coords y must be number")
    assert(type(settings.coords.z) == "number", "GetEntitiesInArea : coords z must be number")

    if type(range) ~= "number" then
        settings.range = 20.0
    end

    local entitiesInArea = {}
    for _, entityId in pairs(settings.entities) do

        if DoesEntityExist(entityId) then
            local entityCoords = GetEntityCoords(entityId)
            local distance = GetDistanceBetween3DCoords(entityCoords.x, entityCoords.y, entityCoords.z, settings.coords.x, settings.coords.y, settings.coords.z)
            if distance <= settings.range then
                table.insert(entitiesInArea, entityId)
            end
        end
        Citizen.Wait(10)

    end
    return entitiesInArea

end

--
--
--
function GetEntitiesInAround(settings)

    local settings = settings or {}
    settings.coords = GetPlayerCoords()
    return GetEntitiesInArea(settings)

end
