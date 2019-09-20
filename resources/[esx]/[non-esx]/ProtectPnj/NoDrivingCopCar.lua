
--[[
----------------------------------------------------------------------------
____________________________________________________________________________

                        AUTHOR : Chubbs

            Désactive la possibilité de conduire des voiture de police si non flic
            simple disable people from driving police cars if not a police


____________________________________________________________________________

---------------------------------------------------------------------------
]]--

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
        if IsPedInAnyPoliceVehicle(GetPlayerPed(PlayerId())) then
            local veh = GetVehiclePedIsUsing(GetPlayerPed(PlayerId()), false)
            if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(PlayerId())) then
                if (PlayerData.job ~= nil and (PlayerData.job.name ~= 'police' or PlayerData.job.name ~= 'ambulance')) then
                  ESX.ShowNotification("Une voiture de police n'est pas réservée aux civils..")
                  SetVehicleUndriveable(veh, true)
                end
            end
        end
    end
end)

---------------------------------
--------- ikNox#6088 ------------
---------------------------------
