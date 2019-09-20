---@type table
UIMenuVerticalOneLineGridPanel = setmetatable({}, UIMenuVerticalOneLineGridPanel)

---@type table
UIMenuVerticalOneLineGridPanel.__index = UIMenuVerticalOneLineGridPanel

---@type table
---@return string
UIMenuVerticalOneLineGridPanel.__call = function()
    return "UIMenuPanel", "UIMenuVerticalOneLineGridPanel"
end

---New
---@param TopText string
---@param BottomText string
---@return table
---@public
function UIMenuVerticalOneLineGridPanel.New(TopText, BottomText, CirclePositionY)
    local _UIMenuVerticalOneLineGridPanel = {
        Data = {
            Enabled = true,
        },
        Background = Sprite.New("commonmenu", "gradient_bgd", 0, 0, 431, 275),
        Grid = Sprite.New("NativeUI", "vertical_grid", 0, 0, 200, 200, 0, 255, 255, 255, 255),
        Circle = Sprite.New("mpinventory", "in_world_circle", 0, 0, 20, 20, 0),
        Audio = { Slider = "CONTINUOUS_SLIDER", Library = "HUD_FRONTEND_DEFAULT_SOUNDSET", Id = nil },
        ParentItem = nil,
        Text = {
            Top = UIResText.New(TopText or "Top", 0, 0, 0.35, 255, 255, 255, 255, 0, "Centre"),
            Bottom = UIResText.New(BottomText or "Bottom", 0, 0, 0.35, 255, 255, 255, 255, 0, "Centre"),
        },
        SetCirclePosition = { X = 0.5, Y = CirclePositionY or 0.5 }
    }
    return setmetatable(_UIMenuVerticalOneLineGridPanel, UIMenuVerticalOneLineGridPanel)
end

---SetParentItem
---@param Item table
---@return table
---@public
function UIMenuVerticalOneLineGridPanel:SetParentItem(Item)
    if Item() == "UIMenuItem" then
        self.ParentItem = Item
    else
        return self.ParentItem
    end
end

---Enabled
---@param Enabled boolean
---@return boolean
---@public
function UIMenuVerticalOneLineGridPanel:Enabled(Enabled)
    if type(Enabled) == "boolean" then
        self.Data.Enabled = Enabled
    else
        return self.Data.Enabled
    end
end

---CirclePosition
---@param X number
---@param Y number
---@return table
---@public
function UIMenuVerticalOneLineGridPanel:CirclePosition(X, Y)
    if tonumber(X) and tonumber(Y) then
        self.Circle.X = (self.Grid.X + 20) + ((self.Grid.Width - 40) * ((X >= 0.0 and X <= 1.0) and X or 0.0)) - (self.Circle.Width / 2)
        self.Circle.Y = (self.Grid.Y + 20) + ((self.Grid.Height - 40) * ((Y >= 0.0 and Y <= 1.0) and Y or 0.0)) - (self.Circle.Height / 2)
    else
        return math.round((self.Circle.X - (self.Grid.X + 20) + (self.Circle.Width / 2)) / (self.Grid.Width - 40), 2), math.round((self.Circle.Y - (self.Grid.Y + 20) + (self.Circle.Height / 2)) / (self.Grid.Height - 40), 2)
    end
end

---Position
---@param Y number
---@return nil
---@public
function UIMenuVerticalOneLineGridPanel:Position(Y)
    if tonumber(Y) then
        local ParentOffsetX, ParentOffsetWidth = self.ParentItem:Offset().X, self.ParentItem:SetParentMenu().WidthOffset
        self.Background:Position(ParentOffsetX, Y)
        self.Grid:Position(ParentOffsetX + 115.5 + (ParentOffsetWidth / 2), 37.5 + Y)
        self.Text.Top:Position(ParentOffsetX + 215.5 + (ParentOffsetWidth / 2), 5 + Y)
        self.Text.Bottom:Position(ParentOffsetX + 215.5 + (ParentOffsetWidth / 2), 240 + Y)
        if not self.CircleLocked then
            self.CircleLocked = true
            self:CirclePosition(self.SetCirclePosition.X, self.SetCirclePosition.Y)
        end
    end
end

---UpdateParent
---@param Y number
---@return nil
---@public
function UIMenuVerticalOneLineGridPanel:UpdateParent(Y)
    local _, ParentType = self.ParentItem()
    self.Data.Value = { Y = Y }
    if ParentType == "UIMenuListItem" then
        local PanelItemIndex = self.ParentItem:FindPanelItem()
        if PanelItemIndex then
            self.ParentItem.Items[PanelItemIndex].Value[self.ParentItem:FindPanelIndex(self)] = { Y = Y }
            self.ParentItem:Index(PanelItemIndex)
            self.ParentItem.Base.ParentMenu.OnListChange(self.ParentItem.Base.ParentMenu, self.ParentItem, self.ParentItem._Index)
            self.ParentItem.OnListChanged(self.ParentItem.Base.ParentMenu, self.ParentItem, self.ParentItem._Index)
        else
            local PanelIndex = self.ParentItem:FindPanelIndex(self)
            for Index = 1, #self.ParentItem.Items do
                if type(self.ParentItem.Items[Index]) == "table" then
                    if not self.ParentItem.Items[Index].Panels then
                        self.ParentItem.Items[Index].Panels = {}
                    end
                    self.ParentItem.Items[Index].Panels[PanelIndex] = { Y = Y }
                else
                    self.ParentItem.Items[Index] = { Name = tostring(self.ParentItem.Items[Index]), Value = self.ParentItem.Items[Index], Panels = { [PanelIndex] = { Y = Y } } }
                end
            end
            self.ParentItem.Base.ParentMenu.OnListChange(self.ParentItem.Base.ParentMenu, self.ParentItem, self.ParentItem._Index)
            self.ParentItem.OnListChanged(self.ParentItem.Base.ParentMenu, self.ParentItem, self.ParentItem._Index)
            self.ParentItem.Base.ActivatedPanel(self.ParentItem.ParentMenu, self.ParentItem, self, { Y = Y })
        end
    elseif ParentType == "UIMenuItem" then
        self.ParentItem.ActivatedPanel(self.ParentItem.ParentMenu, self.ParentItem, self, { Y = Y })
    end
end

---Functions
---@return nil
---@public
function UIMenuVerticalOneLineGridPanel:Functions()
    local SafeZone = { X = 0, Y = 0 }
    if self.ParentItem:SetParentMenu().Settings.ScaleWithSafezone then
        SafeZone = GetSafeZoneBounds()
    end

    if IsMouseInBounds(self.Grid.X + 20 + SafeZone.X, self.Grid.Y + 20 + SafeZone.Y, self.Grid.Width - 40, self.Grid.Height - 40) then
        if IsDisabledControlJustPressed(0, 24) then
            if not self.Pressed then
                self.Pressed = true
                Citizen.CreateThread(function()
                    self.Audio.Id = GetSoundId()
                    PlaySoundFrontend(self.Audio.Id, self.Audio.Slider, self.Audio.Library, 1)
                    while IsDisabledControlPressed(0, 24) and IsMouseInBounds(self.Grid.X + 20 + SafeZone.X, self.Grid.Y + 20 + SafeZone.Y, self.Grid.Width - 40, self.Grid.Height - 40) do
                        Citizen.Wait(0)
                        local CursorX = math.round(GetControlNormal(0, 239) * 1920) - SafeZone.X - (self.Circle.Width / 2)
                        local CursorY = math.round(GetControlNormal(0, 240) * 1080) - SafeZone.Y - (self.Circle.Height / 2)
                        local moveCursorX = ((CursorX > (self.Grid.X + 10 + self.Grid.Width - 120)) and (self.Grid.X + 10 + self.Grid.Width - 120) or ((CursorX < (self.Grid.X + 100 - (self.Circle.Width / 2))) and (self.Grid.X + 100 - (self.Circle.Width / 2)) or CursorX))
                        local moveCursorY = ((CursorY > (self.Grid.Y + 10 + self.Grid.Height - 40)) and (self.Grid.Y + 10 + self.Grid.Height - 40) or ((CursorY < (self.Grid.Y + 20 - (self.Circle.Height / 2))) and (self.Grid.Y + 20 - (self.Circle.Height / 2)) or CursorY))
                        self.Circle:Position(moveCursorX, moveCursorY)
                    end
                    StopSound(self.Audio.Id)
                    ReleaseSoundId(self.Audio.Id)
                    self.Pressed = false
                end)
                Citizen.CreateThread(function()
                    while IsDisabledControlPressed(0, 24) and IsMouseInBounds(self.Grid.X + 20 + SafeZone.X, self.Grid.Y + 20 + SafeZone.Y, self.Grid.Width - 40, self.Grid.Height - 40) do
                        Citizen.Wait(75)
                        local ResultY = math.round((self.Circle.Y - (self.Grid.Y + 20) + (self.Circle.Height / 2)) / (self.Grid.Height - 40), 2)
                        self:UpdateParent((((ResultY >= 0.0 and ResultY <= 1.0) and ResultY or ((ResultY <= 0) and 0.0) or 1.0) * 2) - 1)
                    end
                end)
            end
        end
    end
end

---Draw
---@return nil
---@public
function UIMenuVerticalOneLineGridPanel:Draw()
    if self.Data.Enabled then
        self.Background:Size(431 + self.ParentItem:SetParentMenu().WidthOffset, 275)
        self.Background:Draw()
        self.Grid:Draw()
        self.Circle:Draw()
        self.Text.Top:Draw()
        self.Text.Bottom:Draw()
        self:Functions()
    end
end
