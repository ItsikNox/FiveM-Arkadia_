MenuPool = setmetatable({}, MenuPool)
MenuPool.__index = MenuPool

function MenuPool.New()
	local _MenuPool = {
		Menus = {}
	}
	return setmetatable(_MenuPool, MenuPool)
end

function MenuPool:AddSubMenu(Menu, Text, Description, KeepPosition, KeepBanner)
	if Menu() == "UIMenu" then
		local Item = UIMenuItem.New(tostring(Text), Description or "")
		Menu:AddItem(Item)
		local SubMenu
		if KeepPosition then
			SubMenu = UIMenu.New(Menu.Title:Text(), Text, Menu.Position.X, Menu.Position.Y)
		else
			SubMenu = UIMenu.New(Menu.Title:Text(), Text)
		end
		if KeepBanner then
			if Menu.Logo ~= nil then
				SubMenu.Logo = Menu.Logo
			else
				SubMenu.Logo = nil
				SubMenu.Banner = Menu.Banner
			end
		end
		self:Add(SubMenu)
		Menu:BindMenuToItem(SubMenu, Item)
		return SubMenu
	end
end

function MenuPool:Add(Menu)
	if Menu() == "UIMenu" then
		table.insert(self.Menus, Menu)
	end
end

function MenuPool:MouseEdgeEnabled(bool)
	if bool ~= nil then
		for _, Menu in pairs(self.Menus) do
			Menu.Settings.MouseEdgeEnabled = tobool(bool)
		end
	end
end

function MenuPool:ControlDisablingEnabled(bool)
	if bool ~= nil then
		for _, Menu in pairs(self.Menus) do
			Menu.Settings.ControlDisablingEnabled = tobool(bool)
		end
	end
end

function MenuPool:ResetCursorOnOpen(bool)
	if bool ~= nil then
		for _, Menu in pairs(self.Menus) do
			Menu.Settings.ResetCursorOnOpen = tobool(bool)
		end
	end
end

function MenuPool:MultilineFormats(bool)
	if bool ~= nil then
		for _, Menu in pairs(self.Menus) do
			Menu.Settings.MultilineFormats = tobool(bool)
		end
	end
end

function MenuPool:Audio(Attribute, Setting)
	if Attribute ~= nil and Setting ~= nil then
		for _, Menu in pairs(self.Menus) do
			if Menu.Settings.Audio[Attribute] then
				Menu.Settings.Audio[Attribute] = Setting
			end
		end
	end
end

function MenuPool:WidthOffset(offset)
	if tonumber(offset) then
		for _, Menu in pairs(self.Menus) do
			Menu:SetMenuWidthOffset(tonumber(offset))
		end
	end
end

function MenuPool:CounterPreText(str)
	if str ~= nil then
		for _, Menu in pairs(self.Menus) do
			Menu.PageCounter.PreText = tostring(str)
		end
	end
end

function MenuPool:DisableInstructionalButtons(bool)
	if bool ~= nil then
		for _, Menu in pairs(self.Menus) do
			Menu.Settings.InstructionalButtons = tobool(bool)
		end
	end
end

function MenuPool:MouseControlsEnabled(bool)
    if bool ~= nil then
        for _, Menu in pairs(self.Menus) do
            Menu.Settings.MouseControlsEnabled = tobool(bool)
        end
    end
end

function MenuPool:RefreshIndex()
	for _, Menu in pairs(self.Menus) do
		Menu:RefreshIndex()
	end
end

function MenuPool:ProcessMenus()
	self:ProcessControl()
	self:ProcessMouse()
	self:Draw()
end

function MenuPool:ProcessControl()
	for _, Menu in pairs(self.Menus) do
		if Menu:Visible() then
			Menu:ProcessControl()
		end
	end
end

function MenuPool:ProcessMouse()
	for _, Menu in pairs(self.Menus) do
		if Menu:Visible() then
			Menu:ProcessMouse()
		end
	end
end

function MenuPool:Draw()
	for _, Menu in pairs(self.Menus) do
		if Menu:Visible() then
			Menu:Draw()
		end
	end
end

function MenuPool:IsAnyMenuOpen()
	local open = false
	for _, Menu in pairs(self.Menus) do
		if Menu:Visible() then
			open = true
			break
		end
	end
	return open
end

function MenuPool:CloseAllMenus()
	for _, Menu in pairs(self.Menus) do
		if Menu:Visible() then
			Menu:Visible(false)
			Menu.OnMenuClosed(Menu)
		end
	end
end

function MenuPool:SetBannerSprite(Sprite)
	if Sprite() == "Sprite" then
		for _, Menu in pairs(self.Menus) do
			Menu:SetBannerSprite(Sprite)
		end
	end
end

function MenuPool:SetBannerRectangle(Rectangle)
	if Rectangle() == "Rectangle" then
		for _, Menu in pairs(self.Menus) do
			Menu:SetBannerRectangle(Rectangle)
		end
	end
end

function MenuPool:TotalItemsPerPage(Value)
    if tonumber(Value) then
        for _, Menu in pairs(self.Menus) do
            Menu.Pagination.Total = Value - 1
        end
    end
end