Config                            = {}
Config.DrawDistance               = 100.0
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.Locale = 'fr'

Config.Zones = {

	PetrolFarm = {
		Pos   = {x = 592.56, y = 3018.87, z = 41.0},
		Size  = {x = 3.5, y = 3.5, z = 2.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Récolte du Pétrole",
		Type  = 1
	},


	TraitementPetrol = {
		Pos   = {x = 476.84, y = -2166.95, z = 4.96},
		Size  = {x = 3.5, y = 3.5, z = 2.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Transformation du Pétrole",
		Type  = 1
	},

	-- TraitementRaffin = {
		-- Pos   = {x = 2905.59, y = 4348.65, z = 49.32},
		-- Size  = {x = 4.0, y = 4.0, z = 1.0},
		-- Color = {r = 136, g = 243, b = 216},
		-- Name  = "Dillution du Whiskey (2)",
		-- Type  = 1
	-- },
	
	SellFarm = {
		Pos   = {x = 45.5, y = 2789.3, z = 57.89},
		Size  = {x = 1.5, y = 1.5, z = 1.5},
		Color = {r = 255, g = 0, b = 0},
		Name  = "Revente des bidons de pétrole",
		Type  = 29
	},

	FuelerActions = {
		Pos   = {x = -60.03, y = -2518.1, z = 6.41},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Point d'action",
		Type  = 25
	 },
	  
	VehicleSpawner = {
		Pos   = {x = -35.09, y = -2552.81, z = 5.13},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Garage véhicule",
		Type  = 25
	},

	VehicleSpawnPoint = {
		Pos   = {x = -38.6, y = -2538.1, z = 5.02},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Heading = 318.5,
		Type  = 0
	},

	VehicleDeleter = {
		Pos   = {x = -38.6, y = -2538.1, z = 5.02},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Ranger son véhicule",
		Type  = 0
	}

}

---------------------------------
--- Copyright by ikNox#6088 ---
---------------------------------