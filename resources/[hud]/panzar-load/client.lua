-- Variable to check if native has already been run
local Ran = false

-- Wait until client is loaded into the map
AddEventHandler("onClientMapStart", function ()
	-- If not already ran
	if not Ran then
		-- Close loading screen resource
		ShutdownLoadingScreenNui()
		-- Set as ran
		Ran = true
	end
end)