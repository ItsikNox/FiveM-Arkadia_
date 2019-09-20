Config	=	{}

Config.CheckOwnership = false -- If true, Only owner of vehicle can store items in trunk.
Config.AllowPolice = true -- If true, police will be able to search players' trunks.

Config.Locale   = 'fr'

 -- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.Limit = 25000

-- Default weight for an item:
	-- weight == 0 : The item do not affect character inventory weight
	-- weight > 0 : The item cost place on inventory
	-- weight < 0 : The item add place on inventory. Smart people will love it.
Config.DefaultWeight = 1000

Config.localWeight = {

    black_money = 1, -- poids pour un argent
	-- Drogue
	coke = 9999999999,
	opium = 9999999999,
	meth = 9999999999,
	weed = 9999999999,
	coke_pooch = 9999999999,
	opium_pooch = 9999999999,
	meth_pooch = 9999999999,
	weed_pooch = 9999999999,
	lsd = 9999999999,
	lsd_pooch = 99999999,
	fish = 1,
	-- Armes
	WEAPON_SNIPERRIFLE = 1, -- poids pour une munnition
	WEAPON_ASSAULTSMG = 1, -- poids pour une munnition
	WEAPON_ASSAULTSHOTGUN = 1, -- poids pour une munnition
	WEAPON_PISTOL = 1,
	WEAPON_SNSPISTOL = 1,
	WEAPON_FLASHLIGHT = 1,
	WEAPON_MACHETE = 1,
	WEAPON_BAT = 1,
	WEAPON_STUNGUN = 1,
	WEAPON_FIREEXTINGUISHER = 1,
	WEAPON_BALL = 1,
	WEAPON_ASSAULTRIFLE = 1,
	WEAPON_FLAREGUN = 1,
	WEAPON_APPISTOL = 1,
	WEAPON_SWITCHBLADE = 1,
	WEAPON_REVOLVER = 1,
	WEAPON_POOLCUE = 1,
	WEAPON_SMG = 1,
	WEAPON_PISTOL50 = 1,
	WEAPON_MICROSMG = 1,
	WEAPON_GUSENBERG = 1,
	WEAPON_SAWNOFFSHOTGUN = 1,
	WEAPON_COMBATPISTOL = 1,
	WEAPON_SPECIALCARBINE = 1,
	WEAPON_PUMPSHOTGUN = 1,
	WEAPON_CARBINERIFLE = 1,
	WEAPON_SMOKEGRENADE = 1,
	GADGET_PARACHUTE = 1,
	WEAPON_SPECIALCARBINE_MK2 = 1,
	WEAPON_BULLPUPRIFLE_MK2 = 1,
	WEAPON_PUMPSHOTGUN_MK2 = 1,
	WEAPON_MARKSMANRIFLE_MK2 = 1,
	WEAPON_ASSAULTRIFLE_MK2 = 1,
	WEAPON_CARBINERIFLE_MK2 = 1,
	WEAPON_COMBATMG_MK2 = 1,
	WEAPON_HEAVYSNIPER_MK2 = 1,
	WEAPON_PISTOL_MK2 = 1,
	WEAPON_SMG_MK2 = 1,
	fabric = 150,
	hacktool = 150,
	acetone = 150,
	lithium = 150,
	methlab = 150,
	fish = 150,
	fish_traiter = 150,
	meat = 150,
	whool = 150,
	poulet_grille = 150,
	-- Nourritures + Boissons
	bread = 300,
	water = 300,
	jusfruit = 300,
	cola = 300,	
	icetea = 300,
	chocolate = 300,
	beef = 300,
	hamburger = 300,
	cupcake = 300,
	soda = 300,
	cocacola = 300,
	pizza = 300,
	bolchips = 300,
	drpepper = 300,
	mixapero = 300,
	saucisson = 300,
	breadsaucisson = 300,
	hamburgerplate = 300,
	bolcacahuetes = 300,
	bolnoixcajou = 300,
	bolpistache = 300,
	-- Abatteur
	alive_chicken = 1166,
	slaughtered_chicken = 1166,
	packaged_chicken = 1166,
	-- Couturier
	wool = 500,
	clothe = 500,
	-- Bucherons
	wood = 2666,
	cutted_wood = 2666,
	packaged_plank = 2666,
	-- Mineur
	stone = 2666,
	washed_stone = 2666,
	gold = 2666,
	iron = 2666,
	diamond = 2666,
	copper = 2666,
	--
	essence = 300,
	clip = 300,
	repairkit = 300,
	nitrotune = 300,
	nitrobottle = 300,
	weedseed = 300,
	fertilizer = 300,
	weedlamp = 300,
	-- Vignerons
	grapperaisin = 300,
	raisin = 300,	
	jus_raisin = 300,
	vine = 300,
	grand_cru = 300,
	-- Item
	brolly = 150,		
	bong = 150,		
	rose = 10,			
	notepad = 10,				
	-- RAFFINEUR
	petrol = 300,
	petrol_raffin = 300,
	essence1 = 300,
	-- Tabagiste
	malbora = 500,
	gitanes = 500,
	tabacblond = 500,
	tabacblondsec = 500,
	tabacbrun = 500,
	tabacbrunsec = 500,
	-- Pompiste
	papier = 500,
	billet = 500,
}

Config.VehicleLimit = {
    [0] = 30000, --Compact
    [1] = 40000, --Sedan
    [2] = 100000, --SUV
    [3] = 40000, --Coupes
    [4] = 40000, --Muscle
    [5] = 25000, --Sports Classics
    [6] = 40000, --Sports
    [7] = 5000, --Super
    [8] = 0, --Motorcycles
    [9] = 150000, --Off-road
    [10] = 800000, --Industrial
    [11] = 100000, --Utility
    [12] = 150000, --Vans
    [13] = 0, --Cycles
    [14] = 100000, --Boats
    [15] = 0, --Helicopters
    [16] = 0, --Planes
    [17] = 40000, --Service
    [18] = 350000, --Emergency
    [19] = 0, --Military
    [20] = 350000, --Commercial
    [21] = 0, --Trains

}

Config.VehicleModel = {

    brickade    = 800000, --Commercial
    rallytruck  = 800000, --Commercial
    armarello  = 800000, --Commercial
    hauler  = 1000000, --Commercial
    ramvan  = 1000000, --Commercial
    phantom  = 800000, --Bucherons
    phantomhd  = 800000, --Commercial
    vnl780  = 800000, --Commercial
    guardian    = 350000, --Vans
	stockade    = 350000, --Vans
	speedo    = 350000, --Vans
	rubble    = 800000,
	youga2    = 150000, --Couturier
	benson    = 350000, --Abatteur

}

Config.VehiclePlate = {
	taxi        = "TAXI",
	cop         = "LSPD",
	ambulance   = "EMS0",
	mecano	    = "MECA",
}

---------------------------------
--- Copyright by ikNox#6088 ---
---------------------------------