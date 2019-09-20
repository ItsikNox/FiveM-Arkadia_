Config                = {}
Config.DrawDistance   = 100
Config.Size           = { x = 1.5, y = 1.5, z = 1.5 }
Config.Color          = { r = 0, g = 128, b = 255 }
Config.Type           = 27
Config.Locale = 'fr'
Config.EnableLicense  = true
Config.LicensePrice   = 5000

Config.Zones = {

    GunShop = {
        legal = 0,
        Items = {
			{name  = "WEAPON_FLASHLIGHT", price = 1000, label = "Lampe Torche"},
			{name  = "WEAPON_HAMMER", price = 1500, label = "Marteau"},
			{name  = "WEAPON_CROWBAR", price = 3000, label = "Pied de biche"},
			{name  = "WEAPON_HATCHET", price = 4000, label = "Hache"},
            {name  = "WEAPON_BAT", price = 4500, label = "Batte de Baseball"},
			{name  = "WEAPON_KNUCKLE", price = 5000, label = "Poing Americain"},
			{name  = "WEAPON_KNIFE", price = 5000, label = "Couteau"},
			{name  = "WEAPON_SWITCHBLADE", price = 5000, label = "Couteau à Cran d'Arrêt"},
			{name  = "WEAPON_GOLFCLUB", price = 6000, label = "Club de Gold"},
			{name  = "WEAPON_MACHETE", price = 7500, label = "Machette"},
        },
        Items1 = {
            {name  = "WEAPON_PISTOL", price = 35000, label = "Pistolet 9mm"},
			{name  = "WEAPON_SNSPISTOL", price = 40000, label = "MP-25 (Petit Pistolet"},
			{name  = "WEAPON_HEAVYPISTOL", price = 45000, label = "Colt 1911"},
			{name  = "WEAPON_PISTOL50", price = 50000, label = "Desert Eagle"}
        },
        Items2 = {
			{name  = "WEAPON_SAWNOFFSHOTGUN", price = 0, label = "Sawed-Off (1000$)"},
			{name  = "WEAPON_MICROSMG", price = 0, label = "Mini-Uzi (2000$)"},
			{name  = "WEAPON_SMG", price = 0, label = "MP5 (2500$)"},
			{name  = "WEAPON_HEAVYSHOTGUN", price = 0, label = "Saiga-12 (2500$)"},
			{name  = "WEAPON_COMBATPDW", price = 0, label = "SIG MPX (5000$)"},
			{name  = "WEAPON_COMPACTRIFLE", price = 0, label = "Draco AK (6500$)"},
            {name  = "WEAPON_ASSAULTRIFLE", price = 0, label = "AK-47 (8500$)"},
			{name  = "WEAPON_SPECIALCARBINE", price = 0, label = "G36C (9000$)"},
			{name  = "WEAPON_MG", price = 0, label = "M249 (10000$)"},
			{name  = "WEAPON_GUSENBERG", price = 0, label = "Thompson (15000$)"},
        },
        Pos   = {
            { x = -662.180,   y = -934.961,   z = 20.829 },
            { x = 810.25,     y = -2157.60,   z = 28.62 },
            { x = 1693.44,    y = 3760.16,    z = 33.71 },
            { x = -330.24,    y = 6083.88,    z = 30.45 },
            { x = 252.63,     y = -50.00,     z = 68.94 },
            { x = 22.09,      y = -1107.28,   z = 28.80 },
            { x = 2567.69,    y = 294.38,     z = 107.73 },
            { x = -1117.58,   y = 2698.61,    z = 17.55 },
            { x = 842.44,     y = -1033.42,   z = 27.19 },

        }
    },

    BlackWeashop = {
        legal = 1,
        Items = {},
        Pos   = {
            -- { x = -1306.239,   y = -394.018,  z = 35.695 },
        }
    },

}
