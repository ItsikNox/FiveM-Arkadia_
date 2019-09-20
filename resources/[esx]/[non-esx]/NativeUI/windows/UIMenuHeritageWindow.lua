UIMenuHeritageWindow = setmetatable({}, UIMenuHeritageWindow)
UIMenuHeritageWindow.__index = UIMenuHeritageWindow
UIMenuHeritageWindow.__call = function() return "UIMenuWindow", "UIMenuHeritageWindow" end

function UIMenuHeritageWindow.New(Mum, Dad)
	if not tonumber(Mum) then Mum = 0 end
	if not (Mum >= 0 and Mum <= 21) then Mum = 0 end
	if not tonumber(Dad) then Dad = 0 end
	if not (Dad >= 0 and Dad <= 23) then Dad = 0 end
	_UIMenuHeritageWindow = {
		Background = Sprite.New("pause_menu_pages_char_mom_dad", "mumdadbg", 0, 0, 431, 228), -- Background is required, must be a sprite or a rectangle.
		MumSprite = Sprite.New("char_creator_portraits", ((Mum < 21) and "female_"..Mum or "special_female_"..(tonumber(string.sub(Mum, 2, 2)) - 1)), 0, 0, 228, 228),
		DadSprite = Sprite.New("char_creator_portraits", ((Dad < 21) and "male_"..Dad or "special_male_"..(tonumber(string.sub(Dad, 2, 2)) - 1)), 0, 0, 228, 228),
		Mum = Mum,
		Dad = Dad,
		_Offset = {X = 0, Y = 0}, -- required
		ParentMenu = nil, -- required
	}
	return setmetatable(_UIMenuHeritageWindow, UIMenuHeritageWindow)
end

function UIMenuHeritageWindow:SetParentMenu(Menu) -- required
	if Menu() == "UIMenu" then
		self.ParentMenu = Menu
	else
		return self.ParentMenu
	end
end

function UIMenuHeritageWindow:Offset(X, Y) -- required
	if tonumber(X) or tonumber(Y) then
		if tonumber(X) then
			self._Offset.X = tonumber(X)
		end
		if tonumber(Y) then
			self._Offset.Y = tonumber(Y)
		end
	else
		return self._Offset
	end
end

function UIMenuHeritageWindow:Position(Y) -- required
    if tonumber(Y) then
        self.Background:Position(self._Offset.X, 144 + Y + self._Offset.Y)
        self.MumSprite:Position(self._Offset.X + (self.ParentMenu.WidthOffset/2) + 25, 144 + Y + self._Offset.Y)
        self.DadSprite:Position(self._Offset.X + (self.ParentMenu.WidthOffset/2) + 195, 144 + Y + self._Offset.Y)
    end
end

function UIMenuHeritageWindow:Index(Mum, Dad)
	if not tonumber(Mum) then Mum = self.Mum end
	if not (Mum >= 0 and Mum <= 21) then Mum = self.Mum end
	if not tonumber(Dad) then Dad = self.Dad end
	if not (Dad >= 0 and Dad <= 23) then Dad = self.Dad end

	self.Mum = Mum
	self.Dad = Dad

	self.MumSprite.TxtName = ((self.Mum < 21) and "female_"..self.Mum or "special_female_"..(tonumber(string.sub(Mum, 2, 2)) - 1))
	self.DadSprite.TxtName = ((self.Dad < 21) and "male_"..self.Dad or "special_male_"..(tonumber(string.sub(Dad, 2, 2)) - 1))
end

function UIMenuHeritageWindow:Draw() -- required
	self.Background:Size(431 + self.ParentMenu.WidthOffset, 228)
	self.Background:Draw()
	self.DadSprite:Draw()
	self.MumSprite:Draw()
end