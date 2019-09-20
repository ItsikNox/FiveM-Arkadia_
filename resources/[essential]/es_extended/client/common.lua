AddEventHandler('esx:getSharedObject', function(cb)
	cb(ESX)
end)

function getSharedObject()
	return ESX
end

--ikNox#6088