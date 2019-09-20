Citizen.CreateThread(function()
	LoadInterior(GetInteriorAtCoords(440.84, -983.14, 30.69))
end)

Citizen.CreateThread(function()
    while (true) do
        ClearAreaOfPeds(440.84, -983.14, 30.69, 300, 1)
        Citizen.Wait(0)
    end
end)