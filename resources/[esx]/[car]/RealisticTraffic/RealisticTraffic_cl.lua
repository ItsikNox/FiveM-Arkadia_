-- Traffic density parameters
local vehRoadDensity = 0.65
local vehParkedDensity = 0.8

-- Main thread
Citizen.CreateThread(function()
	while true do
        -- Loop forever and update every frame
	    Citizen.Wait(0)
        
        -- Set vehicle density
	    SetVehicleDensityMultiplierThisFrame(vehRoadDensity)
	    SetParkedVehicleDensityMultiplierThisFrame(vehParkedDensity)
	end
end)
