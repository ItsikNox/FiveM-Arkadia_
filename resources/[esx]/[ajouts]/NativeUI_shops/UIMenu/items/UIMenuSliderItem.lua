---@type table
UIMenuSliderItem = setmetatable({}, UIMenuSliderItem)

---@type table
UIMenuSliderItem.__index = UIMenuSliderItem

---@type table
---@return string
UIMenuSliderItem.__call = function()
    return "UIMenuItem", "UIMenuSliderItem"
end

---New
---@param Text string
---@param Items table
---@param Index number
---@param Description string
---@param Divider boolean
---@param SliderColors table
---@param BackgroundSliderColors table
---@return table
---@public
function UIMenuSliderItem.New(Text, Items, Index, Description, Divider, SliderColors, BackgroundSliderColors)
    if type(Items) ~= "table" then
        Items = {}
    end
    if Index == 0 then
        Index = 1
    end
    if type(SliderColors) ~= "table" or SliderColors == nil then
        _SliderColors = { R = 57, G = 119, B = 200, A = 255 }
    else
        _SliderColors = SliderColors
    end
    if type(BackgroundSliderColors) ~= "table" or BackgroundSliderColors == nil then
        _BackgroundSliderColors = { R = 4, G = 32, B = 57, A = 255 }
    else
        _BackgroundSliderColors = BackgroundSliderColors
    end
    local _UIMenuSliderItem = {
        Base = UIMenuItem.New(Text or "", Description or ""),
        Items = Items,
        ShowDivider = tobool(Divider),
        LeftArrow = Sprite.New("commonmenu", "arrowleft", 0, 105, 25, 25),
        RightArrow = Sprite.New("commonmenu", "arrowright", 0, 105, 25, 25),
        Background = UIResRectangle.New(0, 0, 150, 10, _BackgroundSliderColors.R, _BackgroundSliderColors.G, _BackgroundSliderColors.B, _BackgroundSliderColors.A),
        Slider = UIResRectangle.New(0, 0, 75, 10, _SliderColors.R, _SliderColors.G, _SliderColors.B, _SliderColors.A),
        Divider = UIResRectangle.New(0, 0, 4, 20, 255, 255, 255, 255),
        _Index = tonumber(Index) or 1,
        OnSliderChanged = function(menu, item, newindex)
        end,
        OnSliderSelected = function(menu, item, newindex)
        end,
    }
    return setmetatable(_UIMenuSliderItem, UIMenuSliderItem)
end

---SetParentMenu
---@param Menu table
---@return table
---@public
function UIMenuSliderItem:SetParentMenu(Menu)
    if Menu() == "UIMenu" then
        self.Base.ParentMenu = Menu
    else
        return self.Base.ParentMenu
    end
end

---Position
---@param Y number
---@return nil
---@public
function UIMenuSliderItem:Position(Y)
    if tonumber(Y) then
        self.Background:Position(250 + self.Base._Offset.X + self.Base.ParentMenu.WidthOffset, Y + 158.5 + self.Base._Offset.Y)
        self.Slider:Position(250 + self.Base._Offset.X + self.Base.ParentMenu.WidthOffset, Y + 158.5 + self.Base._Offset.Y)
        self.Divider:Position(323.5 + self.Base._Offset.X + self.Base.ParentMenu.WidthOffset, Y + 153 + self.Base._Offset.Y)
        self.LeftArrow:Position(225 + self.Base._Offset.X + self.Base.ParentMenu.WidthOffset, 150.5 + Y + self.Base._Offset.Y)
        self.RightArrow:Position(400 + self.Base._Offset.X + self.Base.ParentMenu.WidthOffset, 150.5 + Y + self.Base._Offset.Y)
        self.Base:Position(Y)
    end
end

---Selected
---@param bool table
---@return boolean
---@public
function UIMenuSliderItem:Selected(bool)
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
function UIMenuSliderItem:Hovered(bool)
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
function UIMenuSliderItem:Enabled(bool)
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
function UIMenuSliderItem:Description(str)
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

---Text
---@param Text string
---@return string
---@public
function UIMenuSliderItem:Text(Text)
    if tostring(Text) and Text ~= nil then
        self.Base.Text:Text(tostring(Text))
    else
        return self.Base.Text:Text()
    end
end

---Index
---@param Index number
---@return number
---@public
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

---ItemToIndex
---@param Item number
---@return number
---@public
function UIMenuSliderItem:ItemToIndex(Item)
    for i = 1, #self.Items do
        if type(Item) == type(self.Items[i]) and Item == self.Items[i] then
            return i
        end
    end
end

---IndexToItem
---@param Index number
---@return table
---@public
function UIMenuSliderItem:IndexToItem(Index)
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
function UIMenuSliderItem:SetLeftBadge()
    error("This item does not support badges")
end

---SetRightBadge
---@return function
---@public
function UIMenuSliderItem:SetRightBadge()
    error("This item does not support badges")
end

---RightLabel
---@return function
---@public
function UIMenuSliderItem:RightLabel()
    error("This item does not support a right label")
end

---Draw
---@return nil
---@public
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

    local Offset = ((self.Background.Width - self.Slider.Width) / (#self.Items - 1)) * (self._Index - 1)

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