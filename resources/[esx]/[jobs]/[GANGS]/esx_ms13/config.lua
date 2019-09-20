Config                            = {}
Config.MarkerType                 = 0
Config.MarkerSize                 = { x = 0.5, y = 0.5, z = 0.5 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.DrawDistance               = 100.0
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = true
Config.EnableESXIdentity          = false
Config.Locale                     = 'fr'


-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------

----BANDITS
Config.Zones2 = {

  CryptedActions = {
    Pos   = {x = -85.66, y = 834.67, z = 235.91},
    Size  = {x = 1.0, y = 1.0, z = 1.5},
    Color = {r = 204, g = 204, b = 0},
    Type  = 29
  },

  HarvestBandits = {
    Pos   = { x = 998.6886, y = 2895.7155, z = 30.1208 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = -1,
  },
  
  HarvestBandits2 = {
    Pos   = { x = 991.5853, y = 2898.4992, z = 30.1208 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = -1,
  },

  HarvestBandits3 = {
    Pos   = { x = 982.1998, y = 2925.1215, z = 30.1208 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = -1,
  },    

  CraftBandits = {
    Pos   = { x = 976.3430, y = 2923.7038, z = 30.1208 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 27,
  },  

  VehicleBanditsSpawnPoint = {
    Pos   = {x = 1019.0714, y = 2907.7136, z = 40.7725, a = 180.00},
    Size  = {x = 1.5, y = 1.5, z = 1.0},
    Type  = -1
  },

  VehicleDeleter = {
    Pos   = {x = 1037.7847, y = 2917.3496, z = 40.5999},
    Size  = {x = 1.0, y = 1.0, z = 1.0},
    Color = {r = 204, g = 204, b = 0},
    Type  = 30
  }

}

Config.BanditsStations = {

  Bandits = {

    --Blip = {
    --Pos     = { x = -287.638, y = 2535.868, z = 75.701 },
    ----Size    = { x = 1.5, y = 1.5, z = 1.0 },
    ----Sprite  = 60,
    --Display = 4,
    --Scale   = 1.2,
    --Colour  = 29,
    --},

    AuthorizedWeapons = {

    {name = 'WEAPON_FIREEXTINGUISHER', price = 500},          

    },

    Armories = {
      {x = -101.09,   y = 824.24,  z = 235.72},
    },

  },

}

Config.TeleportZonesBandits = {
  EnterBuilding = {
    Pos       = { x = 1015.9669, y = 2906.5332, z = 40.3421 },
    Size      = { x = 1.2, y = 1.2, z = 0.1 },
    Color     = { r = 190, g = 0, b = 0 },
    Marker    = 1,
    Blip      = false,
    Name      = "Bunker : entrée",
    Type      = "teleport",
    Hint      = "Appuyez sur ~INPUT_PICKUP~ pour entrer dans le Bunker.",
    Teleport  = { x = 1009.3440, y = 2905.8632, z = 34.93 },
  },

  ExitBuilding = {
    Pos       = { x = 1009.3440, y = 2905.8632, z = 34.93 },
    Size      = { x = 1.2, y = 1.2, z = 0.1 },
    Color     = { r = 190, g = 0, b = 0 },
    Marker    = 1,
    Blip      = false,
    Name      = "Bunker : sortie",
    Type      = "teleport",
    Hint      = "Appuyez sur ~INPUT_PICKUP~ pour sortir du Bunker.",
    Teleport  = { x = 1015.9669, y = 2906.5332, z = 40.3421 },
  },
}

--------------------------------------------------------
---------------------------------
--- Copyright by ikNox#6088 ---
---------------------------------