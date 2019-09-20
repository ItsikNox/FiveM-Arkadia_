Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        DisablePlayerVehicleRewards(PlayerId())
    end
end)