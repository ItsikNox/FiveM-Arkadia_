TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local places ={}

function joueurs(ped)

	local players = GetPlayers()
	for k,v in pairs(players) do
		print (v)
		TriggerClientEvent('esx_unishow:StopDance',v,ped)
	end
end
RegisterServerEvent('esx_unishow:RegisterShow')
AddEventHandler('esx_unishow:RegisterShow',function(param)
	print (param.label)
	table.insert(places,{
		label = param.label,
		ped   = param.ped
		})	
end)


RegisterServerEvent('esx_unishow:DeleteShow')
AddEventHandler('esx_unishow:DeleteShow',function(label)
	for i=1,#places do
		if places[i].label == label then
			ped = places[i].ped
			joueurs(ped)
			table.remove(places,i)		
		end
	end
end)