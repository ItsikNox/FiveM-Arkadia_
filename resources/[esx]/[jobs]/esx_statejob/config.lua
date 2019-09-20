Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 25
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = true
Config.MaxInService               = -1
Config.Locale                     = 'fr'
Config.EnableHandcuffTimer        = true -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.StateStations = {

  State = {

    Blip = {
      Pos     = { x = -429.114, y = 1111.057, z = 327.694 },
      Sprite  = 419,
      Display = 4,
      Scale   = 1.2,
--      Colour  = 29,
    },
	
    AuthorizedWeapons = {
      { name = 'WEAPON_FLASHLIGHT',       price = 0 },
	    { name = 'WEAPON_NIGHTSTICK',       price = 0 },
      { name = 'WEAPON_COMBATPISTOL',     price = 0 },
	    { name = 'WEAPON_FIREEXTINGUISHER', price = 0 },
    },

	  AuthorizedVehicles = {
		  { name = 'stretch',  label = 'Sortie VIP' },
		  { name = 'kuruma2',    label = 'Escorte Ville' },
		  { name = 'baller6',   label = 'Escorte Montagne' },
		  { name = 'volatus',      label = 'Transporte Hélico' },
		  { name = 'swift',   label = 'Transporte Hélico' },
		  { name = 'faggio3',   label = 'Détente' },
		  { name = 'dubsta2',       label = 'Sortie Ville/Montagne' },
	  },

    Cloakrooms = {
      { x = 126.29, y = -760.93, z = 241.15 },
	  Heading    = 357.10,
    },

    Armories = {
      { x = 124.15, y = -759.28, z = 241.19},
	  Heading    = 17.57,
    },

    Vehicles = {
      {
        Spawner    = { x = -413.148, y = 1168.581, z = 324.854 },
        SpawnPoint = { x = -408.540, y = 1182.300, z = 324.568 },
        Heading    = 90.0,
      }
    },

    Helicopters = {
      {
        Spawner    = { x = 20.312, y = 535.667, z = 173.627 },
        SpawnPoint = { x = 3.40, y = 525.56, z = 177.919 },
        Heading    = 0.0,
      }
    },

    VehicleDeleters = {
      { x = -421.068, y = 1197.910, z = 324.641 },
    },

    BossActions = {
      { x = 123.88, y = -770.19, z = 241.15 },
	  Heading    = 3.36,
    },

  },
  
}

Config.PublicZones = {
  EnterBuilding = {
    Pos       = { x = -429.612, y = 1109.584, z = 326.682 },
    Size      = { x = 3.0, y = 3.0, z = 0.2 },
    Color     = { r = 64, g = 0, b = 74 },
    Marker    = 1,
    Blip      = false,
    Name      = "Le Maclerait Libéré",
    Type      = "teleport",
    Hint      = "Appuyez sur ~INPUT_PICKUP~ pour entrer dans l'immeuble.",
    Teleport  = { x = 136.3, y =  -761.61, z = 241.19 }
  },

  ExitBuilding = {
    Pos       = { x = 136.3, y = -761.61, z = 241.19 },
    Size      = { x = 3.0, y = 3.0, z = 0.2 },
    Color     = { r = 64, g = 0, b = 74 },
    Marker    = 1,
    Blip      = false,
    Name      = "Le Maclerait Libéré",
    Type      = "teleport",
    Hint      = "Appuyez sur ~INPUT_PICKUP~ pour aller à l'entrée de l'immeuble.",
    Teleport  = { x = -429.612, y = 1109.584, z = 327.682},
  },
 ---------
  EnterBuilding3 = {
    Pos       = { x = 14.081891059875, y = -1105.6704101563, z = 28.797004699707},
    Size      = { x = 1.5, y = 1.5, z = 0.2 },
    Color     = { r = 64, g = 0, b = 74 },
    Marker    = 1,
    Blip      = false,
    Name      = "Le Maclerait Libéré",
    Type      = "teleport",
    Hint      = "Appuyez sur ~INPUT_PICKUP~ pour entrer dans l'immeuble.",
    Teleport  = { x = 12.944341659546, y =  -1109.8620605469, z = 28.797010421753 }
  },

  ExitBuilding3 = {
    Pos       = { x = 13.325618743896, y = -1107.7855224609, z = 28.797010421753 },
    Size      = { x = 1.5, y = 1.5, z = 0.2 },
    Color     = { r = 64, g = 0, b = 74 },
    Marker    = 1,
    Blip      = false,
    Name      = "Le Maclerait Libéré",
    Type      = "teleport",
    Hint      = "Appuyez sur ~INPUT_PICKUP~ pour aller à l'entrée de l'immeuble.",
    Teleport  = { x =15.142413139343, y = -1105.2983398438, z = 28.797008514404},
  },  
  
}

---------------------------------
--- Copyright by ikNox#6088 ---
---------------------------------