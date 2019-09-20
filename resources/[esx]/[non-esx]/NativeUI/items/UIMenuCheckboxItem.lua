UIMenuCheckboxItem = setmetatable({}, UIMenuCheckboxItem)
UIMenuCheckboxItem.__index = UIMenuCheckboxItem
UIMenuCheckboxItem.__call = function() return "UIMenuItem", "UIMenuCheckboxItem" end

function UIMenuCheckboxItem.New(Text, Check, Description)
	local _UIMenuCheckboxItem = {
		Base = UIMenuItem.New(Text or "", Description or ""),
		CheckedSprite = Sprite.New("commonmenu", "shop_box_blank", 410, 95, 50, 50),
		Checked = tobool(Check),
		CheckboxEvent = function(menu, item, checked) end,
	}
	return setmetatable(_UIMenuCheckboxItem, UIMenuCheckboxItem)
end

function UIMenuCheckboxItem:SetParentMenu(Menu)
	if Menu() == "UIMenu" then
		self.Base.ParentMenu = Menu
	else
		return self.Base.ParentMenu
	end
end

function UIMenuCheckboxItem:Position(Y)
	if tonumber(Y) then
		self.Base:Position(Y)
		self.CheckedSprite:Position(380 + self.Base._Offset.X + self.Base.ParentMenu.WidthOffset, Y + 138 + self.Base._Offset.Y)
	end
end

function UIMenuCheckboxItem:Selected(bool)
	if bool ~= nil then
		self.Base._Selected = tobool(bool)
	else
		return self.Base._Selected
	end
end

function UIMenuCheckboxItem:Hovered(bool)
	if bool ~= nil then
		self.Base._Hovered = tobool(bool)
	else
		return self.Base._Hovered
	end
end

function UIMenuCheckboxItem:Enabled(bool)
	if bool ~= nil then
		self.Base._Enabled = tobool(bool)
	else
		return self.Base._Enabled
	end
end

function UIMenuCheckboxItem:Description(str)
	if tostring(str) and str ~= nil then
		self.Base._Description = tostring(str)
	else
		return self.Base._Description
	end
end

function UIMenuCheckboxItem:Offset(X, Y)
	if tonumber(X) or tonumber(Y) then
		if tonumber(X) then
			self.Base._Offset.X = tonumber(X)
		end
		if tonumber(Y) then
			self.Base._Offset.Y = tonumber(Y)
		end
	else
		return self.Base._Offset
	end
end

function UIMenuCheckboxItem:Text(Text)
	if tostring(Text) and Text ~= nil then
		self.Base.Text:Text(tostring(Text))
	else
		return self.Base.Text:Text()
	end
end

function UIMenuCheckboxItem:SetLeftBadge()
	error("This item does not support badges")
end

function UIMenuCheckboxItem:SetRightBadge()
	error("This item does not support badges")
end

function UIMenuCheckboxItem:RightLabel()
	error("This item does not support a right label")
end

function UIMenuCheckboxItem:Draw()
	self.Base:Draw()
	self.CheckedSprite:Position(380 + self.Base._Offset.X + self.Base.ParentMenu.WidthOffset, self.CheckedSprite.Y)
	if self.Base:Selected() then
		if self.Checked then
			self.CheckedSprite.TxtName = "shop_box_tickb"
		else
			self.CheckedSprite.TxtName = "shop_box_blankb"
		end
	else
		if self.Checked then
			self.CheckedSprite.TxtName = "shop_box_tick"
		else
			self.CheckedSprite.TxtName = "shop_box_blank"
		end
	end
	self.CheckedSprite:Draw()
end