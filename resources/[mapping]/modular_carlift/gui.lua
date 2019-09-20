GUI = {}
Menu = {}
Menus = {}

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

GUI.maxVisOptions = 7
GUI.optionText = {255, 255, 255, 255, 0}
GUI.subText = {255, 255, 255, 255, 0}
GUI.subRect = {0, 0, 0, 230}
GUI.optionRect = {0, 0, 0, 170}
GUI.scroller = {230, 230, 230, 255}
optionTextSize = {0.35, 0.35}
optionRectSize = {0.225, 0.035}
menuX = 0.1126
menuXOption = 0.11
menuXOtherOption = 0.1
titleTextSize = {0.85, 0.80}
GUI.titleText = {255, 255, 255, 255, 4}
menuYModify = 0.035
menuYOptionDiv = 3.98
menuYOptionAdd = 0.11
menuYSubRect = 0.03496
local menuOpen = false
prevMenu = nil
curMenu = nil
selectPressed = false
currentOption = 1
local optionCount = 0

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function Menu.IsOpen() 
	return menuOpen == true
end

function Menu.SetupMenu(menu, title)
	Menus[menu] = {}
	Menus[menu].title = title
	Menus[menu].optionCount = 0
	Menus[menu].options = {}
	Menus[menu].previous = nil
end

function Menu.addOption(menu, option)
	if not (Menus[menu].title == nil) then
		Menus[menu].optionCount = Menus[menu].optionCount + 1
		Menus[menu].options[Menus[menu].optionCount] = option
	end
end

function Menu.Switch(prevmenu, menu)
  curMenu = menu
  prevMenu = prevmenu
  if Menus[menu] then
    if Menus[menu].optionCount then
      if Menus[menu].optionCount < currentOption then
        currentOption = Menus[menu].optionCount
        if currentOption == 0 then
          currentOption = 1
        end
      end
    end
  end
  if prevmenu ~= nil and menu ~= "" then
    Menus[menu].previous = prevmenu
  end
end

function Menu.DisplayCurMenu()
	if not (curMenu == "") then
		menuOpen = true
		Menu.Title(Menus[curMenu].title)
		for k,v in pairs(Menus[curMenu].options) do
			v()
		end
		Menu.updateSelection()
	end
end

function GUI.Text(text, color, position, size, center)
	local correction = ((1.0 - round(GetSafeZoneSize(), 2)) * 100) * 0.005
	
	SetTextCentre(center)
	SetTextColour(color[1], color[2], color[3], color[4])
	SetTextFont(color[5])
	SetTextScale(size[1], size[2])
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(correction + position[1], correction + position[2])
end

function GUI.Rect(color, position, size)
    local correction = ((1.0 - round(GetSafeZoneSize(), 2)) * 100) * 0.005
	
	DrawRect(correction + position[1], correction + position[2], size[1], size[2], color[1], color[2], color[3], color[4])
end

function GUI.Spriter(Streamedtexture, textureName, x, y, width, height, rotation, r, g, b, a)
    local correction = ((1.0 - round(GetSafeZoneSize(), 2)) * 100) * 0.005
	
	if not HasStreamedTextureDictLoaded(Streamedtexture) then
		RequestStreamedTextureDict(Streamedtexture, false)
	else
		DrawSprite(Streamedtexture, textureName, correction + x, correction + y, width, height, rotation, r, g, b, a)
	end
end

function Menu.Title()
	local menu_title = Language[Config.Locale]['menu_title']

	GUI.Text(menu_title, GUI.subText, {menuX - menuXOption, (optionCount) * 0.035 + 0.097 }, optionTextSize, false)
	GUI.Rect(GUI.subRect, { menuX, (optionCount) * 0.035 + 0.110 }, optionRectSize)
	
	GUI.Spriter("shopui_title_supermod", "shopui_title_supermod", menuX, 0.045, 0.225, 0.095, 0.0, 255, 255, 255, 255)
end

function Menu.Option(option)
	optionCount = optionCount + 1
	
	local thisOption = nil
	
	if (currentOption == optionCount) then
		thisOption = true
	else
		thisOption = false
	end
	
	if thisOption then
		GUI.optionText = {0, 0, 0, 255, 0}
    else
        GUI.optionText = {255, 255, 255, 255, 0}
    end
	
	if(currentOption <= GUI.maxVisOptions and optionCount <= GUI.maxVisOptions) then
		GUI.Text(option, GUI.optionText, {menuX - menuXOption, (optionCount) * 0.035 + 0.097 }, optionTextSize, false)
		GUI.Rect(GUI.optionRect, { menuX, (optionCount) * 0.035 + 0.110 }, optionRectSize)
		if(thisOption) then
			GUI.Spriter("commonmenu", "gradient_nav", menuX, (optionCount) * 0.035 + 0.110, 0.225, 0.035, 0.0, 230, 230, 230, 255)
		end
	elseif (optionCount > currentOption - GUI.maxVisOptions and optionCount <= currentOption) then
		GUI.Text(option, GUI.optionText, {menuX - menuXOption, (optionCount - (currentOption - GUI.maxVisOptions)) * 0.035 + 0.097},  optionTextSize, false)
		GUI.Rect(GUI.optionRect, { menuX, (optionCount - (currentOption - GUI.maxVisOptions)) * 0.035 + 0.110 }, optionRectSize)
		if(thisOption) then
			GUI.Spriter("commonmenu", "gradient_nav", menuX, (optionCount - (currentOption - GUI.maxVisOptions)) * 0.035 + 0.110, 0.225, 0.035, 0.0, 230, 230, 230, 255)
		end
	end
	
	if (optionCount == currentOption and selectPressed) then
		return true
	end
	
	return false
end

function Menu.updateSelection()
	selectPressed = false
	
	if (optionCount >= GUI.maxVisOptions) then
		GUI.Rect(GUI.subRect, { menuX, (GUI.maxVisOptions + 1) * menuYSubRect + 0.1105 }, optionRectSize)
		GUI.Spriter("commonmenu", "shop_arrows_upanddown", menuX, (GUI.maxVisOptions + 1) * menuYSubRect + 0.1105, 0.025, 0.045, 0.0, 255, 255, 255, 255)
	elseif (optionCount >= 0) then
		GUI.Rect(GUI.subRect, { menuX, (optionCount + 1) * menuYSubRect + 0.1115 }, optionRectSize)
		GUI.Spriter("commonmenu", "shop_arrows_upanddown", menuX, (optionCount + 1) * menuYSubRect + 0.1115, 0.025, 0.045, 0.0, 255, 255, 255, 255)
	end
	
	if IsControlJustPressed(1, 173)  then
		PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
		
		if(currentOption < optionCount) then
			currentOption = currentOption + 1
		else
			currentOption = 1
		end
	elseif IsControlJustPressed(1, 172) then
		PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
		
		if(currentOption > 1) then
			currentOption = currentOption - 1
		else
			currentOption = optionCount
		end
	elseif IsControlJustPressed(1, 176)  then
		PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
		
		selectPressed = true
	elseif IsControlJustPressed(1, 177) then
		PlaySoundFrontend(-1, "BACK", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
		
		if (prevMenu == nil) then
			Menu.Switch(nil, "")
			menuOpen = false
			if garage_menu then
				garage_menu = false
			end
			currentOption = 1
		elseif not (prevMenu == nil) then
			if not Menus[prevMenu].previous == nil then
				currentOption = 1
				Menu.Switch(nil, prevMenu)
			else
				if Menus[prevMenu].optionCount < currentOption then
					currentOption = Menus[prevMenu].optionCount
				end
				Menu.Switch(Menus[prevMenu].previous, prevMenu)
			end
		end
	end
	optionCount = 0
end
