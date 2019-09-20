-- Vehicles to enable/disable air control
local vehicleClassDisableControl = {
    [0] = true,     --compacts
    [1] = true,     --sedans
    [2] = true,     --SUV's
    [3] = true,     --coupes
    [4] = true,     --muscle
    [5] = true,     --sport classic
    [6] = true,     --sport
    [7] = true,     --super
    [8] = false,    --motorcycle
    [9] = true,     --offroad
    [10] = true,    --industrial
    [11] = true,    --utility
    [12] = true,    --vans
    [13] = false,   --bicycles
    [14] = false,   --boats
    [15] = false,   --helicopter
    [16] = false,   --plane
    [17] = true,    --service
    [18] = true,    --emergency
    [19] = false    --military
}

-- Main thread
Citizen.CreateThread(function()
    while true do
        -- Loop forever and update every frame
        Citizen.Wait(0)

        -- Get player, vehicle and vehicle class
        local player = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(player, false)
        local vehicleClass = GetVehicleClass(vehicle)

        -- Disable control if player is in the driver seat and vehicle class matches array
        if ((GetPedInVehicleSeat(vehicle, -1) == player) and vehicleClassDisableControl[vehicleClass]) then
            -- Check if vehicle is in the air and disable L/R and UP/DN controls
            if IsEntityInAir(vehicle) then
                DisableControlAction(2, 59)
                DisableControlAction(2, 60)
            end
        end
    end
end)
