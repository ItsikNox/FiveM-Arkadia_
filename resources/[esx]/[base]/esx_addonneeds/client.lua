------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------- Authors Morow https://github.com/Morow73 --------------------------------------------
ESX          = nil
local IsDead = false




AddEventHandler('esx_addonneeds:resetStatus', function()
	TriggerEvent('esx_status:set', 'force', 50000) 

end)


AddEventHandler('playerSpawned', function()

	if IsDead then
		TriggerEvent('esx_addonneeds:resetStatus')
	end

	IsDead = false
end)

AddEventHandler('esx_status:loaded', function(status)

   TriggerEvent('esx_status:registerStatus', 'force', 0, ' 	#D500FF', ----- jaune 
	 	function(status)
			return true
		end,
		function(status)
			status.remove(0)
		end
    )
	
	
   Citizen.CreateThread(function()
	    while true do
	        Wait(1000)
	        TriggerEvent('esx_status:getStatus', 'force', function(status)
                if status.val <= 0 then    
                    StatSetInt(GetHashKey('MP0_STAMINA'), 0, true)
                    StatSetInt(GetHashKey('MP0_STRENGTH'), 0, true)
                    StatSetInt(GetHashKey('MP0_WHEELIE_ABILITY'), 0, true)
                    StatSetInt(GetHashKey('MP0_FLYING_ABILITY'), 0, true)
                    StatSetInt(GetHashKey('MP0_SHOOTING_ABILITY'), 0, true)
                    StatSetInt(GetHashKey('MP0_STEALTH_ABILITY'), 0, true)
                elseif status.val >= 250000 then
                    StatSetInt(GetHashKey('MP0_STAMINA'), 25, true)
                    StatSetInt(GetHashKey('MP0_STRENGTH'), 25, true)
                    StatSetInt(GetHashKey('MP0_WHEELIE_ABILITY'), 25, true)
                    StatSetInt(GetHashKey('MP0_FLYING_ABILITY'), 25, true)
                    StatSetInt(GetHashKey('MP0_SHOOTING_ABILITY'), 25, true)
                    StatSetInt(GetHashKey('MP0_STEALTH_ABILITY'), 25, true)
                elseif status.val >= 500000 then
                    StatSetInt(GetHashKey('MP0_STAMINA'), 50, true)
                    StatSetInt(GetHashKey('MP0_STRENGTH'), 50, true)
                    StatSetInt(GetHashKey('MP0_WHEELIE_ABILITY'), 50, true)
                    StatSetInt(GetHashKey('MP0_FLYING_ABILITY'), 50, true)
                    StatSetInt(GetHashKey('MP0_SHOOTING_ABILITY'), 50, true)
                    StatSetInt(GetHashKey('MP0_STEALTH_ABILITY'), 50, true)    
                elseif status.val >= 750000 then
                    StatSetInt(GetHashKey('MP0_STAMINA'), 75, true)
                    StatSetInt(GetHashKey('MP0_STRENGTH'), 75, true)
                    StatSetInt(GetHashKey('MP0_WHEELIE_ABILITY'), 75, true)
                    StatSetInt(GetHashKey('MP0_FLYING_ABILITY'), 75, true)
                    StatSetInt(GetHashKey('MP0_SHOOTING_ABILITY'), 75, true)
                    StatSetInt(GetHashKey('MP0_STEALTH_ABILITY'), 75, true)      
                elseif status.val == 100000 then
                    StatSetInt(GetHashKey('MP0_STAMINA'), 100, true)
                    StatSetInt(GetHashKey('MP0_STRENGTH'), 100, true)
                    StatSetInt(GetHashKey('MP0_WHEELIE_ABILITY'), 100, true)
                    StatSetInt(GetHashKey('MP0_FLYING_ABILITY'), 100, true)
                    StatSetInt(GetHashKey('MP0_SHOOTING_ABILITY'), 100, true)
                    StatSetInt(GetHashKey('MP0_STEALTH_ABILITY'), 100, true)    
                end 
            end)
        end
    end)
end)	





