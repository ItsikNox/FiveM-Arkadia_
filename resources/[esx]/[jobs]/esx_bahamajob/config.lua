Config                            = {}
Config.DrawDistance               = 100.0

Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.EnableVaultManagement      = true
Config.EnableHelicopters          = false
Config.EnableMoneyWash            = true
Config.MaxInService               = -1
Config.Locale = 'fr'

Config.MissCraft                  = 10 -- %


Config.AuthorizedVehicles = {
    { name = 'burrito4',  label = 'Van Bahama Mamas' },
}

Config.Blips = {
    
    Blip = {
      Pos     = { x = -1393.7309570313, y = -605.35540771484, z = 29.31955909729 },
      Sprite  = 93,
      Display = 4,
      Scale   = 1.2,
      Colour  = 27,
    },

}

Config.Zones = {

    Cloakrooms = {
        Pos   = { x = -1389.5947265625, y = -591.4619140625, z = 29.319549560547 },
        Size  = { x = 1.2, y = 1.2, z = 0.1 },
        Color = { r = 255, g = 187, b = 255 },
        Type  = 1,
    },

    Vaults = {
        Pos   = { x = 0, y = 0, z = 0 },
        Size  = { x = 1.2, y = 1.2, z = 0.1 },
        Color = { r = 30, g = 144, b = 255 },
        Type  = 1,
    },

    Fridge = {
        Pos   = { x = -1391.3155517578, y = -604.97479248047, z = 29.319574356079 },
        Size  = { x = 1.2, y = 1.2, z = 0.1 },
        Color = { r = 248, g = 248, b = 255 },
        Type  = 1,
    },

    Vehicles = {
       Pos          = { x = -1424.361, y = -649.065, z = 27.673 },
       SpawnPoint   = { x = -1406.291, y = -638.359, z = 27.673 },
       Size         = { x = 1.8, y = 1.8, z = 1.0 },
       Color        = { r = 255, g = 255, b = 0 },
       Type         = 1,
       Heading      = 207.43,
    },

    VehicleDeleters = {
       Pos   = { x = -1395.168, y = -652.800, z = 27.673 },
       Size  = { x = 3.0, y = 3.0, z = 0.2 },
       Color = { r = 238, g = 0, b = 0 },
       Type  = 1,
    },

--[[
    Helicopters = {
        Pos          = { x = 137.177, y = -1278.757, z = 28.371 },
        SpawnPoint   = { x = 138.436, y = -1263.095, z = 28.626 },
        Size         = { x = 1.8, y = 1.8, z = 1.0 },
        Color        = { r = 255, g = 255, b = 0 },
        Type         = 23,
        Heading      = 207.43,
    },

    HelicopterDeleters = {
        Pos   = { x = 133.203, y = -1265.573, z = 28.396 },
        Size  = { x = 3.0, y = 3.0, z = 0.2 },
        Color = { r = 255, g = 255, b = 0 },
        Type  = 1,
    },
]]--

    BossActions = {
        Pos   = { x = -1371.6560058594, y = -626.09912109375, z = 29.819578170776 },
        Size  = { x = 1.2, y = 1.2, z = 0.1 },
        Color = { r = 0, g = 100, b = 0 },
        Type  = 1,
    },

-----------------------
-------- SHOPS --------

    Flacons = {
        Pos   = { x = -1386.850, y = -608.666, z = 29.319},
        Size  = { x = 1.2, y = 1.2, z = 0.1 },
        Color = { r = 238, g = 0, b = 0 },
        Type  = 1,
        Items = {
            { name = 'jager',      label = _U('jager'),   price = 3 },
            { name = 'vodka',      label = _U('vodka'),   price = 10 },
            { name = 'rhum',       label = _U('rhum'),    price = 15 },
            { name = 'whisky',     label = _U('whisky'),  price = 24 },
            { name = 'tequila',    label = _U('tequila'), price = 5 },
            { name = 'martini',    label = _U('martini'), price = 5 }
        },
    },

    NoAlcool = {
        Pos   = { x = -1391.054, y = -601.015, z = 29.319 },
        Size  = { x = 1.2, y = 1.2, z = 0.1 },
        Color = { r = 238, g = 110, b = 0 },
        Type  = 1,
        Items = {
            { name = 'soda',        label = _U('soda'),     price = 4 },
            { name = 'coffee',      label = _U('coffee'),     price = 4 },
            { name = 'jusfruit',    label = _U('jusfruit'), price = 4 },
            { name = 'icetea',      label = _U('icetea'),   price = 4 },
            { name = 'energy',      label = _U('energy'),   price = 7 },
            { name = 'drpepper',    label = _U('drpepper'), price = 5 },
            { name = 'limonade',    label = _U('limonade'), price = 4 }
        },
    },

    Apero = {
        Pos   = {x = -1377.093, y = -629.866, z = 29.819},
        Size  = { x = 1.2, y = 1.2, z = 0.1 },
        Color = { r = 142, g = 125, b = 76 },
        Type  = 1,
        Items = {
            { name = 'bolcacahuetes',   label = _U('bolcacahuetes'),    price = 10 },
            { name = 'bolnoixcajou',    label = _U('bolnoixcajou'),     price = 15 },
            { name = 'bolpistache',     label = _U('bolpistache'),      price = 20 },
            { name = 'bolchips',        label = _U('bolchips'),         price = 30 },
            { name = 'saucisson',       label = _U('saucisson'),        price = 35 },
            { name = 'grapperaisin',    label = _U('grapperaisin'),     price = 20 }
        },
    },

    Ice = {
        Pos   = {x = -1374.305, y = -628.153, z = 29.819},
        Size  = { x = 1.2, y = 1.2, z = 0.1 },
        Color = { r = 255, g = 255, b = 255 },
        Type  = 1,
        Items = {
            { name = 'ice',     label = _U('ice'),      price = 1 },
            { name = 'menthe',  label = _U('menthe'),   price = 2 }
        },
    },

}


-----------------------
----- TELEPORTERS -----

Config.TeleportZones = {
  EnterBuilding = {
    Pos       = { x = -1389.1306152344, y = -585.53326416016, z = 29.219818115234 },
    Size      = { x = 1.2, y = 1.2, z = 0.1 },
    Color     = { r = 128, g = 128, b = 128 },
    Marker    = 1,
    Hint      = _U('e_to_enter_1'),
    Teleport  = { x = -1387.0266113281, y = -588.84320068359, z = 29.319498062134 }
  },

  ExitBuilding = {
   Pos       = { x = -1387.0266113281, y = -588.84320068359, z = 29.319498062134 },
   Size      = { x = 1.2, y = 1.2, z = 0.1 },
   Color     = { r = 128, g = 128, b = 128 },
   Marker    = 1,
   Hint      = _U('e_to_exit_1'),
   Teleport  = { x = -1389.1306152344, y = -585.53326416016, z = 29.219818115234 },
  },

  Entercomptoir = {
    Pos       = { x = -1386.0063476563, y = -627.18792724609, z = 29.81957244873 },
    Size      = { x = 1.2, y = 1.2, z = 0.1 },
    Color     = { r = 128, g = 128, b = 128 },
    Marker    = 1,
    Hint      = _U('e_to_enter_2'),
    Teleport  = { x = -1385.5007324219, y = -606.47601318359, z = 29.319551467896 },
  },

  Exitcomptoir = {
    Pos       = { x = -1385.5007324219, y = -606.47601318359, z = 29.319551467896 },
    Size      = { x = 1.2, y = 1.2, z = 0.1 },
    Color     = { r = 128, g = 128, b = 128 },
    Marker    = 1,
    Hint      = _U('e_to_exit_2'),
    Teleport  = { x = -1386.0063476563, y = -627.18792724609, z = 29.81957244873 },
  },

  EnterVIP = {
    Pos       = { x = -1381.7054443359, y = -632.19689941406, z = 29.81957244873 },
    Size      = { x = 1.2, y = 1.2, z = 0.1 },
    Color     = { r = 128, g = 128, b = 128 },
    Marker    = 1,
    Hint      = _U('e_to_enter_3'),
    Teleport  = { x = -1379.71875, y = -631.39099121094, z = 29.81957244873 },
  },

  ExitVIP = {
    Pos       = { x = -1379.71875, y = -631.39099121094, z = 29.81957244873 },
    Size      = { x = 1.2, y = 1.2, z = 0.1 },
    Color     = { r = 128, g = 128, b = 128 },
    Marker    = 1,
    Hint      = _U('e_to_exit_3'),
    Teleport  = { x = -1381.7054443359, y = -631.39099121094, z = 29.81957244873 },
  },

--[[
  EnterHeliport = {
    Pos       = { x = 126.843, y = -729.012, z = 241.201 },
    Size      = { x = 2.0, y = 2.0, z = 0.2 },
    Color     = { r = 204, g = 204, b = 0 },
    Marker    = 1,
    Hint      = _U('e_to_enter_2),
    Teleport  = { x = -65.944, y = -818.589, z =  320.801 }
  },

  ExitHeliport = {
    Pos       = { x = -67.236, y = -821.702, z = 320.401 },
    Size      = { x = 2.0, y = 2.0, z = 0.2 },
    Color     = { r = 204, g = 204, b = 0 },
    Marker    = 1,
    Hint      = _U('e_to_exit_2'),
    Teleport  = { x = 124.164, y = -728.231, z = 241.801 },
  },
]]--
}

---------------------------------
--- Copyright by ikNox#6088 ---
---------------------------------