UIMenuColouredItem = setmetatable({}, UIMenuColouredItem)
UIMenuColouredItem.__index = UIMenuColouredItem
UIMenuColouredItem.__call = function() return "UIMenuItem", "UIMenuColouredItem" end

function UIMenuColouredItem.New(Text, Description, MainColour, HighlightColour)
	if type(Colour) ~= "table" then Colour = {R = 0, G = 0, B = 0, A = 255} end
	if type(HighlightColour) ~= "table" then Colour = {R = 255, G = 255, B = 255, A = 255} end
	local _UIMenuColouredItem = {
		Base = UIMenuItem.New(Text or "", Description or ""),
		Rectangle = UIResRectangle.New(0, 0, 431, 38, MainColour.R, MainColour.G, MainColour.B, MainColour.A),
		MainColour = MainColour,
		HighlightColour = HighlightColour,
		Activated = function(menu, item) end,
	}
	_UIMenuColouredItem.Base.SelectedSprite:Colour(HighlightColour.R, HighlightColour.G, HighlightColour.B, HighlightColour.A)
	return setmetatable(_UIMenuColouredItem, UIMenuColouredItem)
end

function UIMenuColouredItem:SetParentMenu(Menu)
	if Menu() == "UIMenu" then
		self.Base.ParentMenu = Menu
	else
		return self.Base.ParentMenu
	end
end

function UIMenuColouredItem:Position(Y)
	if tonumber(Y) then
		self.Base:Position(Y)
		self.Rectangle:Position(self.Base._Offset.X, Y + 144 + self.Base._Offset.Y)
	end
end

function UIMenuColouredItem:Selected(bool)
	if bool ~= nil then
		self.Base._Selected = tobool(bool)
	else
		return self.Base._Selected
	end
end

function UIMenuColouredItem:Hovered(bool)
	if bool ~= nil then
		self.Base._Hovered = tobool(bool)
	else
		return self.Base._Hovered
	end
end

function UIMenuColouredItem:Enabled(bool)
	if bool ~= nil then
		self.Base._Enabled = tobool(bool)
	else
		return self.Base._Enabled
	end
end

function UIMenuColouredItem:Description(str)
	if tostring(str) and str ~= nil then
		self.Base._Description = tostring(str)
	else
		return self.Base._Description
	end
end

function UIMenuColouredItem:Offset(X, Y)
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

function UIMenuColouredItem:Text(Text)
	if tostring(Text) and Text ~= nil then
		self.Base.Text:Text(tostring(Text))
	else
		return self.Base.Text:Text()
	end
end

function UIMenuColouredItem:RightLabel(Text, MainColour, HighlightColour)
    if tostring(Text) and Text ~= nil then
        if type(MainColour) == "table" then
            self.Base.Label.MainColour = MainColour
        end
        if type(HighlightColour) == "table" then
            self.Base.Label.HighlightColour = HighlightColour
        end
        self.Base.Label.Text:Text(tostring(Text))
    else
        return self.Base.Label.Text:Text()
    end
end

function UIMenuColouredItem:SetLeftBadge(Badge)
	if tonumber(Badge) then
		self.Base.LeftBadge.Badge = tonumber(Badge)
	end
end

function UIMenuColouredItem:SetRightBadge(Badge)
	if tonumber(Badge) then
		self.Base.RightBadge.Badge = tonumber(Badge)
	end
end

function UIMenuColouredItem:Draw()
	self.Rectangle:Size(431 + self.ParentMenu.WidthOffset, self.Rectangle.Height)
	self.Rectangle:Draw()
	self.Base:Draw()
end