Config                            = {}
Config.DrawDistance               = 100.0
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.NPCSpawnDistance           = 500.0
Config.NPCNextToDistance          = 25.0
Config.NPCJobEarnings             = { min = 150, max = 200 }
Config.Locale                     = 'fr'
Config.PrixClip					  = 100

--PRIX CONSTRUCTION ARMES

Config.Price = {

	  weapon_nightstick 	= 51 ,
	  weapon_snspistol		= 52 ,
      weapon_pistol 		= 53 ,
	  weapon_vintagepistol  = 54 ,
	  weapon_combatpistol 	= 55 ,
	  weapon_pistol50 		= 56 ,
	  weapon_heavypistol 	= 57 ,
	  weapon_revolver 		= 58 ,
	  weapon_doubleaction 	= 59 ,
	  weapon_minismg 		= 51 ,
	  weapon_appistol 		= 52 ,
	  weapon_microsmg 		= 150,
	  weapon_marksmanpistol = 54 ,
	  weapon_musket 		= 55 ,
	  weapon_stungun 		= 56 ,
	  weapon_carbinerifle 	= 57 ,
	  weapon_assaultsmg 	= 58 ,
	  weapon_combatpdw 		= 59 ,
	  weapon_smg 			= 51 ,
	  weapon_assaultrifle 	= 52 ,
	  weapon_combatmg 		= 53 ,
	  weapon_assaultshotgun = 54 ,
	  weapon_sawnoffshotgun = 55 ,
	  weapon_sniperrifle 	= 56 ,
	  weapon_marksmanrifle 	= 57 ,
	  weapon_heavysniper 	= 58 ,
}

Config.Zones = {
  AmmunationActions = {
    Pos   = { x = 826.94, y = -2151.82, z = 28.61 },
    Size  = { x = 1.5, y = 1.5, z = 0.25 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 1,
  },

  Matos = {
    Pos   = { x = 1736.262, y = 3327.502, z = 40.2234 },
    Size  = { x = 1.5, y = 1.5, z = 0.25 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 1,
  },
  --- farm munition
  Poudre = { --EST
    Pos   = { x = 2572.25, y = 292.7638, z = 107.7349 },
    Size  = { x = 1.5, y = 1.5, z = 0.25 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 1,
  },
  Douille = {--SANDY SHORE
    Pos   = { x = 1689.718, y = 3757.49, z = 33.7053 },
    Size  = { x = 1.5, y = 1.5, z = 0.25 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 1,
  },
  Revente = {--merryweather
    Pos   = { x = 612.0963, y = -3075.188, z = 5.0692 },
    Size  = { x = 1.5, y = 1.5, z = 0.25 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 1,
  },
--- fin farm munition
  Craft = {--port
    Pos   = { x = 1208.453, y = -3113.833, z = 4.5403 },
    Size  = { x = 1.5, y = 1.5, z = 0.25 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 1,
  },

  VehicleSpawnPoint = {
    Pos   = { x = 821.73, y = -2142.62, z = 27.75 },
    Size  = { x = 1.5, y = 1.5, z = 0.25 },
    Type  = -1,
  },

  VehicleDeleter = {
    Pos   = { x = 821.73, y = -2142.62, z = 27.75 },
    Size  = { x = 3.0, y = 3.0, z = 0.25 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 1,
  }
}