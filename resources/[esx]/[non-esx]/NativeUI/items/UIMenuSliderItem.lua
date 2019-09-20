UIMenuSliderItem = setmetatable({}, UIMenuSliderItem)
UIMenuSliderItem.__index = UIMenuSliderItem
UIMenuSliderItem.__call = function() return "UIMenuItem", "UIMenuSliderItem" end

function UIMenuSliderItem.New(Text, Items, Index, Description, Divider)
	if type(Items) ~= "table" then Items = {} end
	if Index == 0 then Index = 1 end
	local _UIMenuSliderItem = {
		Base = UIMenuItem.New(Text or "", Description or ""),
		Items = Items,
		ShowDivider = tobool(Divider),
		LeftArrow = Sprite.New("commonmenutu", "arrowleft", 0, 105, 15, 15),
		RightArrow = Sprite.New("commonmenutu", "arrowright", 0, 105, 15, 15),
		Background = UIResRectangle.New(0, 0, 150, 9, 4, 32, 57, 255),
		Slider = UIResRectangle.New(0, 0, 75, 9, 57, 116, 200, 255),
		Divider = UIResRectangle.New(0, 0, 2.5, 20, 245, 245, 245, 255),
		_Index = tonumber(Index) or 1,
		OnSliderChanged = function(menu, item, newindex) end,
		OnSliderSelected = function(menu, item, newindex) end,
	}
	return setmetatable(_UIMenuSliderItem, UIMenuSliderItem)
end

function UIMenuSliderItem:SetParentMenu(Menu)
	if Menu() == "UIMenu" then
		self.Base.ParentMenu = Menu
	else
		return self.Base.ParentMenu
	end
end

function UIMenuSliderItem:Position(Y)
	if tonumber(Y) then
		self.Background:Position(250 + self.Base._Offset.X + self.Base.ParentMenu.WidthOffset, Y + 158.5 + self.Base._Offset.Y)
		self.Slider:Position(250 + self.Base._Offset.X + self.Base.ParentMenu.WidthOffset, Y + 158.5 + self.Base._Offset.Y)
		self.Divider:Position(323.5 + self.Base._Offset.X + self.Base.ParentMenu.WidthOffset, Y + 153 + self.Base._Offset.Y)
		self.LeftArrow:Position(235 + self.Base._Offset.X + self.Base.ParentMenu.WidthOffset, 155.5 + Y + self.Base._Offset.Y)
		self.RightArrow:Position(400 + self.Base._Offset.X + self.Base.ParentMenu.WidthOffset, 155.5 + Y + self.Base._Offset.Y)
		self.Base:Position(Y)
	end
end

function UIMenuSliderItem:Selected(bool)
	if bool ~= nil then
		self.Base._Selected = tobool(bool)
	else
		return self.Base._Selected
	end
end

function UIMenuSliderItem:Hovered(bool)
	if bool ~= nil then
		self.Base._Hovered = tobool(bool)
	else
		return self.Base._Hovered
	end
end

function UIMenuSliderItem:Enabled(bool)
	if bool ~= nil then
		self.Base._Enabled = tobool(bool)
	else
		return self.Base._Enabled
	end
end

function UIMenuSliderItem:Description(str)
	if tostring(str) and str ~= nil then
		self.Base._Description = tostring(str)
	else
		return self.Base._Description
	end
end

function UIMenuSliderItem:Offset(X, Y)
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

function UIMenuSliderItem:Text(Text)
	if tostring(Text) and Text ~= nil then
		self.Base.Text:Text(tostring(Text))
	else
		return self.Base.Text:Text()
	end
end

function UIMenuSliderItem:Index(Index)
	if tonumber(Index) then
		if tonumber(Index) > #self.Items then
			self._Index = 1
		elseif tonumber(Index) < 1 then
			self._Index = #self.Items
		else
			self._Index = tonumber(Index)
		end
	else
		return self._Index
	end
end

function UIMenuSliderItem:ItemToIndex(Item)
	for i = 1, #self.Items do
		if type(Item) == type(self.Items[i]) and Item == self.Items[i] then
			return i
		end
	end
end

function UIMenuSliderItem:IndexToItem(Index)
	if tonumber(Index) then
		if tonumber(Index) == 0 then Index = 1 end
		if self.Items[tonumber(Index)] then
			return self.Items[tonumber(Index)]
		end
	end
end

function UIMenuSliderItem:SetLeftBadge()
	error("This item does not support badges")
end

function UIMenuSliderItem:SetRightBadge()
	error("This item does not support badges")
end

function UIMenuSliderItem:RightLabel()
	error("This item does not support a right label")
end

function UIMenuSliderItem:Draw()
	self.Base:Draw()

	if self:Enabled() then
		if self:Selected() then
			self.LeftArrow:Colour(0, 0, 0, 255)
			self.RightArrow:Colour(0, 0, 0, 255)
		else
			self.LeftArrow:Colour(245, 245, 245, 255)
			self.RightArrow:Colour(245, 245, 245, 255)
		end
	else
		self.LeftArrow:Colour(163, 159, 148, 255)
		self.RightArrow:Colour(163, 159, 148, 255)
	end
	
	local Offset = ((self.Background.Width - self.Slider.Width)/(#self.Items - 1)) * (self._Index-1)

	self.Slider:Position(250 + self.Base._Offset.X + Offset + self.Base.ParentMenu.WidthOffset, self.Slider.Y)

	if self:Selected() then
		self.LeftArrow:Draw()
		self.RightArrow:Draw()
	end

	self.Background:Draw()
	self.Slider:Draw()
	if self.ShowDivider then
		self.Divider:Draw()
	end
end