---@type table
UIMenuColouredItem = setmetatable({}, UIMenuColouredItem)

---@type table
UIMenuColouredItem.__index = UIMenuColouredItem

---@type table
---@return string
UIMenuColouredItem.__call = function()
    return "UIMenuItem", "UIMenuColouredItem"
end

---New
---@param Text string
---@param Description string
---@param MainColour table
---@param HighlightColour table
---@return table
---@public
function UIMenuColouredItem.New(Text, Description, MainColour, HighlightColour)
    if type(Colour) ~= "table" then
        Colour = { R = 0, G = 0, B = 0, A = 255 }
    end
    if type(HighlightColour) ~= "table" then
        Colour = { R = 255, G = 255, B = 255, A = 255 }
    end
    local _UIMenuColouredItem = {
        Base = UIMenuItem.New(Text or "", Description or ""),
        Rectangle = UIResRectangle.New(0, 0, 431, 38, MainColour.R, MainColour.G, MainColour.B, MainColour.A),
        MainColour = MainColour,
        HighlightColour = HighlightColour,
        ParentMenu = nil,
        Activated = function(menu, item)
        end,
    }
    _UIMenuColouredItem.Base.SelectedSprite:Colour(HighlightColour.R, HighlightColour.G, HighlightColour.B, HighlightColour.A)
    return setmetatable(_UIMenuColouredItem, UIMenuColouredItem)
end

---SetParentMenu
---@param Menu table
---@return table
---@public
function UIMenuColouredItem:SetParentMenu(Menu)
    if Menu() == "UIMenu" then
        self.Base.ParentMenu = Menu
        self.ParentMenu = Menu
    else
        return self.Base.ParentMenu
    end
end

---Position
---@param Y number
---@return nil
---@public
function UIMenuColouredItem:Position(Y)
    if tonumber(Y) then
        self.Base:Position(Y)
        self.Rectangle:Position(self.Base._Offset.X, Y + 144 + self.Base._Offset.Y)
    end
end

---Selected
---@param bool boolean
---@return boolean
---@public
function UIMenuColouredItem:Selected(bool)
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
function UIMenuColouredItem:Hovered(bool)
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
function UIMenuColouredItem:Enabled(bool)
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
function UIMenuColouredItem:Description(str)
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

---Text
---@param Text string
---@return string
---@public
function UIMenuColouredItem:Text(Text)
    if tostring(Text) and Text ~= nil then
        self.Base.Text:Text(tostring(Text))
    else
        return self.Base.Text:Text()
    end
end

---SetTextSelectedColor
---@param R number
---@param G number
---@param B number
---@param A number
---@return table
---@public
function UIMenuColouredItem:SetTextSelectedColor(R, G, B, A)
    if tonumber(R) and tonumber(G) and tonumber(B) and tonumber(A) then
        self.Base._Text.Colour.Selected.R = R
        self.Base._Text.Colour.Selected.G = G
        self.Base._Text.Colour.Selected.B = B
        self.Base._Text.Colour.Selected.A = A
    else
        return { R = self.Base._Text.Colour.Selected.R, G = self.Base._Text.Colour.Selected.G, B = self.Base._Text.Colour.Selected.B, A = self.Base._Text.Colour.Selected.A, }
    end
end

---SetTextHoveredColor
---@param R number
---@param G number
---@param B number
---@param A number
---@return table
---@public
function UIMenuColouredItem:SetTextHoveredColor(R, G, B, A)
    if tonumber(R) and tonumber(G) and tonumber(B) and tonumber(A) then
        self.Base._Text.Colour.Hovered.R = R
        self.Base._Text.Colour.Hovered.G = G
        self.Base._Text.Colour.Hovered.B = B
        self.Base._Text.Colour.Hovered.A = A
    else
        return { R = self.Base._Text.Colour.Hovered.R, G = self.Base._Text.Colour.Hovered.G, B = self.Base._Text.Colour.Hovered.B, A = self.Base._Text.Colour.Hovered.A, }
    end
end

---RightLabel
---@param Text string
---@param MainColour table
---@param HighlightColour table
---@return table
---@public
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
        self.Label.MainColour = { R = 0, G = 0, B = 0, A = 0 }
        self.Label.HighlightColour = { R = 0, G = 0, B = 0, A = 0 }
        return self.Base.Label.Text:Text()
    end
end

---SetLeftBadge
---@param Badge number
---@return nil
---@public
function UIMenuColouredItem:SetLeftBadge(Badge)
    if tonumber(Badge) then
        self.Base.LeftBadge.Badge = tonumber(Badge)
    end
end

---SetRightBadge
---@param Badge number
---@return nil
---@public
function UIMenuColouredItem:SetRightBadge(Badge)
    if tonumber(Badge) then
        self.Base.RightBadge.Badge = tonumber(Badge)
    end
end

---Draw
---@return nil
---@public
function UIMenuColouredItem:Draw()
    self.Rectangle:Size(431 + self.ParentMenu.WidthOffset, self.Rectangle.Height)
    self.Rectangle:Draw()
    self.Base:Draw()
end