Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)

	SetWeatherTypePersist("XMAS")
	SetWeatherTypeNowPersist("XMAS")
	SetWeatherTypeNow("XMAS")
	SetOverrideWeather("XMAS")
	SetForceVehicleTrails(true)
	SetForcePedFootstepsTracks(true)

	SetWind(1.0)
	SetWindSpeed(11.99)
	SetWindDirection(180.00)

  end
end)
