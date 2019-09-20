---@type table
UIMenuListItem = setmetatable({}, UIMenuListItem)

---@type table
UIMenuListItem.__index = UIMenuListItem

---@type table
---@return string
UIMenuListItem.__call = function()
    return "UIMenuItem", "UIMenuListItem"
end

---New
---@param Text string
---@param Items table
---@param Index number
---@param Description string
---@return table
---@public
function UIMenuListItem.New(Text, Items, Index, Description)
    if type(Items) ~= "table" then
        Items = {}
    end
    if Index == 0 then
        Index = 1
    end
    local _UIMenuListItem = {
        Base = UIMenuItem.New(Text or "", Description or ""),
        Items = Items,
        LeftArrow = Sprite.New("commonmenu", "arrowleft", 110, 105, 30, 30),
        RightArrow = Sprite.New("commonmenu", "arrowright", 280, 105, 30, 30),
        ItemText = UIResText.New("", 290, 104, 0.35, 255, 255, 255, 255, 0, "Right"),
        _Index = tonumber(Index) or 1,
        Panels = {},
        OnListChanged = function(menu, item, newindex)
        end,
        OnListSelected = function(menu, item, newindex)
        end,
    }
    return setmetatable(_UIMenuListItem, UIMenuListItem)
end

---SetParentMenu
---@param Menu table
---@return table
---@public
function UIMenuListItem:SetParentMenu(Menu)
    if Menu ~= nil and Menu() == "UIMenu" then
        self.Base.ParentMenu = Menu
    else
        return self.Base.ParentMenu
    end
end

---Position
---@param Y number
---@return nil
---@public
function UIMenuListItem:Position(Y)
    if tonumber(Y) then
        self.LeftArrow:Position(300 + self.Base._Offset.X + self.Base.ParentMenu.WidthOffset, 147 + Y + self.Base._Offset.Y)
        self.RightArrow:Position(400 + self.Base._Offset.X + self.Base.ParentMenu.WidthOffset, 147 + Y + self.Base._Offset.Y)
        self.ItemText:Position(300 + self.Base._Offset.X + self.Base.ParentMenu.WidthOffset, 147 + Y + self.Base._Offset.Y)
        self.Base:Position(Y)
    end
end

---Selected
---@param bool boolean
---@return boolean
---@public
function UIMenuListItem:Selected(bool)
    if bool ~= nil then
        self.Base._Selected = tobool(bool)
    else
        return self.Base._Selected
    end
end

---Hovered
---@param bool boolean
---@return boolean
---@public
function UIMenuListItem:Hovered(bool)
    if bool ~= nil then
        self.Base._Hovered = tobool(bool)
    else
        return self.Base._Hovered
    end
end

---Enabled
---@param bool boolean
---@return boolean
---@public
function UIMenuListItem:Enabled(bool)
    if bool ~= nil then
        self.Base._Enabled = tobool(bool)
    else
        return self.Base._Enabled
    end
end

---Description
---@param str string
---@return string
---@public
function UIMenuListItem:Description(str)
    if tostring(str) and str ~= nil then
        self.Base._Description = tostring(str)
    else
        return self.Base._Description
    end
end

---Offset
---@param X number
---@param Y number
---@return table
---@public
function UIMenuListItem:Offset(X, Y)
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

---Text
---@param Text string
---@return string
---@public
function UIMenuListItem:Text(Text)
    if tostring(Text) and Text ~= nil then
        self.Base.Text:Text(tostring(Text))
    else
        return self.Base.Text:Text()
    end
end

---Index
---@param Index table
---@return number
---@public
function UIMenuListItem:Index(Index)
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

---ItemToIndex
---@param Item table
---@return table
---@public
function UIMenuListItem:ItemToIndex(Item)
    for i = 1, #self.Items do
        if type(Item) == type(self.Items[i]) and Item == self.Items[i] then
            return i
        elseif type(self.Items[i]) == "table" and (type(Item) == type(self.Items[i].Name) or type(Item) == type(self.Items[i].Value)) and (Item == self.Items[i].Name or Item == self.Items[i].Value) then
            return i
        end
    end
end

---IndexToItem
---@param Index table
---@return table
---@public
function UIMenuListItem:IndexToItem(Index)
    if tonumber(Index) then
        if tonumber(Index) == 0 then
            Index = 1
        end
        if self.Items[tonumber(Index)] then
            return self.Items[tonumber(Index)]
        end
    end
end

---SetLeftBadge
---@return function
---@public
function UIMenuListItem:SetLeftBadge()
    error("This item does not support badges")
end

---SetRightBadge
---@return function
---@public
function UIMenuListItem:SetRightBadge()
    error("This item does not support badges")
end

---RightLabel
---@return function
---@public
function UIMenuListItem:RightLabel()
    error("This item does not support a right label")
end

---AddPanel
---@param Panel table
---@return nil
---@public
function UIMenuListItem:AddPanel(Panel)
    if Panel() == "UIMenuPanel" then
        table.insert(self.Panels, Panel)
        Panel:SetParentItem(self)
    end
end

---RemovePanelAt
---@param Index table
---@return nil
---@public
function UIMenuListItem:RemovePanelAt(Index)
    if tonumber(Index) then
        if self.Panels[Index] then
            table.remove(self.Panels, tonumber(Index))
        end
    end
end

---FindPanelIndex
---@param Panel table
---@return number
---@public
function UIMenuListItem:FindPanelIndex(Panel)
    if Panel() == "UIMenuPanel" then
        for Index = 1, #self.Panels do
            if self.Panels[Index] == Panel then
                return Index
            end
        end
    end
    return nil
end

---FindPanelItem
---@return number
---@public
function UIMenuListItem:FindPanelItem()
    for Index = #self.Items, 1, -1 do
        if self.Items[Index].Panel then
            return Index
        end
    end
    return nil
end

---Draw
---@return nil
---@public
function UIMenuListItem:Draw()
    self.Base:Draw()

    if self:Enabled() then
        if self:Selected() then
            self.ItemText:Colour(0, 0, 0, 255)
            self.LeftArrow:Colour(0, 0, 0, 255)
            self.RightArrow:Colour(0, 0, 0, 255)
        else
            self.ItemText:Colour(245, 245, 245, 255)
            self.LeftArrow:Colour(245, 245, 245, 255)
            self.RightArrow:Colour(245, 245, 245, 255)
        end
    else
        self.ItemText:Colour(163, 159, 148, 255)
        self.LeftArrow:Colour(163, 159, 148, 255)
        self.RightArrow:Colour(163, 159, 148, 255)
    end

    local Text = (type(self.Items[self._Index]) == "table") and tostring(self.Items[self._Index].Name) or tostring(self.Items[self._Index])
    local Offset = MeasureStringWidth(Text, 0, 0.35)

    self.ItemText:Text(Text)
    self.LeftArrow:Position(378 - Offset + self.Base._Offset.X + self.Base.ParentMenu.WidthOffset, self.LeftArrow.Y)

	if self:Selected() then
		self.LeftArrow:Draw()
		self.RightArrow:Draw()
		self.ItemText:Position(403 + self.Base._Offset.X + self.Base.ParentMenu.WidthOffset, self.ItemText.Y)
	else
		self.ItemText:Position(418 + self.Base._Offset.X + self.Base.ParentMenu.WidthOffset, self.ItemText.Y)
	end

    self.ItemText:Draw()
end