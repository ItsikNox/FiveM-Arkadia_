ESX               = nil
local RequestId   = -1
local RequestData = {}
local Replies     = {}
local Players     = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountPlayers()

	local count = 0

	for k,v in pairs(Players) do
		count = count + 1
	end

	return count

end

function GetDistanceBetweenCoords(coords1, coords2)

	return math.sqrt(
		(coords2.x - coords1.x) * (coords2.x - coords1.x) +
		(coords2.y - coords1.y) * (coords2.y - coords1.y) +
		(coords2.z - coords1.z) * (coords2.z - coords1.z)
	)

end

function GetEntities(cb)

	RequestId              = RequestId + 1
	RequestData[RequestId] = {}
	Replies[RequestId]     = 0
	local playerCount      = CountPlayers()

	TriggerClientEvent('entitysync:getEntities', -1, RequestId)

	CreateThread(function()

		local startTime = os.time()

		while os.time() - startTime < 10 and Replies[RequestId] < playerCount do
			Citizen.Wait(1)
		end

		cb(RequestData[RequestId])

	end)

end

function GetClosestEntity(coords, radius, cb)

	GetEntities(function(entities)

		local closestEntity   = -1
		local closestDistance = -1

	  for i=1, #entities, 1 do

      local distance = GetDistanceBetweenCoords(coords, entities[i].coords)

      if closestDistance == -1 or closestDistance > distance then
        closestEntity   = entities[i]
        closestDistance = distance
      end

	  end

	  cb(closestEntity, closestDistance)

	end)

end

function GetEntitiesInArea(coords, radius, cb)

	GetEntities(function(entities)

		local foundEntities = {}

	  for i=1, #entities, 1 do

      local distance = GetDistanceBetweenCoords(coords, entities[i].coords)

      if distance <= radius then
      	table.insert(foundEntities, {
      		distance = distance,
      		entity   = entities[i]
      	})
      end

	  end

	  table.sort(foundEntities, function(a, b)
	  	return a.distance < b.distance
	  end)

	  cb(foundEntities)

	end)

end

RegisterServerEvent('entitysync:onEntities')
AddEventHandler('entitysync:onEntities', function(requestId, entities)

	local _source = source

	for i=1, #entities, 1 do
		entities[i].source = _source 
		table.insert(RequestData[RequestId], entities[i])
	end

	Replies[RequestId] = Replies[RequestId] + 1

end)

RegisterServerEvent('entitysync:setEntityData')
AddEventHandler('entitysync:setEntityData', function(targetSource, id, key, val)
	TriggerClientEvent('entitysync:setEntityData', targetSource, id, key, val)
end)

ESX.RegisterServerCallback('entitysync:getEntities', function(source, cb)
	GetEntities(cb)
end)


ESX.RegisterServerCallback('entitysync:getClosestEntity', function(source, cb, coords, radius)
	GetClosestEntity(coords, radius, cb)
end)

ESX.RegisterServerCallback('entitysync:getEntitiesInArea', function(source, cb, coords, radius)
	GetEntitiesInArea(coords, radius, cb)
end)

local players = GetPlayers()

for i=1, #players, 1 do
	Players[players[i]] = true
end

AddEventHandler('esx:playerLoaded', function(source)
	Players[source] = true
end)

AddEventHandler('esx:playerDropped', function(source)
	Players[source] = nil
end)