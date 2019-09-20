local isUiOpen = false 
local isTalking = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isTalking == false then
			if NetworkIsPlayerTalking(PlayerId()) then
				isTalking = true
				SendNUIMessage({
            	   displayWindow = 'true'
            	   })
                isUiOpen = true 	
			end
		else
			if NetworkIsPlayerTalking(PlayerId()) == false then
				isTalking = false
				SendNUIMessage({
				   displayWindow = 'false'
				   })
				isUiOpen = true
			end
		end
	end
end)