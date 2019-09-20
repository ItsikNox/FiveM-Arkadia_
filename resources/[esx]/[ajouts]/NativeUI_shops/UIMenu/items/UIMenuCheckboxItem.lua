---@type table
UIMenuCheckboxItem = setmetatable({}, UIMenuCheckboxItem)

---@type table
UIMenuCheckboxItem.__index = UIMenuCheckboxItem

---@type table
---@return string
UIMenuCheckboxItem.__call = function()
    return "UIMenuItem", "UIMenuCheckboxItem"
end

---New
---@param Text string
---@param Check boolean
---@param Description string
---@param CheckboxStyle number
---@return table
---@public
function UIMenuCheckboxItem.New(Text, Check, Description, CheckboxStyle)
    if CheckboxStyle ~= nil then
        CheckboxStyle = tonumber(CheckboxStyle)
    else
        CheckboxStyle = 1
    end
    local _UIMenuCheckboxItem = {
        Base = UIMenuItem.New(Text or "", Description or ""),
        CheckboxStyle = CheckboxStyle,
        CheckedSprite = Sprite.New("commonmenu", "shop_box_blank", 410, 95, 50, 50),
        Checked = tobool(Check),
        CheckboxEvent = function(menu, item, checked)
        end,
    }
    return setmetatable(_UIMenuCheckboxItem, UIMenuCheckboxItem)
end

---SetParentMenu
---@param Menu table
---@return table
---@public
function UIMenuCheckboxItem:SetParentMenu(Menu)
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
function UIMenuCheckboxItem:Position(Y)
    if tonumber(Y) then
        self.Base:Position(Y)
        self.CheckedSprite:Position(380 + self.Base._Offset.X + self.Base.ParentMenu.WidthOffset, Y + 138 + self.Base._Offset.Y)
    end
end

---Selected
---@param bool boolean
---@return boolean
---@public
function UIMenuCheckboxItem:Selected(bool)
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
function UIMenuCheckboxItem:Hovered(bool)
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
function UIMenuCheckboxItem:Enabled(bool)
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
function UIMenuCheckboxItem:Description(str)
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

---Text
---@param Text string
---@return string
---@public
function UIMenuCheckboxItem:Text(Text)
    if tostring(Text) and Text ~= nil then
        self.Base.Text:Text(tostring(Text))
    else
        return self.Base.Text:Text()
    end
end

---SetLeftBadge
---@return function
---@public
function UIMenuCheckboxItem:SetLeftBadge()
    error("This item does not support badges")
end

---SetRightBadge
---@return function
---@public
function UIMenuCheckboxItem:SetRightBadge()
    error("This item does not support badges")
end

---RightLabel
---@return function
---@public
function UIMenuCheckboxItem:RightLabel()
    error("This item does not support a right label")
end

---Draw
---@return nil
---@public
function UIMenuCheckboxItem:Draw()
    self.Base:Draw()
    self.CheckedSprite:Position(380 + self.Base._Offset.X + self.Base.ParentMenu.WidthOffset, self.CheckedSprite.Y)
    if self.CheckboxStyle == nil or self.CheckboxStyle == tonumber(1) then
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
    elseif self.CheckboxStyle == tonumber(2) then
        if self.Base:Selected() then
            if self.Checked then
                self.CheckedSprite.TxtName = "shop_box_crossb"
            else
                self.CheckedSprite.TxtName = "shop_box_blankb"
            end
        else
            if self.Checked then
                self.CheckedSprite.TxtName = "shop_box_cross"
            else
                self.CheckedSprite.TxtName = "shop_box_blank"
            end
        end
    end
    self.CheckedSprite:Draw()
end