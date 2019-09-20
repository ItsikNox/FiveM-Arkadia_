Config                      = {}
Config.Locale               = 'fr'

Config.Accounts             = { 'bank', 'black_money' }
Config.AccountLabels        = { bank = _U('bank'), black_money = _U('black_money') }

Config.EnableSocietyPayouts = true -- pay from the society account that the player is employed at? Requirement: esx_society
Config.ShowDotAbovePlayer   = false
Config.DisableWantedLevel   = true
Config.EnableHud            = true -- enable the default hud? Display current job and accounts (black, bank & cash)

Config.PaycheckInterval     = 30 * 60000
Config.MaxPlayers           = GetConvarInt('sv_maxclients', 256) -- set this value to 255 if you're running OneSync

Config.EnableDebug          = false
