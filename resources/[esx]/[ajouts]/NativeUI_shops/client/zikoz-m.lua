local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(0)
    end
end)


_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("","Superette", nil, nil, "shopui_title_conveniencestore", "shopui_title_conveniencestore")
_menuPool:Add(mainMenu)

function AddShopsMenu(menu)
    local shopsmenu = _menuPool:AddSubMenu(menu, "Boissons", nil, nil, "shopui_title_conveniencestore", "shopui_title_conveniencestore")
    
    local shopsmenu2 = _menuPool:AddSubMenu(menu, "Nourritures", nil, nil, "shopui_title_conveniencestore", "shopui_title_conveniencestore")

    local gpsmenu = _menuPool:AddSubMenu(menu, "Divers", nil, nil, "shopui_title_conveniencestore", "shopui_title_conveniencestore")

    local eau = NativeUI.CreateItem("Eau", "")
    shopsmenu.SubMenu:AddItem(eau)
    eau:RightLabel("~g~20$")

    local soda = NativeUI.CreateItem("Soda", "")
    shopsmenu.SubMenu:AddItem(soda)
    soda:RightLabel("~g~30$")

    local cocacola = NativeUI.CreateItem("Coca-Cola", "")
    shopsmenu.SubMenu:AddItem(cocacola)
    cocacola:RightLabel("~g~30$")

    local pain = NativeUI.CreateItem("Pain", "")
    shopsmenu2.SubMenu:AddItem(pain)
    pain:RightLabel("~g~20$")

    local sandwich = NativeUI.CreateItem("Sandwich", "")
    shopsmenu2.SubMenu:AddItem(sandwich)
    sandwich:RightLabel("~g~35$")

    local hamburger = NativeUI.CreateItem("Hamburger", "")
    shopsmenu2.SubMenu:AddItem(hamburger)
    hamburger:RightLabel("~g~30$")

    local cupcake = NativeUI.CreateItem("CupCake", "")
    shopsmenu2.SubMenu:AddItem(cupcake)
    cupcake:RightLabel("~g~30$")

    local chocolat = NativeUI.CreateItem("Barre de Chocolat", "")
    shopsmenu2.SubMenu:AddItem(chocolat)
    chocolat:RightLabel("~g~45$")

    local hamburgerplate = NativeUI.CreateItem("Hamburger aux boulettes de viande", "")
    shopsmenu2.SubMenu:AddItem(hamburgerplate)
    hamburgerplate:RightLabel("~g~55$")

    local breadsaucisson = NativeUI.CreateItem("HotDog", "")
    shopsmenu2.SubMenu:AddItem(breadsaucisson)
    breadsaucisson:RightLabel("~g~55$")

    local beef = NativeUI.CreateItem("Morceau de Boeuf", "")
    shopsmenu2.SubMenu:AddItem(beef)
    beef:RightLabel("~g~55$")

    local gps = NativeUI.CreateItem("GPS", "")
    gpsmenu.SubMenu:AddItem(gps)
    gps:RightLabel("~g~500$")

    local tel = NativeUI.CreateItem("Téléphone", "")
    gpsmenu.SubMenu:AddItem(tel)
    tel:RightLabel("~g~1500$")

    local sim = NativeUI.CreateItem("Carte SIM", "")
    gpsmenu.SubMenu:AddItem(sim)
    sim:RightLabel("~g~500$")


    shopsmenu.SubMenu.OnItemSelect = function(menu, item)
    if item == eau then
            TriggerServerEvent('buyEau')
            ESX.ShowNotification('Vous avez payez ~r~20$')
            Citizen.Wait(1)
            ESX.ShowAdvancedNotification("Superette", "Vous avez acheter de l'~b~eau", "", "CHAR_LAZLOW2", 1)
        elseif item == cocacola then
            TriggerServerEvent('buyCocaCola')
            ESX.ShowNotification('Vous avez payez ~r~30$')
            Citizen.Wait(1)
            ESX.ShowAdvancedNotification("Superette", "Vous avez acheter une bouteille de ~b~Coca-Cola", "", "CHAR_LAZLOW2", 1)
        elseif item == soda then
            TriggerServerEvent('buySoda')
            ESX.ShowNotification('Vous avez payez ~r~30$')
            Citizen.Wait(1)
            ESX.ShowAdvancedNotification("Superette", "Vous avez acheter un ~b~Soda", "", "CHAR_LAZLOW2", 1)
        end
    end
    
    shopsmenu2.SubMenu.OnItemSelect = function(menu, item)
    if item == pain then
            TriggerServerEvent('buyPain')
            ESX.ShowNotification('Vous avez payez ~r~20$')
            Citizen.Wait(1)
            ESX.ShowAdvancedNotification("Superette", "Vous avez acheter du ~b~pain", "", "CHAR_LAZLOW2", 1)
    elseif item == sandwich then
            TriggerServerEvent('buySandwich')
            ESX.ShowNotification('Vous avez payez ~r~35$')
            Citizen.Wait(1)
            ESX.ShowAdvancedNotification("Superette", "Vous avez acheter un ~b~sandwich", "", "CHAR_LAZLOW2", 1)
    elseif item == hamburger then
            TriggerServerEvent('buyHamburger')
            ESX.ShowNotification('Vous avez payez ~r~30$')
            Citizen.Wait(1)
            ESX.ShowAdvancedNotification("Superette", "Vous avez acheter un ~b~hamburger", "", "CHAR_LAZLOW2", 1)
    elseif item == cupcake then
            TriggerServerEvent('buyCupCake')
            ESX.ShowNotification('Vous avez payez ~r~35$')
            Citizen.Wait(1)
            ESX.ShowAdvancedNotification("Superette", "Vous avez acheter un ~b~CupCake", "", "CHAR_LAZLOW2", 1)
    elseif item == chocolat then
            TriggerServerEvent('buyChocolat')
            ESX.ShowNotification('Vous avez payez ~r~45$')
         Citizen.Wait(1)
         ESX.ShowAdvancedNotification("Superette", "Vous avez acheter une ~b~Barre de Chocolat", "", "CHAR_LAZLOW2", 1)
    elseif item == hamburgerplate then
            TriggerServerEvent('buyHamburgerPlate')
            ESX.ShowNotification('Vous avez payez ~r~55$')
         Citizen.Wait(1)
         ESX.ShowAdvancedNotification("Superette", "Vous avez acheter un ~b~Hamburger aux boulettes de viande", "", "CHAR_LAZLOW2", 1)
   elseif item == breadsaucisson then
            TriggerServerEvent('buyBreadSaucisson')
            ESX.ShowNotification('Vous avez payez ~r~55$')
         Citizen.Wait(1)
         ESX.ShowAdvancedNotification("Superette", "Vous avez acheter un ~b~HotDog", "", "CHAR_LAZLOW2", 1)
   elseif item == beef then
            TriggerServerEvent('buyBeef')
            ESX.ShowNotification('Vous avez payez ~r~55$')
         Citizen.Wait(1)
         ESX.ShowAdvancedNotification("Superette", "Vous avez acheter un ~b~Morceau de Boeuf", "", "CHAR_LAZLOW2", 1)
    end
end

    gpsmenu.SubMenu.OnItemSelect = function(menu, item)
    if item == gps then
        TriggerServerEvent('buyGPS')
        ESX.ShowNotification('Vous avez payez ~r~35$')
        Citizen.Wait(1)
        ESX.ShowAdvancedNotification("Superette", "Vous avez acheter un ~b~GPS", "", "CHAR_LAZLOW2", 1)
    elseif item == tel then
        TriggerServerEvent('buyTel')
        ESX.ShowNotification('Vous avez payez ~r~55$')
        Citizen.Wait(1)
        ESX.ShowAdvancedNotification("Superette", "Vous avez acheter un ~b~Téléphone", "", "CHAR_LAZLOW2", 1)
    elseif item == sim then
        TriggerServerEvent('buySim')
        ESX.ShowNotification('Vous avez payez ~r~55$')
        Citizen.Wait(1)
        ESX.ShowAdvancedNotification("Superette", "Vous avez acheter une ~b~Carte SIM", "", "CHAR_LAZLOW2", 1)
        end
    end
end





AddShopsMenu(mainMenu)
_menuPool:RefreshIndex()

local zikoz = {
    {x = 25.742, y = -1345.741, z = 28.57},
    {x = 373.875,   y = 325.896,  z = 102.66},
	{x = 2557.458,  y = 382.282,  z = 107.722}, 
	{x = -3038.939, y = 585.954,  z = 6.97},
	{x = -3241.927, y = 1001.462, z = 11.850}, 
	{x = 547.431,   y = 2671.710, z = 41.176}, 
	{x = 1961.464,  y = 3740.672, z = 31.363}, 
	{x = 2678.916,  y = 3280.671, z = 54.261}, 
    {x = 1729.216,  y = 6414.131, z = 34.057}, 
    {x = 1135.808,  y = -982.281,  z = 45.45}, 
	{x = -1222.93, y = -906.99,  z = 11.35}, 
	{x = -1487.553, y = -379.107,  z = 39.163}, 
	{x = -2968.243, y = 390.910,   z = 14.054}, 
	{x = 1166.024,  y = 2708.930,  z = 37.167}, 
	{x = 1392.562,  y = 3604.684,  z = 33.995}, 
	{x = -1393.409, y = -606.624,  z = 29.319}, 
    {x = -1037.618,  y = -2737.399,   z = 19.169}, 
    {x = -48.519,   y = -1757.514, z = 28.47}, 
	{x = 1163.373,  y = -323.801,  z = 68.27}, 
	{x = -707.67,  y = -914.22,  z = 18.26}, 
	{x = -1820.523, y = 792.518,   z = 137.20},
	{x = 1698.388,  y = 4924.404,  z = 41.083}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        _menuPool:MouseEdgeEnabled (false);

        for k in pairs(zikoz) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, zikoz[k].x, zikoz[k].y, zikoz[k].z)

            if dist <= 1.2 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour parlez avec le ~b~vendeur")
				if IsControlJustPressed(1,51) then 
                    mainMenu:Visible(not mainMenu:Visible())
				end
            end
        end
    end
end)

Drawing = setmetatable({}, Drawing)
Drawing.__index = Drawing

function Drawing.draw3DText(x,y,z,textInput,fontId,scaleX,scaleY,r, g, b, a)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*14
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(r, g, b, a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+1, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        local coords = GetEntityCoords(GetPlayerPed(-1))

		for k,v in pairs(zikoz) do
				if(Config.Type ~= -1 and GetDistanceBetweenCoords(coords, zikoz[k].x, zikoz[k].y, zikoz[k].z, true) < Config.DrawDistance) then
                    Drawing.draw3DText(zikoz[k].x, zikoz[k].y, zikoz[k].z, "Appuyez sur [~g~E~w~] pour faire vos achats", 4, 0.1, 0.05, 255, 255, 255, 255)
                    DrawMarker(Config.Type, zikoz[k].x, zikoz[k].y, zikoz[k].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
			end
		end
	end
end)

local blips = {
    {title="Epicerie", colour=4, id=52, x = 25.742, y = -1345.741, z = 28.497},
    {title="Epicerie", colour=4, id=52, x = 373.875, y = -1345.741, z = 28.497},
    {title="Epicerie", colour=4, id=52, x = 2557.458, y = 382.282, z = 107.622},
    {title="Epicerie", colour=4, id=52, x = -3038.939, y = 585.954, z = 6.97},
    {title="Epicerie", colour=4, id=52, x = -3241.927, y = 1001.462, z = 11.850},
    {title="Epicerie", colour=4, id=52, x = 547.431, y = 2671.710, z = 41.176},
    {title="Epicerie", colour=4, id=52, x = 1961.464, y = 3740.672, z = 31.363},
    {title="Epicerie", colour=4, id=52, x = 2678.916, y = 3280.671, z = 54.261},
    {title="Epicerie", colour=4, id=52, x = 1729.216, y = 6414.131, z = 34.057},
    {title="Epicerie", colour=4, id=52, x = 1135.808, y = -982.281, z = 45.45},
    {title="Epicerie", colour=4, id=52, x = -1222.93, y = -906.99, z = 11.35},
    {title="Epicerie", colour=4, id=52, x = -1487.553, y = -379.107, z = 39.163},
    {title="Epicerie", colour=4, id=52, x = -2968.243, y = 390.910, z = 14.054},
    {title="Epicerie", colour=4, id=52, x = 1166.024, y = 2708.930, z = 37.167},
    {title="Epicerie", colour=4, id=52, x = 1392.562, y = 3604.684, z = 33.995},
    {title="Epicerie", colour=4, id=52, x = -1393.409, y = -606.624, z = 29.319},
    {title="Epicerie", colour=4, id=52, x = -1037.618, y = -2737.399, z = 19.169},
    {title="Epicerie", colour=4, id=52, x = -48.519, y = -1757.514, z = 28.47},
    {title="Epicerie", colour=4, id=52, x = 1163.373, y = -323.801, z = 68.27},
    {title="Epicerie", colour=4, id=52, x = -707.67, y = -914.22, z = 18.26},
    {title="Epicerie", colour=4, id=52, x = -1820.523, y = 792.518, z = 137.20},
    {title="Epicerie", colour=4, id=52, x = 1698.388, y = 4924.404, z = 41.083},
}

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 0.9)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("mp_m_shopkeep_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVMALE", "mp_m_shopkeep_01", 24.129, -1345.156, 28.497, 266.946, true, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
end)

---------------------------------
--------- ikNox#6088 ------------
---------------------------------