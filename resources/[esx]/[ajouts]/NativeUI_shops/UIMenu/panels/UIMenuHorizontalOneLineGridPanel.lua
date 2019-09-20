---@type table
UIMenuHorizontalOneLineGridPanel = setmetatable({}, UIMenuHorizontalOneLineGridPanel)

---@type table
UIMenuHorizontalOneLineGridPanel.__index = UIMenuHorizontalOneLineGridPanel

---@type table
---@return string
UIMenuHorizontalOneLineGridPanel.__call = function()
    return "UIMenuPanel", "UIMenuHorizontalOneLineGridPanel"
end

---New
---@param LeftText string
---@param RightText string
---@return table
---@public
function UIMenuHorizontalOneLineGridPanel.New(LeftText, RightText, CirclePositionX)
    local _UIMenuHorizontalOneLineGridPanel = {
        Data = {
            Enabled = true,
        },
        Background = Sprite.New("commonmenu", "gradient_bgd", 0, 0, 431, 275),
        Grid = Sprite.New("NativeUI", "horizontal_grid", 0, 0, 200, 200, 0, 255, 255, 255, 255),
        Circle = Sprite.New("mpinventory", "in_world_circle", 0, 0, 20, 20, 0),
        Audio = { Slider = "CONTINUOUS_SLIDER", Library = "HUD_FRONTEND_DEFAULT_SOUNDSET", Id = nil },
        ParentItem = nil,
        Text = {
            Left = UIResText.New(LeftText or "Left", 0, 0, 0.35, 255, 255, 255, 255, 0, "Centre"),
            Right = UIResText.New(RightText or "Right", 0, 0, 0.35, 255, 255, 255, 255, 0, "Centre"),
        },
        SetCirclePosition = { X = CirclePositionX or 0.5, Y = 0.5 }
    }
    return setmetatable(_UIMenuHorizontalOneLineGridPanel, UIMenuHorizontalOneLineGridPanel)
end

---SetParentItem
---@param Item table
---@return table
---@public
function UIMenuHorizontalOneLineGridPanel:SetParentItem(Item)
    -- required
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
function UIMenuHorizontalOneLineGridPanel:Enabled(Enabled)
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
function UIMenuHorizontalOneLineGridPanel:CirclePosition(X, Y)
    if tonumber(X) and tonumber(Y) then
        self.Circle.X = (self.Grid.X + 20) + ((self.Grid.Width - 40) * ((X >= 0.0 and X <= 1.0) and X or 0.0)) - (self.Circle.Width / 2)
        self.Circle.Y = (self.Grid.Y + 20) + ((self.Grid.Height - 40) * ((Y >= 0.0 and Y <= 1.0) and Y or 0.0)) - (self.Circle.Height / 2)
    else
        return math.round((self.Circle.X - (self.Grid.X + 20) + (self.Circle.Width / 2)) / (self.Grid.Width - 40), 2), math.round((self.Circle.Y - (self.Grid.Y + 10) + (self.Circle.Height / 2)) / (self.Grid.Height - 40), 2)
    end
end

---Position
---@param Y number
---@return nil
---@public
function UIMenuHorizontalOneLineGridPanel:Position(Y)
    if tonumber(Y) then
        local ParentOffsetX, ParentOffsetWidth = self.ParentItem:Offset().X, self.ParentItem:SetParentMenu().WidthOffset
        self.Background:Position(ParentOffsetX, Y)
        self.Grid:Position(ParentOffsetX + 115.5 + (ParentOffsetWidth / 2), 37.5 + Y)
        self.Text.Left:Position(ParentOffsetX + 57.75 + (ParentOffsetWidth / 2), 120 + Y)
        self.Text.Right:Position(ParentOffsetX + 373.25 + (ParentOffsetWidth / 2), 120 + Y)
        if not self.CircleLocked then
            self.CircleLocked = true
            self:CirclePosition(self.SetCirclePosition.X, self.SetCirclePosition.Y)
        end
    end
end

---UpdateParent
---@param X number
---@return nil
---@public
function UIMenuHorizontalOneLineGridPanel:UpdateParent(X)
    local _, ParentType = self.ParentItem()
    self.Data.Value = { X = X }
    if ParentType == "UIMenuListItem" then
        local PanelItemIndex = self.ParentItem:FindPanelItem()
        if PanelItemIndex then
            self.ParentItem.Items[PanelItemIndex].Value[self.ParentItem:FindPanelIndex(self)] = { X = X }
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
                    self.ParentItem.Items[Index].Panels[PanelIndex] = { X = X }
                else
                    self.ParentItem.Items[Index] = { Name = tostring(self.ParentItem.Items[Index]), Value = self.ParentItem.Items[Index], Panels = { [PanelIndex] = { X = X } } }
                end
            end
            self.ParentItem.Base.ParentMenu.OnListChange(self.ParentItem.Base.ParentMenu, self.ParentItem, self.ParentItem._Index)
            self.ParentItem.OnListChanged(self.ParentItem.Base.ParentMenu, self.ParentItem, self.ParentItem._Index)
            self.ParentItem.Base.ActivatedPanel(self.ParentItem.ParentMenu, self.ParentItem, self, { X = X })
        end
    elseif ParentType == "UIMenuItem" then
        self.ParentItem.ActivatedPanel(self.ParentItem.ParentMenu, self.ParentItem, self, { X = X })
    end
end

---Functions
---@return nil
---@public
function UIMenuHorizontalOneLineGridPanel:Functions()
    local DrawOffset = { X = 0, Y = 0}
    if self.ParentItem:SetParentMenu().Settings.ScaleWithSafezone then
        DrawOffset = self.ParentItem:SetParentMenu().DrawOffset
    end
    if IsMouseInBounds(self.Grid.X + 20, self.Grid.Y + 20, self.Grid.Width - 40, self.Grid.Height - 40, DrawOffset) then
        if IsDisabledControlJustPressed(0, 24) then
            if not self.Pressed then
                self.Pressed = true
                Citizen.CreateThread(function()
                    self.Audio.Id = GetSoundId()
                    PlaySoundFrontend(self.Audio.Id, self.Audio.Slider, self.Audio.Library, 1)
                    while IsDisabledControlPressed(0, 24) and IsMouseInBounds(self.Grid.X + 20, self.Grid.Y + 20, self.Grid.Width - 10, self.Grid.Height - 10, DrawOffset) do
                        Citizen.Wait(0)
                        local CursorX, CursorY = ConvertToPixel(GetControlNormal(0, 239) - DrawOffset.X, GetControlNormal(0, 240) - DrawOffset.Y)
                        CursorX, CursorY = CursorX - (self.Circle.Width / 2), CursorY - (self.Circle.Height / 2)
                        local moveCursorX = (CursorX > (self.Grid.X + 10 + self.Grid.Width - 40)) and (self.Grid.X + 10 + self.Grid.Width - 40) or ((CursorX < (self.Grid.X + 20 - (self.Circle.Width / 2))) and (self.Grid.X + 20 - (self.Circle.Width / 2)) or CursorX)
                        local moveCursorY = (CursorY > (self.Grid.Y + 10 + self.Grid.Height - 120)) and (self.Grid.Y + 10 + self.Grid.Height - 120) or ((CursorY < (self.Grid.Y + 100 - (self.Circle.Height / 2))) and (self.Grid.Y + 100 - (self.Circle.Height / 2)) or CursorY)
                        self.Circle:Position(moveCursorX, moveCursorY)
                    end
                    StopSound(self.Audio.Id)
                    ReleaseSoundId(self.Audio.Id)
                    self.Pressed = false
                end)
                Citizen.CreateThread(function()
                    while IsDisabledControlPressed(0, 24) and IsMouseInBounds(self.Grid.X + 20, self.Grid.Y + 20, self.Grid.Width - 40, self.Grid.Height - 40, DrawOffset) do
                        Citizen.Wait(75)
                        local ResultX = math.round((self.Circle.X - (self.Grid.X + 20) + (self.Circle.Width / 2)) / (self.Grid.Width - 40), 2)
                        self:UpdateParent((((ResultX >= 0.0 and ResultX <= 1.0) and ResultX or ((ResultX <= 0) and 0.0) or 1.0) * 2) - 1)
                    end
                end)
            end
        end
    end
end

---Draw
---@return nil
---@public
function UIMenuHorizontalOneLineGridPanel:Draw()
    if self.Data.Enabled then
        self.Background:Size(431 + self.ParentItem:SetParentMenu().WidthOffset, 275)
        self.Background:Draw()
        self.Grid:Draw()
        self.Circle:Draw()
        self.Text.Left:Draw()
        self.Text.Right:Draw()
        self:Functions()
    end
end