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

function recxup()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, _)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end
_menuPool = NativeUI.CreatePool()
_menuPool:RefreshIndex()
ESX                           = nil
local GUI                     = {}
GUI.Time                      = 0
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local HasPayed                = true
local menuLoaded = false
local HairLoaded = false

local Colors = {
    {22, 19, 19}, -- 0
    {30, 28, 25}, -- 1
    {76, 56, 45}, -- 2
    {69, 34, 24}, -- 3
    {123, 59, 31}, -- 4
    {149, 68, 35}, -- 5
    {165, 87, 50}, -- 6
    {175, 111, 72}, -- 7
    {159, 105, 68}, -- 8
    {198, 152, 108}, -- 9
    {213, 170, 115}, -- 10
    {223, 187, 132}, -- 11
    {202, 164, 110}, -- 12
    {238, 204, 130}, -- 13
    {229, 190, 126}, -- 14
    {250, 225, 167}, -- 15
    {187, 140, 96}, -- 16
    {163, 92, 60}, -- 17
    {144, 52, 37}, -- 18
    {134, 21, 17}, -- 19
    {164, 24, 18}, -- 20
    {195, 33, 24}, -- 21
    {221, 69, 34}, -- 22
    {229, 71, 30}, -- 23
    {208, 97, 56}, -- 24
    {113, 79, 38}, -- 25
    {132, 107, 95}, -- 26
    {185, 164, 150}, -- 27
    {218, 196, 180}, -- 28
    {247, 230, 217}, -- 29
    {102, 72, 93}, -- 30
    {162, 105, 138}, -- 31
    {171, 174, 11}, -- 32
    {239, 61, 200}, -- 33
    {255, 69, 152}, -- 34
    {255, 178, 191}, -- 35
    {12, 168, 146}, -- 36
    {8, 146, 165}, -- 37
    {11, 82, 134}, -- 38
    {118, 190, 117}, -- 39
    {52, 156, 104}, -- 40
    {22, 86, 85}, -- 41
    {152, 177, 40}, -- 42
    {127, 162, 23}, -- 43
    {241, 200, 98}, -- 44
    {238, 178, 16}, -- 45
    {224, 134, 14}, -- 46
    {247, 157, 15}, -- 47
    {243, 143, 16}, -- 48
    {231, 70, 15}, -- 49
    {255, 101, 21}, -- 50
    {254, 91, 34}, -- 51
    {252, 67, 21}, -- 52
    {196, 12, 15}, -- 53
    {143, 10, 14}, -- 54
    {44, 27, 22}, -- 55
    {80, 51, 37}, -- 56
    {98, 54, 37}, -- 57
    {60, 31, 24}, -- 58
    {69, 43, 32}, -- 59
    {8, 10, 14}, -- 60
    {212, 185, 158}, -- 61
    {212, 185, 158}, -- 62
    {213, 170, 115}, -- 63
}
Citizen.CreateThread(function()

	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

end)

local barberShops = nil
function OpenBarber()
	recxup()
	TriggerEvent("Parow:exit")
	if menuLoaded == false then
		barberShops = NativeUI.CreateMenu("", "Coiffeur", 5, 100,"shopui_title_barber3","shopui_title_barber3",true)
		_menuPool:Add(barberShops)
		OpenShopMenuS(barberShops)
		menuLoaded = true
		barberShops:Visible(not barberShops:Visible())
		_menuPool:RefreshIndex()
	else
		barberShops:Visible(not barberShops:Visible())
	end


end
	
function OpenShopMenuS(menu)
	local chev = _menuPool:AddSubMenu(menu, "Coiffure","",true,true,true)
	local barb = _menuPool:AddSubMenu(menu, "Barbes","",true,true,true)
	local maq = _menuPool:AddSubMenu(menu, "Maquillage","",true,true,true)

	BarbeMenuFct(barb)
	MakeupMenuFct(maq)
	HairCutMenuFct(chev)
end
function MakeupMenuFct(menu)
	ppp = {
		GetLabelText("CC_MKUP_0"),
		GetLabelText("CC_MKUP_1"),
		GetLabelText("CC_MKUP_2"),
		GetLabelText("CC_MKUP_3"),
		GetLabelText("CC_MKUP_4"),
		GetLabelText("CC_MKUP_5"),
		GetLabelText("CC_MKUP_6"),
		GetLabelText("CC_MKUP_7"),
		GetLabelText("CC_MKUP_8"),
		GetLabelText("CC_MKUP_9"),
		GetLabelText("CC_MKUP_10"),
		GetLabelText("CC_MKUP_11"),
		GetLabelText("CC_MKUP_12"),
		GetLabelText("CC_MKUP_13"),
		GetLabelText("CC_MKUP_14"),
		GetLabelText("CC_MKUP_15"),
		GetLabelText("CC_MKUP_16"),
		GetLabelText("CC_MKUP_17"),
		GetLabelText("CC_MKUP_18"),
		GetLabelText("CC_MKUP_19"),
		GetLabelText("CC_MKUP_20"),
		GetLabelText("CC_MKUP_21"),
		GetLabelText("CC_MKUP_26"),
		GetLabelText("CC_MKUP_27"),
		GetLabelText("CC_MKUP_28"),
		GetLabelText("CC_MKUP_29"),
		GetLabelText("CC_MKUP_30"),
		GetLabelText("CC_MKUP_31"),
		GetLabelText("CC_MKUP_32"),
		GetLabelText("CC_MKUP_33"),
		GetLabelText("CC_MKUP_34"),
		GetLabelText("CC_MKUP_35"),
		GetLabelText("CC_MKUP_36"),
		GetLabelText("CC_MKUP_37"),
		GetLabelText("CC_MKUP_38"),
		GetLabelText("CC_MKUP_39"),
		GetLabelText("CC_MKUP_40"),
		GetLabelText("CC_MKUP_41"),
		GetLabelText("CC_MKUP_42"),
		GetLabelText("CC_MKUP_43"),
		GetLabelText("CC_MKUP_44"),
		GetLabelText("CC_MKUP_45"),
		GetLabelText("CC_MKUP_46"),
		GetLabelText("CC_MKUP_47"),
		GetLabelText("CC_MKUP_48"),
		GetLabelText("CC_MKUP_49"),
		GetLabelText("CC_MKUP_50"),
		GetLabelText("CC_MKUP_51"),
		GetLabelText("CC_MKUP_52"),
		GetLabelText("CC_MKUP_53"),
		GetLabelText("CC_MKUP_54"),
		GetLabelText("CC_MKUP_55"),
		GetLabelText("CC_MKUP_56"),
		GetLabelText("CC_MKUP_57"),
		GetLabelText("CC_MKUP_58"),
		GetLabelText("CC_MKUP_59"),
		GetLabelText("CC_MKUP_60"),
		GetLabelText("CC_MKUP_61"),
		GetLabelText("CC_MKUP_62"),
		GetLabelText("CC_MKUP_63"),
		GetLabelText("CC_MKUP_64"),
		GetLabelText("CC_MKUP_65"),
		GetLabelText("CC_MKUP_66"),
		GetLabelText("CC_MKUP_67"),
		GetLabelText("CC_MKUP_68"),
		GetLabelText("CC_MKUP_69"),
		GetLabelText("CC_MKUP_70"),
		GetLabelText("CC_MKUP_71")
	
	
	}
	local makeupSelect = NativeUI.CreateListItem("Maquillage", ppp, 0)
	local makeupBaseColor = NativeUI.CreateColourPanel("Couleur du maquillage", Colors)
	local makeupHighColor = NativeUI.CreateColourPanel("Seconde couleur du maquillage", Colors)
		local makeupOpacity = NativeUI.CreatePercentagePanel("0%", "Opacity du maquillage", "100%")

		makeupSelect:AddPanel(makeupOpacity)
        makeupSelect:AddPanel(makeupBaseColor)
        makeupSelect:AddPanel(makeupHighColor)
        makeupOpacity:Percentage(0.0)
		menu:AddItem(makeupSelect)
		pp = {}
		djkq = NativeUI.CreateItem("~g~Valider","")
		djkq:RightLabel("50$")
		menu:AddItem(djkq)
        makeupSelect.OnListChanged = function(_, SelectedItem, Index)
            local ActiveItem = SelectedItem:IndexToItem(Index)
			skin32 = Index-1
			playerPed = GetPlayerPed(-1)
            skin33 = (ActiveItem.Panels and ActiveItem.Panels[1] or 0.0)
            skin34 = (ActiveItem.Panels and ActiveItem.Panels[2] or 1) - 1
			skin35 = (ActiveItem.Panels and ActiveItem.Panels[3] or 1) - 1
			SetPedHeadOverlay(playerPed, 4, skin32, skin33)
			SetPedHeadOverlayColor  (playerPed, 4, 1, skin34,      skin35)

			pp = {skin32,skin33,skin34,skin35}
        end
		menu.OnItemSelect = function(_, _, _)
            
			ESX.TriggerServerCallback("Parow:GetCoiffeurMontant", function(result)
				if result then
					TriggerEvent('skinchanger:getSkin', function(skin)
						skin.makeup_1 = pp[1]
						skin.makeup_2 = pp[2]
						skin.makeup_3 = pp[3]
						skin.makeup_4 = pp[4]
						TriggerServerEvent('esx_skin:save', skin)
						ESX.ShowNotification("~g~Nouveau maquillage acheté 50$")
					end)
	   
				else
					ESX.ShowNotification("~r~Pas assez d'argent")
				end
			end)
		end
end


function BarbeMenuFct(menu)
	p = {"Barbe de 3 jours","Bouc","Mamène","Bouc Style","Menton","Petite Barbe","Collier","Mal Rasé","D'Artagnan","Moustache","Garnis","Mal Rasée 2","Bouc 2","Collier 2","Collier Prononcé","Collier Tracé","Innovant","Rouflak","Prisonnier","Mexicano","Mexicano  Fournis","Mexicano Imposant","Mexicano Tombant","Mexicano Classe","Mexicano Garnis","Biker","Rouflak Chargée","Biker Chargée","Barbu"}
	local beardSelect = NativeUI.CreateListItem("Beard", p, 0)
	local beardOpacity = NativeUI.CreatePercentagePanel("0%", "Longueur", "100%")
	local beardBaseColor = NativeUI.CreateColourPanel("Couleur de la barbe", Colors)
	local beardHighColor = NativeUI.CreateColourPanel("Deuxième couleur de la barbe", Colors)
	beardSelect:AddPanel(beardOpacity)
	beardOpacity:Percentage(0.0)
	beardSelect:AddPanel(beardBaseColor)
	beardSelect:AddPanel(beardHighColor)
	menu:AddItem(beardSelect)
	djkq = NativeUI.CreateItem("~g~Valider","")
	djkq:RightLabel("50$")
	menu:AddItem(djkq)
	pp = {}
	beardSelect.OnListChanged = function(_, SelectedItem, Index)
		local ActiveItem = SelectedItem:IndexToItem(Index)
		playerPed = GetPlayerPed(-1)
		skin33 = (ActiveItem.Panels and ActiveItem.Panels[1] or 0.0)
		skin34 = (ActiveItem.Panels and ActiveItem.Panels[2] or 1) - 1
		skin35 = (ActiveItem.Panels and ActiveItem.Panels[3] or 1) - 1

		SetPedHeadOverlay(playerPed, 1, Index - 1, skin33)
		SetPedHeadOverlayColor(playerPed, 1, 1, skin34,skin35)

		pp = {Index - 1,skin33,skin34,skin35}
	end
	menu.OnItemSelect = function(_, _, _)
            
		ESX.TriggerServerCallback("Parow:GetCoiffeurMontant", function(result)
			if result then
				TriggerEvent('skinchanger:getSkin', function(skin)
					skin.beard_1 = pp[1]
					skin.beard_2 = pp[2]
					skin.beard_3 = pp[3]
					skin.beard_4 = pp[4]
					TriggerServerEvent('esx_skin:save', skin)
					ESX.ShowNotification("~g~Nouvelle barbe acheté 50$")
				end)
   
			else
				ESX.ShowNotification("~r~Pas assez d'argent")
			end
		end)
	end
end
function HairCutMenuFct(menu)
    if IsPedMale(PlayerPedId()) then
        hairstyles = { GetLabelText("CC_M_HS_0"),GetLabelText("CC_M_HS_1"), GetLabelText("CC_M_HS_2"), GetLabelText("CC_M_HS_3"), GetLabelText("CC_M_HS_4"),
                       GetLabelText("CC_M_HS_5"), GetLabelText("CC_M_HS_6"), GetLabelText("CC_M_HS_7"),
                       GetLabelText("CC_M_HS_8"), GetLabelText("CC_M_HS_9"), GetLabelText("CC_M_HS_10"),
                       GetLabelText("CC_M_HS_11"), GetLabelText("CC_M_HS_12"), GetLabelText("CC_M_HS_13"),
                       GetLabelText("CC_M_HS_14"), GetLabelText("CC_M_HS_15"), GetLabelText("CC_M_HS_16"),
                       GetLabelText("CC_M_HS_17"), GetLabelText("CC_M_HS_18"), GetLabelText("CC_M_HS_19"),
                       GetLabelText("CC_M_HS_20"), GetLabelText("CC_M_HS_21"), GetLabelText("CC_M_HS_22")
                    }
    else
        hairstyles = { GetLabelText("CC_F_HS_0"),GetLabelText("CC_F_HS_1"), GetLabelText("CC_F_HS_2"), GetLabelText("CC_F_HS_3"),
                       GetLabelText("CC_F_HS_4"), GetLabelText("CC_F_HS_5"), GetLabelText("CC_F_HS_6"),
                       GetLabelText("CC_F_HS_7"), GetLabelText("CC_F_HS_8"), GetLabelText("CC_F_HS_9"),
                       GetLabelText("CC_F_HS_10"), GetLabelText("CC_F_HS_11"), GetLabelText("CC_F_HS_12"),
                       GetLabelText("CC_F_HS_13"), GetLabelText("CC_F_HS_14"), GetLabelText("CC_F_HS_15"),
                       GetLabelText("CC_F_HS_16"), GetLabelText("CC_F_HS_17"), GetLabelText("CC_F_HS_18"),
                       GetLabelText("CC_F_HS_19"), GetLabelText("CC_F_HS_20"), GetLabelText("CC_F_HS_21"),
                       GetLabelText("CC_F_HS_22"), GetLabelText("CC_F_HS_23")
                   }
	end
	

	local hairSelect = NativeUI.CreateListItem("Coiffure", hairstyles, 0)
	local hairBaseColor = NativeUI.CreateColourPanel("Couleur", Colors)
	local hairHighColor = NativeUI.CreateColourPanel("Deuxième couleur", Colors)
	hairSelect:AddPanel(hairBaseColor)
	hairSelect:AddPanel(hairHighColor)
	menu:AddItem(hairSelect)

	djkq = NativeUI.CreateItem("~g~Valider","")
	djkq:RightLabel("50$")
	menu:AddItem(djkq)
	pp = {}
	hairSelect.OnListChanged = function(_, SelectedItem, Index)
            
		local ActiveItem = SelectedItem:IndexToItem(Index)
		print(ActiveItem.Value)

		skin33 = (ActiveItem.Panels and ActiveItem.Panels[1] or 1) - 1
		skin44 = (ActiveItem.Panels and ActiveItem.Panels[2] or 1) - 1
		SetPedComponentVariation(GetPlayerPed(-1), 2, Index-1)
		SetPedHairColor(GetPlayerPed(-1),skin33,skin44)
		pp = {Index-1,skin33,skin44}
	end
	menu.OnItemSelect = function(_, SelectedItem, Index)
            
		ESX.TriggerServerCallback("Parow:GetCoiffeurMontant", function(result)
			if result then
				TriggerEvent('skinchanger:getSkin', function(skin)
					--(json.encode(skin))
					skin.hair_1 = pp[1]
					skin.hair_color_1 = pp[2]
					skin.hair_color_2 = pp[3]
					TriggerServerEvent('esx_skin:save', skin)
					ESX.ShowNotification("~g~Nouvelle coupe de cheveux acheté 50$")
				end)
   
			else
				ESX.ShowNotification("~r~Pas assez d'argent")
			end
		end)
	end
	
	menu.OnMenuClosed = function()
		recxup()
	end
end

AddEventHandler('esx_barbershop:hasEnteredMarker', function(_)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu'
	CurrentActionData = {}
end)

AddEventHandler('esx_barbershop:hasExitedMarker', function(_)
	
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil

	if not HasPayed  then

		TriggerEvent('esx_skin:getLastSkin', function(skin)
			TriggerEvent('skinchanger:loadSkin', skin)
		end)

	end


end)

-- Create Blips
Citizen.CreateThread(function()
	
	for i=1, #ConfigBarber.Shops, 1 do
		
		local blip = AddBlipForCoord(ConfigBarber.Shops[i].x, ConfigBarber.Shops[i].y, ConfigBarber.Shops[i].z)

		SetBlipSprite (blip, 71)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.0)
		SetBlipColour (blip, 51)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Coiffeur")
		EndTextCommandSetBlipName(blip)
	end

end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		_menuPool:ProcessMenus()
		Wait(0)
		
		local coords = GetEntityCoords(GetPlayerPed(-1))
		
		for _,v in pairs(ConfigBarber.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < ConfigBarber.DrawDistance) then
				Drawing.draw3DText(v.Pos.x, v.Pos.y, v.Pos.z, "Appuyez sur [~r~E~w~] pour changer votre coiffure", 4, 0.1, 0.05, 255, 255, 255, 255)
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end
		end

	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		
		Wait(1000)
		
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(ConfigBarber.Zones) do
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
				isInMarker  = true
				currentZone = k
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('esx_barbershop:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_barbershop:hasExitedMarker', LastZone)
		end

	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		if CurrentAction ~= nil then

			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 0, -1)

			if IsControlPressed(0,  Keys['E']) and (GetGameTimer() - GUI.Time) > 300 then
				
				if CurrentAction == 'shop_menu' then
					

					OpenBarber()
					
				end

				--CurrentAction = nil
				GUI.Time      = GetGameTimer()
				
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

---------------------------------
--------- ikNox#6088 ------------
---------------------------------