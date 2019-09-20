local Entities = {}

function RegisterEntity(entity)

	table.insert(Entities, {
		id     = entity,
		hash   = GetEntityModel(entity),
		data   = {}
	})

end

function SetEntityData(entity, key, val)

	for i=1, #Entities, 1 do
		if Entities[i].id == entity then
			Entities[i].data[key] = val
			break
		end
	end

end

AddEventHandler('entitysync:registerEntity', function(entity)
	NetworkRequestControlOfEntity(entity)
	SetEntityAsMissionEntity(entity, true, true)
	RegisterEntity(entity)
end)

RegisterNetEvent('entitysync:setEntityData')
AddEventHandler('entitysync:setEntityData', function(entity, key, val)
	SetEntityData(entity, key, val)
end)


RegisterNetEvent('entitysync:getEntities')
AddEventHandler('entitysync:getEntities', function(requestId)

	for i=1, #Entities, 1 do
		local coords = GetEntityCoords(Entities[i].id)
		Entities[i].coords = {x = coords.x, y = coords.y, z = coords.z}
	end

	TriggerServerEvent('entitysync:onEntities', requestId, Entities)
end)

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1)

		for i=1, #Entities, 1 do
			if not DoesEntityExist(Entities[i].id) then
				table.remove(Entities, i)
				break
			end
		end

	end
end)

--ikNox#6088