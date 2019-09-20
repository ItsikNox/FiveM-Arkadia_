Citizen.CreateThread(function()
    while true 
    do        
    	SetWeatherTypePersist("HALLOWEEN")
    	SetWeatherTypeNowPersist("HALLOWEEN")
    	SetWeatherTypeNow("HALLOWEEN")
    	SetOverrideWeather("HALLOWEEN")
    	NetworkOverrideClockTime(0, 00, 00)
    	SetClockTime(0, 0, 0)
    	PauseClock(true)
    	Citizen.Wait(0)
    end
end)