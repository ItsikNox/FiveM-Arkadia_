Citizen.CreateThread(function()
    while true do
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.3) --Dégat Cout de poigs
    N_0x4757f00bc6323cfe(-1553120962, 0.2) --Dégat Véhicule
	Wait(0)
    end
end)


----------------------------------------------------------------------------
--Désactive le cout de crosse
----------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
	local ped = PlayerPedId()
        if IsPedArmed(ped, 6) then
	       DisableControlAction(1, 140, true)
       	   DisableControlAction(1, 141, true)
           DisableControlAction(1, 142, true)
        end
    end
end)

---------------------------------
--------- ikNox#6088 ------------
---------------------------------