Config                   = {}

--GENERAL
Config.Lang              = 'fr'    --Set lang (fr-en)
Config.permission        = "mod" --Permission need to use FiveM-BanSql commands (mod-admin-superadmin)
Config.MultiServerSync   = false   --This will check if a ban is add in the sql all 30 second, use it only if you have more then 1 server (true-false)


--WEBHOOK
Config.EnableDiscordLink = false --Turn this true if you want link the log to a discord (true-false)
Config.webhookban        = "https://discordapp.com/api/webhooks/473571126690316298/oJZBU9YLz9ksOCG_orlf-wpMZ2pkFedfpEsC34DN_iHO0CBBp6X06W3mMJ2RvMMK7vIO"
Config.webhookunban      = "https://discordapp.com/api/webhooks/473571126690316298/oJZBU9YLz9ksOCG_orlf-wpMZ2pkFedfpEsC34DN_iHO0CBBp6X06W3mMJ2RvMMK7vIO"


--LANGUAGE
Config.TextFr = {
	start         = "La BanList et l'historique a ete charger avec succes",
	starterror    = "ERROR : La BanList ou l'historique n'a pas ete charger nouvelle tentative.",
	banlistloaded = "La BanList a ete charger avec succes.",
	historyloaded = "La BanListHistory a ete charger avec succes.",
	loaderror     = "ERROR : La BanList n a pas été charger.",
	noreason      = "Raison Inconnue",
	during        = " pendant : ",
	noresult      = "Il n'y a pas autant de résultats !",
	isban         = " a été ban",
	isunban       = " a été déban",
	invalidsteam  =  "Vous devriez ouvrir steam",
	invalidid     = "ID du joueur incorrect",
	invalidname   = "Le nom n'est pas valide",
	invalidtime   = "Duree du ban incorrecte",
	yourban       = "Vous avez ete ban pour : ",
	yourpermban   = "Vous avez ete ban permanant pour : ",
	youban        = "Vous avez banni : ",
	forr          = " jours. Pour : ",
	permban       = " de facon permanente pour : ",
	timeleft      = ". Il reste : ",
	toomanyresult = "Trop de résultats, veillez être plus précis.",
	day           = " Jours ",
	hour          = " Heures ",
	minute        = " Minutes ",
	by            = "par",
	ban           = "Bannir un joueurs qui est en ligne",
	banoff        = "Bannir un joueurs qui est hors ligne",
	bansearch     = "Trouver l'id permanant d'un joueur qui est hors ligne",
	dayhelp       = "Nombre de jours",
	reason        = "Raison du ban",
	permid        = "Trouver l'id permanant avec la commande (sqlsearch)",
	history       = "Affiche tout les bans d'un joueur",
	reload        = "Recharge la BanList et la BanListHistory",
	unban         = "Retirez un ban de la liste",
	steamname     = "(Nom Steam)",
}


Config.TextEn = {
	start         = "The BanList and history has been loaded successfully.",
	starterror    = "ERROR: The BanList and history has not been loaded new try.",
	banlistloaded = "The BanList has been loaded successfully.",
	historyloaded = "The BanListHistory has been loaded successfully.",
	loaderror     = "ERROR: The BanList was not loaded.",
	noreason      = "unknown reason",
	during        = " during : ",
	noresult      = "There are not as many results!",
	isban         = " was ban",
	isunban       = " was unban",
	invalidsteam  = "You should open steam",
	invalidid     = "Player ID incorrect",
	invalidname   = "The name is not valid",
	invalidtime   = "Bad ban duration",
	yourban       = "You have been ban for : ",
	yourpermban   = "You have been ban permanent for : ",
	youban        = "You have ban : ",
	forr          = " days. For : ",
	permban       = " permanently for : ",
	timeleft      = ". Time remains : ",
	toomanyresult = "Too many results, be sure to be more precise.",
	day           = " Days ",
	hour          = " Hours ",
	minute        = " Minutes ",
	by            = "by",
	ban           = "Ban one online player",
	banoff        = "Ban one offline player",
	bansearch     = "Find perm id of an offline player",
	dayhelp       = "Number of day",
	reason        = "Reason of ban",
	permid        = "Find perm id with command (sqlsearch)",
	history       = "Show all ban of a player",
	reload        = "Reload BanList and BanListHistory",
	unban         = "Remove one ban from the list",
	steamname     = "(Steam Name)",
}
