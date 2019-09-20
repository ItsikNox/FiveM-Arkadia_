---@type table
UIMenu = setmetatable({}, UIMenu)

---@type table
UIMenu.__index = UIMenu

---@type table
---@return string
UIMenu.__call = function()
    return "UIMenu"
end

---New
---@param Title string
---@param Subtitle string
---@param X number
---@param Y number
---@param TxtDictionary string
---@param TxtName string
---@param Heading number
---@param R number
---@param G number
---@param B number
---@param A number
---@return table
---@public
function UIMenu.New(Title, Subtitle, X, Y, TxtDictionary, TxtName, Heading, R, G, B, A)
    local X, Y = tonumber(X) or 0, tonumber(Y) or 0
    if Title ~= nil then
        Title = tostring(Title) or ""
    else
        Title = ""
    end
    if Subtitle ~= nil then
        Subtitle = tostring(Subtitle) or ""
    else
        Subtitle = ""
    end
    if TxtDictionary ~= nil then
        TxtDictionary = tostring(TxtDictionary) or "commonmenu"
    else
        TxtDictionary = "commonmenu"
    end
    if TxtName ~= nil then
        TxtName = tostring(TxtName) or "interaction_bgd"
    else
        TxtName = "interaction_bgd"
    end
    if Heading ~= nil then
        Heading = tonumber(Heading) or 0
    else
        Heading = 0
    end
    if R ~= nil then
        R = tonumber(R) or 255
    else
        R = 255
    end
    if G ~= nil then
        G = tonumber(G) or 255
    else
        G = 255
    end
    if B ~= nil then
        B = tonumber(B) or 255
    else
        B = 255
    end
    if A ~= nil then
        A = tonumber(A) or 255
    else
        A = 255
    end
    local _UIMenu = {
        Logo = Sprite.New(TxtDictionary, TxtName, 0 + X, 0 + Y, 431, 107, Heading, R, G, B, A),
        Banner = nil,
        Title = UIResText.New(Title, 215 + X, 20 + Y, 1.15, 255, 255, 255, 255, 1, 1, 0),
        BetterSize = true,
        Subtitle = { ExtraY = 0 },
        WidthOffset = 0,
        Position = { X = X, Y = Y },
        DrawOffset = { X = 0, Y = 0 },
        Pagination = { Min = 0, Max = 10, Total = 9 },
        PageCounter = {
            isCustom = false,
            PreText = "",
        },
        Extra = {},
        Description = {},
        Items = {},
        Windows = {},
        Children = {},
        Controls = {
            Back = {
                Enabled = true,
            },
            Select = {
                Enabled = true,
            },
            Left = {
                Enabled = true,
            },
            Right = {
                Enabled = true,
            },
            Up = {
                Enabled = true,
            },
            Down = {
                Enabled = true,
            },
        },
        ParentMenu = nil,
        ParentItem = nil,
        _Visible = false,
        ActiveItem = 1000,
        Dirty = false;
        ReDraw = true,
        InstructionalScaleform = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS"),
        InstructionalButtons = {},
        OnIndexChange = function(menu, newindex)
        end,
        OnListChange = function(menu, list, newindex)
        end,
        OnSliderChange = function(menu, slider, newindex)
        end,
        OnProgressChange = function(menu, progress, newindex)
        end,
        OnCheckboxChange = function(menu, item, checked)
        end,
        OnListSelect = function(menu, list, index)
        end,
        OnSliderSelect = function(menu, slider, index)
        end,
        OnProgressSelect = function(menu, progress, index)
        end,
        OnItemSelect = function(menu, item, index)
        end,
        OnMenuChanged = function(menu, newmenu, forward)
        end,
        OnMenuClosed = function(menu)
        end,
        Settings = {
            InstructionalButtons = true,
            MultilineFormats = true,
            ScaleWithSafezone = true,
            ResetCursorOnOpen = false,
            MouseControlsEnabled = false,
            MouseEdgeEnabled = true,
            ControlDisablingEnabled = false,
            DrawOrder = nil,
            Audio = {
                Library = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                UpDown = "NAV_UP_DOWN",
                LeftRight = "NAV_LEFT_RIGHT",
                Select = "SELECT",
                Back = "BACK",
                Error = "ERROR",
            },
            EnabledControls = {
                Controller = {
                    { 0, 2 }, -- Look Up and Down
                    { 0, 1 }, -- Look Left and Right
                    { 0, 25 }, -- Aim
                    { 0, 24 }, -- Attack
                },
                Keyboard = {
                    { 0, 201 }, -- Select
                    { 0, 195 }, -- X axis
                    { 0, 196 }, -- Y axis
                    { 0, 187 }, -- Down
                    { 0, 188 }, -- Up
                    { 0, 189 }, -- Left
                    { 0, 190 }, -- Right
                    { 0, 202 }, -- Back
                    { 0, 217 }, -- Select
                    { 0, 242 }, -- Scroll down
                    { 0, 241 }, -- Scroll up
                    { 0, 239 }, -- Cursor X
                    { 0, 240 }, -- Cursor Y
                    { 0, 31 }, -- Move Up and Down
                    { 0, 30 }, -- Move Left and Right
                    { 0, 21 }, -- Sprint
                    { 0, 22 }, -- Jump
                    { 0, 23 }, -- Enter
                    { 0, 75 }, -- Exit Vehicle
                    { 0, 71 }, -- Accelerate Vehicle
                    { 0, 72 }, -- Vehicle Brake
                    { 0, 59 }, -- Move Vehicle Left and Right
                    { 0, 89 }, -- Fly Yaw Left
                    { 0, 9 }, -- Fly Left and Right
                    { 0, 8 }, -- Fly Up and Down
                    { 0, 90 }, -- Fly Yaw Right
                    { 0, 76 }, -- Vehicle Handbrake
                },
            },
        }
    }

    if Subtitle ~= "" and Subtitle ~= nil then
        _UIMenu.Subtitle.Rectangle = UIResRectangle.New(0 + _UIMenu.Position.X, 107 + _UIMenu.Position.Y, 431, 37, 0, 0, 0, 255)
        _UIMenu.Subtitle.Text = UIResText.New(Subtitle, 8 + _UIMenu.Position.X, 110 + _UIMenu.Position.Y, 0.35, 245, 245, 245, 255, 0)
        _UIMenu.Subtitle.BackupText = Subtitle
        _UIMenu.Subtitle.Formatted = false
        if string.starts(Subtitle, "~") then
            _UIMenu.PageCounter.PreText = string.sub(Subtitle, 1, 3)
        end
        _UIMenu.PageCounter.Text = UIResText.New("", 425 + _UIMenu.Position.X, 110 + _UIMenu.Position.Y, 0.35, 245, 245, 245, 255, 0, "Right")
        _UIMenu.Subtitle.ExtraY = 37
    end

    _UIMenu.ArrowSprite = Sprite.New("commonmenu", "shop_arrows_upanddown", 190 + _UIMenu.Position.X, 147 + 37 * (_UIMenu.Pagination.Total + 1) + _UIMenu.Position.Y - 37 + _UIMenu.Subtitle.ExtraY, 40, 40)
    _UIMenu.Extra.Up = UIResRectangle.New(0 + _UIMenu.Position.X, 144 + 38 * (_UIMenu.Pagination.Total + 1) + _UIMenu.Position.Y - 37 + _UIMenu.Subtitle.ExtraY, 431, 18, 0, 0, 0, 200)
    _UIMenu.Extra.Down = UIResRectangle.New(0 + _UIMenu.Position.X, 144 + 18 + 38 * (_UIMenu.Pagination.Total + 1) + _UIMenu.Position.Y - 37 + _UIMenu.Subtitle.ExtraY, 431, 18, 0, 0, 0, 200)

    _UIMenu.Description.Bar = UIResRectangle.New(_UIMenu.Position.X, 123, 431, 4, 0, 0, 0, 255)
    _UIMenu.Description.Rectangle = Sprite.New("commonmenu", "gradient_bgd", _UIMenu.Position.X, 127, 431, 30)
    _UIMenu.Description.Text = UIResText.New("Description", _UIMenu.Position.X + 5, 125, 0.35)

    _UIMenu.Background = Sprite.New("commonmenu", "gradient_bgd", _UIMenu.Position.X, 144 + _UIMenu.Position.Y - 37 + _UIMenu.Subtitle.ExtraY, 290, 25)

    if _UIMenu.BetterSize == true then
        _UIMenu.WidthOffset = math.floor(tonumber(69))
        _UIMenu.Logo:Size(431 + _UIMenu.WidthOffset, 107)
        _UIMenu.Title:Position(((_UIMenu.WidthOffset + 431) / 2) + _UIMenu.Position.X, 20 + _UIMenu.Position.Y)
        if _UIMenu.Subtitle.Rectangle ~= nil then
            _UIMenu.Subtitle.Rectangle:Size(431 + _UIMenu.WidthOffset + 100, 37)
            _UIMenu.PageCounter.Text:Position(425 + _UIMenu.Position.X + _UIMenu.WidthOffset, 110 + _UIMenu.Position.Y)
        end
        if _UIMenu.Banner ~= nil then
            _UIMenu.Banner:Size(431 + _UIMenu.WidthOffset, 107)
        end
    end

    Citizen.CreateThread(function()
        if not HasScaleformMovieLoaded(_UIMenu.InstructionalScaleform) then
            _UIMenu.InstructionalScaleform = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
            while not HasScaleformMovieLoaded(_UIMenu.InstructionalScaleform) do
                Citizen.Wait(0)
            end
        end
    end)
    return setmetatable(_UIMenu, UIMenu)
end

---SetMenuWidthOffset
---@param Offset number
---@return number
---@public
function UIMenu:SetMenuWidthOffset(Offset)
    if tonumber(Offset) then
        self.WidthOffset = math.floor(tonumber(Offset) + tonumber(70))
        self.Logo:Size(431 + self.WidthOffset, 107)
        self.Title:Position(((self.WidthOffset + 431) / 2) + self.Position.X, 20 + self.Position.Y)
        if self.Subtitle.Rectangle ~= nil then
            self.Subtitle.Rectangle:Size(431 + self.WidthOffset + 100, 37)
            self.PageCounter.Text:Position(425 + self.Position.X + self.WidthOffset, 110 + self.Position.Y)
        end
        if self.Banner ~= nil then
            self.Banner:Size(431 + self.WidthOffset, 107)
        end
    end
end

---DisEnableControls
---@param bool boolean
---@return nil
---@public
function UIMenu:DisEnableControls(bool)
    if bool then
        EnableAllControlActions(2)
    else
        DisableAllControlActions(2)
    end
    if bool then
        return
    else
        if Controller() then
            for Index = 1, #self.Settings.EnabledControls.Controller do
                EnableControlAction(self.Settings.EnabledControls.Controller[Index][1], self.Settings.EnabledControls.Controller[Index][2], true)
            end
        else
            for Index = 1, #self.Settings.EnabledControls.Keyboard do
                EnableControlAction(self.Settings.EnabledControls.Keyboard[Index][1], self.Settings.EnabledControls.Keyboard[Index][2], true)
            end
        end
    end
end

---InstructionalButtons
---@param bool boolean
---@return nil
---@public
function UIMenu:InstructionalButtons(bool)
    if bool ~= nil then
        self.Settings.InstrucitonalButtons = tobool(bool)
    end
end

---SetBannerSprite
---@param Sprite string
---@param IncludeChildren boolean
---@return nil
---@public
function UIMenu:SetBannerSprite(Sprite, IncludeChildren)
    if Sprite() == "Sprite" then
        self.Logo = Sprite
        self.Logo:Size(431 + self.WidthOffset, 107)
        self.Logo:Position(self.Position.X, self.Position.Y)
        self.Banner = nil
        if IncludeChildren then
            for Item, Menu in pairs(self.Children) do
                Menu.Logo = Sprite
                Menu.Logo:Size(431 + self.WidthOffset, 107)
                Menu.Logo:Position(self.Position.X, self.Position.Y)
                Menu.Banner = nil
            end
        end
    end
end

---SetBannerRectangle
---@param Rectangle string
---@param IncludeChildren boolean
---@return nil
---@public
function UIMenu:SetBannerRectangle(Rectangle, IncludeChildren)
    if Rectangle() == "Rectangle" then
        self.Banner = Rectangle
        self.Banner:Size(431 + self.WidthOffset, 107)
        self.Banner:Position(self.Position.X, self.Position.Y)
        self.Logo = nil
        if IncludeChildren then
            for Item, Menu in pairs(self.Children) do
                Menu.Banner = Rectangle
                Menu.Banner:Size(431 + self.WidthOffset, 107)
                Menu:Position(self.Position.X, self.Position.Y)
                Menu.Logo = nil
            end
        end
    end
end

---CurrentSelection
---@param value number
---@return number
---@public
function UIMenu:CurrentSelection(value)
    if tonumber(value) then
        if #self.Items == 0 then
            self.ActiveItem = 0
        end
        self.Items[self:CurrentSelection()]:Selected(false)
        self.ActiveItem = 1000000 - (1000000 % #self.Items) + tonumber(value)
        if self:CurrentSelection() > self.Pagination.Max then
            self.Pagination.Min = self:CurrentSelection() - self.Pagination.Total
            self.Pagination.Max = self:CurrentSelection()
        elseif self:CurrentSelection() < self.Pagination.Min then
            self.Pagination.Min = self:CurrentSelection()
            self.Pagination.Max = self:CurrentSelection() + self.Pagination.Total
        end
    else
        if #self.Items == 0 then
            return 1
        else
            if self.ActiveItem % #self.Items == 0 then
                return 1
            else
                return self.ActiveItem % #self.Items + 1
            end
        end
    end
end

---CalculateWindowHeight
---@return number
---@public
function UIMenu:CalculateWindowHeight()
    local Height = 0
    for i = 1, #self.Windows do
        Height = Height + self.Windows[i].Background:Size().Height
    end
    return Height
end

---CalculateItemHeightOffset
---@param Item table
---@return number
---@public
function UIMenu:CalculateItemHeightOffset(Item)
    if Item.Base then
        return Item.Base.Rectangle.Height
    else
        return Item.Rectangle.Height
    end
end

---CalculateItemHeight
---@return number
---@public
function UIMenu:CalculateItemHeight()
    local ItemOffset = 0 + self.Subtitle.ExtraY - 37
    for i = self.Pagination.Min + 1, self.Pagination.Max do
        local Item = self.Items[i]
        if Item ~= nil then
            ItemOffset = ItemOffset + self:CalculateItemHeightOffset(Item)
        end
    end

    return ItemOffset
end

---RecalculateDescriptionPosition
---@return nil
---@public
function UIMenu:RecalculateDescriptionPosition()
    local WindowHeight = self:CalculateWindowHeight()
    self.Description.Bar:Position(self.Position.X, 149 + self.Position.Y + WindowHeight)
    self.Description.Rectangle:Position(self.Position.X, 149 + self.Position.Y + WindowHeight)
    self.Description.Text:Position(self.Position.X + 8, 155 + self.Position.Y + WindowHeight)
    self.Description.Bar:Size(431 + self.WidthOffset, 4)
    self.Description.Rectangle:Size(431 + self.WidthOffset, 30)
    self.Description.Bar:Position(self.Position.X, self:CalculateItemHeight() + ((#self.Items > (self.Pagination.Total + 1)) and 37 or 0) + self.Description.Bar:Position().Y)
    self.Description.Rectangle:Position(self.Position.X, self:CalculateItemHeight() + ((#self.Items > (self.Pagination.Total + 1)) and 37 or 0) + self.Description.Rectangle:Position().Y)
    self.Description.Text:Position(self.Position.X + 8, self:CalculateItemHeight() + ((#self.Items > (self.Pagination.Total + 1)) and 37 or 0) + self.Description.Text:Position().Y)
end

---CaclulatePanelPosition
---@param HasDescription boolean
---@return number
---@public
function UIMenu:CaclulatePanelPosition(HasDescription)
    local Height = self:CalculateWindowHeight() + 149 + self.Position.Y
    if HasDescription then
        Height = Height + self.Description.Rectangle:Size().Height + 5
    end
    return self:CalculateItemHeight() + ((#self.Items > (self.Pagination.Total + 1)) and 37 or 0) + Height
end

---AddWindow
---@param Window table
---@return nil
---@public
function UIMenu:AddWindow(Window)
    if Window() == "UIMenuWindow" then
        Window:SetParentMenu(self)
        Window:Offset(self.Position.X, self.Position.Y)
        table.insert(self.Windows, Window)
        self.ReDraw = true
        self:RecalculateDescriptionPosition()
    end
end

---RemoveWindowAt
---@param Index table
---@return nil
---@public
function UIMenu:RemoveWindowAt(Index)
    if tonumber(Index) then
        if self.Windows[Index] then
            table.remove(self.Windows, Index)
            self.ReDraw = true
            self:RecalculateDescriptionPosition()
        end
    end
end

---AddItem
---@param Item table
---@return nil
---@public
function UIMenu:AddItem(Item)
    Items = Item
    if #Items == 0 then
        if Item() == "UIMenuItem" then
            local SelectedItem = self:CurrentSelection()
            Item:SetParentMenu(self)
            Item:Offset(self.Position.X, self.Position.Y)
            Item:Position((#self.Items * 25) - 37 + self.Subtitle.ExtraY)
            table.insert(self.Items, Item)
            self:RecalculateDescriptionPosition()
            self:CurrentSelection(SelectedItem)
        end
    end
    for i = 1, #Items, 1 do
        Item = Items[i]
        if Item() == "UIMenuItem" then
            local SelectedItem = self:CurrentSelection()
            Item:SetParentMenu(self)
            Item:Offset(self.Position.X, self.Position.Y)
            Item:Position((#self.Items * 25) - 37 + self.Subtitle.ExtraY)
            table.insert(self.Items, Item)
            self:RecalculateDescriptionPosition()
            self:CurrentSelection(SelectedItem)
        end
    end
end

---GetItemAt
---@param Index table
---@return table
---@public
function UIMenu:GetItemAt(index)
    return self.Items[index]
end

---RemoveItemAt
---@param Index table
---@return nil
---@public
function UIMenu:RemoveItemAt(Index)
    if tonumber(Index) then
        if self.Items[Index] then
            local SelectedItem = self:CurrentSelection()
            if #self.Items > self.Pagination.Total and self.Pagination.Max == #self.Items - 1 then
                self.Pagination.Min = self.Pagination.Min - 1
                self.Pagination.Max = self.Pagination.Max + 1
            end
            table.remove(self.Items, tonumber(Index))
            self:RecalculateDescriptionPosition()
            self:CurrentSelection(SelectedItem)
        end
    end
end

---RefreshIndex
---@return nil
---@public
function UIMenu:RefreshIndex()
    if #self.Items == 0 then
        self.ActiveItem = 1000
        self.Pagination.Max = self.Pagination.Total + 1
        self.Pagination.Min = 0
        return
    end
    self.Items[self:CurrentSelection()]:Selected(false)
    self.ActiveItem = 1000 - (1000 % #self.Items)
    self.Pagination.Max = self.Pagination.Total + 1
    self.Pagination.Min = 0
    self.ReDraw = true
end

---Clear
---@return nil
---@public
function UIMenu:Clear()
    self.Items = {}
    self.ReDraw = true
    self:RecalculateDescriptionPosition()
end

---MultilineFormat
---@param str string
---@return string
---@public
function UIMenu:MultilineFormat(str)
    if tostring(str) then
        local PixelPerLine = 425 + self.WidthOffset
        local AggregatePixels = 0
        local output = ""
        local words = string.split(tostring(str), " ")
        for i = 1, #words do
            local offset = MeasureStringWidth(words[i], 0, 0.30)
            AggregatePixels = AggregatePixels + offset
            if AggregatePixels > PixelPerLine then
                output = output .. "\n" .. words[i] .. " "
                AggregatePixels = offset + MeasureString(" ")
            else
                output = output .. words[i] .. " "
                AggregatePixels = AggregatePixels + MeasureString(" ")
            end
        end

        return output
    end
end

---DrawCalculations
---@return nil
---@public
function UIMenu:DrawCalculations()
    local WindowHeight = self:CalculateWindowHeight()
    if self.Settings.MultilineFormats then
        if self.Subtitle.Rectangle and not self.Subtitle.Formatted then
            self.Subtitle.Formatted = true
            self.Subtitle.Text:Text(self:MultilineFormat(self.Subtitle.Text:Text()))
            local Linecount = #string.split(self.Subtitle.Text:Text(), "\n")
            self.Subtitle.ExtraY = ((Linecount == 1) and 37 or ((Linecount + 1) * 22))
            self.Subtitle.Rectangle:Size(431 + self.WidthOffset, self.Subtitle.ExtraY)
        end
    elseif self.Subtitle.Formatted then
        self.Subtitle.Formatted = false
        self.Subtitle.ExtraY = 37
        self.Subtitle.Rectangle:Size(431 + self.WidthOffset, self.Subtitle.ExtraY)
        self.Subtitle.Text:Text(self.Subtitle.BackupText)
    end

    self.Background:Size(431 + self.WidthOffset, self:CalculateItemHeight() + WindowHeight + ((self.Subtitle.ExtraY > 0) and 0 or 37))

    self.Extra.Up:Size(431 + self.WidthOffset, 18)
    self.Extra.Down:Size(431 + self.WidthOffset, 18)

    local offsetExtra = 4
    self.Extra.Up:Position(self.Position.X, 144 + self:CalculateItemHeight() + self.Position.Y + WindowHeight + offsetExtra)
    self.Extra.Down:Position(self.Position.X, 144 + 18 + self:CalculateItemHeight() + self.Position.Y + WindowHeight + offsetExtra)

    if self.WidthOffset > 0 then
        self.ArrowSprite:Position(190 + self.Position.X + (self.WidthOffset / 2), 141 + self:CalculateItemHeight() + self.Position.Y + WindowHeight + offsetExtra)
    else
        self.ArrowSprite:Position(190 + self.Position.X + self.WidthOffset, 141 + self:CalculateItemHeight() + self.Position.Y + WindowHeight + offsetExtra)
    end

    self.ReDraw = false

    if #self.Items ~= 0 and self.Items[self:CurrentSelection()]:Description() ~= "" then
        self:RecalculateDescriptionPosition()
        local description = self.Items[self:CurrentSelection()]:Description()
        if self.Settings.MultilineFormats then
            self.Description.Text:Text(self:MultilineFormat(description))
        else
            self.Description.Text:Text(description)
        end
        local Linecount = #string.split(self.Description.Text:Text(), "\n")
        self.Description.Rectangle:Size(431 + self.WidthOffset, ((Linecount == 1) and 37 or ((Linecount + 1) * 22)))
    end
end

---Visible
---@param bool boolean
---@return boolean
---@public
function UIMenu:Visible(bool)
    if bool ~= nil then
        self._Visible = tobool(bool)
        self.JustOpened = tobool(bool)
        self.Dirty = tobool(bool)
        self:UpdateScaleform()
        if self.ParentMenu ~= nil or tobool(bool) == false then
            return
        end
        if self.Settings.ResetCursorOnOpen then
            local W, H = GetActiveScreenResolution()
            SetCursorLocation(W / 2, H / 2)
            SetCursorSprite(1)
        end
    else
        return self._Visible
    end
end

---ProcessControl
---@return nil
---@public
function UIMenu:ProcessControl()
    if not self._Visible then
        return
    end
    if self.JustOpened then
        self.JustOpened = false
        return
    end
    if self.Controls.Back.Enabled and (IsDisabledControlJustReleased(0, 177) or IsDisabledControlJustReleased(1, 177) or IsDisabledControlJustReleased(2, 177) or IsDisabledControlJustReleased(0, 199) or IsDisabledControlJustReleased(1, 199) or IsDisabledControlJustReleased(2, 199)) then
        self:GoBack()
    end
    if #self.Items == 0 then
        return
    end
    if not self.UpPressed then
        if self.Controls.Up.Enabled and (IsDisabledControlJustPressed(0, 172) or IsDisabledControlJustPressed(1, 172) or IsDisabledControlJustPressed(2, 172) or IsDisabledControlJustPressed(0, 241) or IsDisabledControlJustPressed(1, 241) or IsDisabledControlJustPressed(2, 241) or IsDisabledControlJustPressed(2, 241)) then
            Citizen.CreateThread(function()
                self.UpPressed = true
                if #self.Items > self.Pagination.Total + 1 then
                    self:GoUpOverflow()
                else
                    self:GoUp()
                end
                self:UpdateScaleform()
                Citizen.Wait(175)
                while self.Controls.Up.Enabled and (IsDisabledControlPressed(0, 172) or IsDisabledControlPressed(1, 172) or IsDisabledControlPressed(2, 172) or IsDisabledControlPressed(0, 241) or IsDisabledControlPressed(1, 241) or IsDisabledControlPressed(2, 241) or IsDisabledControlPressed(2, 241)) do
                    if #self.Items > self.Pagination.Total + 1 then
                        self:GoUpOverflow()
                    else
                        self:GoUp()
                    end
                    self:UpdateScaleform()
                    Citizen.Wait(125)
                end
                self.UpPressed = false
            end)
        end
    end
    if not self.DownPressed then
        if self.Controls.Down.Enabled and (IsDisabledControlJustPressed(0, 173) or IsDisabledControlJustPressed(1, 173) or IsDisabledControlJustPressed(2, 173) or IsDisabledControlJustPressed(0, 242) or IsDisabledControlJustPressed(1, 242) or IsDisabledControlJustPressed(2, 242)) then
            Citizen.CreateThread(function()
                self.DownPressed = true
                if #self.Items > self.Pagination.Total + 1 then
                    self:GoDownOverflow()
                else
                    self:GoDown()
                end
                self:UpdateScaleform()
                Citizen.Wait(175)
                while self.Controls.Down.Enabled and (IsDisabledControlPressed(0, 173) or IsDisabledControlPressed(1, 173) or IsDisabledControlPressed(2, 173) or IsDisabledControlPressed(0, 242) or IsDisabledControlPressed(1, 242) or IsDisabledControlPressed(2, 242)) do
                    if #self.Items > self.Pagination.Total + 1 then
                        self:GoDownOverflow()
                    else
                        self:GoDown()
                    end
                    self:UpdateScaleform()
                    Citizen.Wait(125)
                end
                self.DownPressed = false
            end)
        end
    end
    if not self.LeftPressed then
        if self.Controls.Left.Enabled and (IsDisabledControlPressed(0, 174) or IsDisabledControlPressed(1, 174) or IsDisabledControlPressed(2, 174)) then
            local type, subtype = self.Items[self:CurrentSelection()]()
            Citizen.CreateThread(function()
                if (subtype == "UIMenuSliderHeritageItem") then
                    self.LeftPressed = true
                    self:GoLeft()
                    Citizen.Wait(40)
                    while self.Controls.Left.Enabled and (IsDisabledControlPressed(0, 174) or IsDisabledControlPressed(1, 174) or IsDisabledControlPressed(2, 174)) do
                        self:GoLeft()
                        Citizen.Wait(20)
                    end
                    self.LeftPressed = false
                else
                    self.LeftPressed = true
                    self:GoLeft()
                    Citizen.Wait(175)
                    while self.Controls.Left.Enabled and (IsDisabledControlPressed(0, 174) or IsDisabledControlPressed(1, 174) or IsDisabledControlPressed(2, 174)) do
                        self:GoLeft()
                        Citizen.Wait(175)
                    end
                    self.LeftPressed = false
                end
            end)
        end
    end
    if not self.RightPressed then
        if self.Controls.Right.Enabled and (IsDisabledControlPressed(0, 175) or IsDisabledControlPressed(1, 175) or IsDisabledControlPressed(2, 175)) then
            Citizen.CreateThread(function()
                local type, subtype = self.Items[self:CurrentSelection()]()
                if (subtype == "UIMenuSliderHeritageItem") then
                    self.RightPressed = true
                    self:GoRight()
                    Citizen.Wait(40)
                    while self.Controls.Right.Enabled and (IsDisabledControlPressed(0, 175) or IsDisabledControlPressed(1, 175) or IsDisabledControlPressed(2, 175)) do
                        self:GoRight()
                        Citizen.Wait(20)
                    end
                    self.RightPressed = false
                else
                    self.RightPressed = true
                    self:GoRight()
                    Citizen.Wait(175)
                    while self.Controls.Right.Enabled and (IsDisabledControlPressed(0, 175) or IsDisabledControlPressed(1, 175) or IsDisabledControlPressed(2, 175)) do
                        self:GoRight()
                        Citizen.Wait(175)
                    end
                    self.RightPressed = false
                end
            end)
        end
    end
    if self.Controls.Select.Enabled and (IsDisabledControlJustPressed(0, 201) or IsDisabledControlJustPressed(1, 201) or IsDisabledControlJustPressed(2, 201)) then
        self:SelectItem()
    end
end

---GoUpOverflow
---@return nil
---@public
function UIMenu:GoUpOverflow()
    if #self.Items <= self.Pagination.Total + 1 then
        return
    end
    if self:CurrentSelection() <= self.Pagination.Min + 1 then
        if self:CurrentSelection() == 1 then
            self.Pagination.Min = #self.Items - (self.Pagination.Total + 1)
            self.Pagination.Max = #self.Items
            self.Items[self:CurrentSelection()]:Selected(false)
            self.ActiveItem = 1000 - (1000 % #self.Items)
            self.ActiveItem = self.ActiveItem + (#self.Items - 1)
            self.Items[self:CurrentSelection()]:Selected(true)
        else
            self.Pagination.Min = self.Pagination.Min - 1
            self.Pagination.Max = self.Pagination.Max - 1
            self.Items[self:CurrentSelection()]:Selected(false)
            self.ActiveItem = self.ActiveItem - 1
            self.Items[self:CurrentSelection()]:Selected(true)
        end
    else
        self.Items[self:CurrentSelection()]:Selected(false)
        self.ActiveItem = self.ActiveItem - 1
        self.Items[self:CurrentSelection()]:Selected(true)
    end
    PlaySoundFrontend(-1, self.Settings.Audio.UpDown, self.Settings.Audio.Library, true)
    self.OnIndexChange(self, self:CurrentSelection())
    self.ReDraw = true
end

---GoUp
---@return nil
---@public
function UIMenu:GoUp()
    if #self.Items > self.Pagination.Total + 1 then
        return
    end
    self.Items[self:CurrentSelection()]:Selected(false)
    self.ActiveItem = self.ActiveItem - 1
    self.Items[self:CurrentSelection()]:Selected(true)
    PlaySoundFrontend(-1, self.Settings.Audio.UpDown, self.Settings.Audio.Library, true)
    self.OnIndexChange(self, self:CurrentSelection())
    self.ReDraw = true
end

---GoDownOverflow
---@return nil
---@public
function UIMenu:GoDownOverflow()
    if #self.Items <= self.Pagination.Total + 1 then
        return
    end

    if self:CurrentSelection() >= self.Pagination.Max then
        if self:CurrentSelection() == #self.Items then
            self.Pagination.Min = 0
            self.Pagination.Max = self.Pagination.Total + 1
            self.Items[self:CurrentSelection()]:Selected(false)
            self.ActiveItem = 1000 - (1000 % #self.Items)
            self.Items[self:CurrentSelection()]:Selected(true)
        else
            self.Pagination.Max = self.Pagination.Max + 1
            self.Pagination.Min = self.Pagination.Max - (self.Pagination.Total + 1)
            self.Items[self:CurrentSelection()]:Selected(false)
            self.ActiveItem = self.ActiveItem + 1
            self.Items[self:CurrentSelection()]:Selected(true)
        end
    else
        self.Items[self:CurrentSelection()]:Selected(false)
        self.ActiveItem = self.ActiveItem + 1
        self.Items[self:CurrentSelection()]:Selected(true)
    end
    PlaySoundFrontend(-1, self.Settings.Audio.UpDown, self.Settings.Audio.Library, true)
    self.OnIndexChange(self, self:CurrentSelection())
    self.ReDraw = true
end

---GoDown
---@return nil
---@public
function UIMenu:GoDown()
    if #self.Items > self.Pagination.Total + 1 then
        return
    end

    self.Items[self:CurrentSelection()]:Selected(false)
    self.ActiveItem = self.ActiveItem + 1
    self.Items[self:CurrentSelection()]:Selected(true)
    PlaySoundFrontend(-1, self.Settings.Audio.UpDown, self.Settings.Audio.Library, true)
    self.OnIndexChange(self, self:CurrentSelection())
    self.ReDraw = true
end

---GoLeft
---@return number
---@public
function UIMenu:GoLeft()
    local type, subtype = self.Items[self:CurrentSelection()]()
    if subtype ~= "UIMenuListItem" and
            subtype ~= "UIMenuSliderItem" and
            subtype ~= "UIMenuProgressItem" and
            subtype ~= "UIMenuSliderHeritageItem" and
            subtype ~= "UIMenuSliderProgressItem" then
        return
    end

    if not self.Items[self:CurrentSelection()]:Enabled() then
        PlaySoundFrontend(-1, self.Settings.Audio.Error, self.Settings.Audio.Library, true)
        return
    end

    if subtype == "UIMenuListItem" then
        local Item = self.Items[self:CurrentSelection()]
        Item:Index(Item._Index - 1)
        self.OnListChange(self, Item, Item._Index)
        Item.OnListChanged(self, Item, Item._Index)
        PlaySoundFrontend(-1, self.Settings.Audio.LeftRight, self.Settings.Audio.Library, true)
    elseif subtype == "UIMenuSliderItem" then
        local Item = self.Items[self:CurrentSelection()]
        Item:Index(Item._Index - 1)
        self.OnSliderChange(self, Item, Item:Index())
        Item.OnSliderChanged(self, Item, Item._Index)
        PlaySoundFrontend(-1, self.Settings.Audio.LeftRight, self.Settings.Audio.Library, true)
    elseif subtype == "UIMenuSliderProgressItem" then
        local Item = self.Items[self:CurrentSelection()]
        Item:Index(Item._Index - 1)
        self.OnSliderChange(self, Item, Item:Index())
        Item.OnSliderChanged(self, Item, Item._Index)
        PlaySoundFrontend(-1, self.Settings.Audio.LeftRight, self.Settings.Audio.Library, true)
    elseif subtype == "UIMenuProgressItem" then
        local Item = self.Items[self:CurrentSelection()]
        Item:Index(Item.Data.Index - 1)
        self.OnProgressChange(self, Item, Item.Data.Index)
        Item.OnProgressChanged(self, Item, Item.Data.Index)
        PlaySoundFrontend(-1, self.Settings.Audio.LeftRight, self.Settings.Audio.Library, true)
    elseif subtype == "UIMenuSliderHeritageItem" then
        local Item = self.Items[self:CurrentSelection()]
        Item:Index(Item._Index - 0.1)
        self.OnSliderChange(self, Item, Item:Index())
        Item.OnSliderChanged(self, Item, Item._Index)
        if not Item.Pressed then
            Item.Pressed = true
            Citizen.CreateThread(function()
                Item.Audio.Id = GetSoundId()
                PlaySoundFrontend(Item.Audio.Id, Item.Audio.Slider, Item.Audio.Library, 1)
                Citizen.Wait(100)
                StopSound(Item.Audio.Id)
                ReleaseSoundId(Item.Audio.Id)
                Item.Pressed = false
            end)
        end

    end
end

---GoRight
---@return nil
---@public
function UIMenu:GoRight()
    local type, subtype = self.Items[self:CurrentSelection()]()
    if subtype ~= "UIMenuListItem" and
            subtype ~= "UIMenuSliderItem" and
            subtype ~= "UIMenuProgressItem" and
            subtype ~= "UIMenuSliderHeritageItem" and
            subtype ~= "UIMenuSliderProgressItem" then
        return
    end
    if not self.Items[self:CurrentSelection()]:Enabled() then
        PlaySoundFrontend(-1, self.Settings.Audio.Error, self.Settings.Audio.Library, true)
        return
    end
    if subtype == "UIMenuListItem" then
        local Item = self.Items[self:CurrentSelection()]
        Item:Index(Item._Index + 1)
        self.OnListChange(self, Item, Item._Index)
        Item.OnListChanged(self, Item, Item._Index)
        PlaySoundFrontend(-1, self.Settings.Audio.LeftRight, self.Settings.Audio.Library, true)
    elseif subtype == "UIMenuSliderItem" then
        local Item = self.Items[self:CurrentSelection()]
        Item:Index(Item._Index + 1)
        self.OnSliderChange(self, Item, Item:Index())
        Item.OnSliderChanged(self, Item, Item._Index)
        PlaySoundFrontend(-1, self.Settings.Audio.LeftRight, self.Settings.Audio.Library, true)
    elseif subtype == "UIMenuSliderProgressItem" then
        local Item = self.Items[self:CurrentSelection()]
        Item:Index(Item._Index + 1)
        self.OnSliderChange(self, Item, Item:Index())
        Item.OnSliderChanged(self, Item, Item._Index)
        PlaySoundFrontend(-1, self.Settings.Audio.LeftRight, self.Settings.Audio.Library, true)
    elseif subtype == "UIMenuProgressItem" then
        local Item = self.Items[self:CurrentSelection()]
        Item:Index(Item.Data.Index + 1)
        self.OnProgressChange(self, Item, Item.Data.Index)
        Item.OnProgressChanged(self, Item, Item.Data.Index)
        PlaySoundFrontend(-1, self.Settings.Audio.LeftRight, self.Settings.Audio.Library, true)
    elseif subtype == "UIMenuSliderHeritageItem" then
        local Item = self.Items[self:CurrentSelection()]
        Item:Index(Item._Index + 0.1)
        self.OnSliderChange(self, Item, Item:Index())
        Item.OnSliderChanged(self, Item, Item._Index)
        if not Item.Pressed then
            Item.Pressed = true
            Citizen.CreateThread(function()
                Item.Audio.Id = GetSoundId()
                PlaySoundFrontend(Item.Audio.Id, Item.Audio.Slider, Item.Audio.Library, 1)
                Citizen.Wait(100)
                StopSound(Item.Audio.Id)
                ReleaseSoundId(Item.Audio.Id)
                Item.Pressed = false
            end)
        end
    end
end

---SelectItem
---@return nil
---@public
function UIMenu:SelectItem()
    if not self.Items[self:CurrentSelection()]:Enabled() then
        PlaySoundFrontend(-1, self.Settings.Audio.Error, self.Settings.Audio.Library, true)
        return
    end
    local Item = self.Items[self:CurrentSelection()]
    local type, subtype = Item()
    if subtype == "UIMenuCheckboxItem" then
        Item.Checked = not Item.Checked
        PlaySoundFrontend(-1, self.Settings.Audio.Select, self.Settings.Audio.Library, true)
        self.OnCheckboxChange(self, Item, Item.Checked)
        Item.CheckboxEvent(self, Item, Item.Checked)
    elseif subtype == "UIMenuListItem" then
        PlaySoundFrontend(-1, self.Settings.Audio.Select, self.Settings.Audio.Library, true)
        self.OnListSelect(self, Item, Item._Index)
        Item.OnListSelected(self, Item, Item._Index)
    elseif subtype == "UIMenuSliderItem" then
        PlaySoundFrontend(-1, self.Settings.Audio.Select, self.Settings.Audio.Library, true)
        self.OnSliderSelect(self, Item, Item._Index)
        Item.OnSliderSelected(Item._Index)
    elseif subtype == "UIMenuSliderProgressItem" then
        PlaySoundFrontend(-1, self.Settings.Audio.Select, self.Settings.Audio.Library, true)
        self.OnSliderSelect(self, Item, Item._Index)
        Item.OnSliderSelected(Item._Index)
    elseif subtype == "UIMenuProgressItem" then
        PlaySoundFrontend(-1, self.Settings.Audio.Select, self.Settings.Audio.Library, true)
        self.OnProgressSelect(self, Item, Item.Data.Index)
        Item.OnProgressSelected(Item.Data.Index)
    elseif subtype == "UIMenuSliderHeritageItem" then
        PlaySoundFrontend(-1, self.Settings.Audio.Select, self.Settings.Audio.Library, true)
        self.OnSliderSelect(self, Item, Item._Index)
        Item.OnSliderSelected(Item._Index)
    else
        PlaySoundFrontend(-1, self.Settings.Audio.Select, self.Settings.Audio.Library, true)
        self.OnItemSelect(self, Item, self:CurrentSelection())
        Item.Activated(self, Item)
        if not self.Children[Item] then
            return
        end
        self:Visible(false)
        self.Children[Item]:Visible(true)
        self.OnMenuChanged(self, self.Children[self.Items[self:CurrentSelection()]], true)
    end
end

---GoBack
---@return nil
---@public
function UIMenu:GoBack()
    PlaySoundFrontend(-1, self.Settings.Audio.Back, self.Settings.Audio.Library, true)
    self:Visible(false)
    if self.ParentMenu ~= nil then
        self.ParentMenu:Visible(true)
        self.OnMenuChanged(self, self.ParentMenu, false)
        if self.Settings.ResetCursorOnOpen then
            local W, H = GetActiveScreenResolution()
            SetCursorLocation(W / 2, H / 2)
        end
    end
    self.OnMenuClosed(self)
end

---BindMenuToItem
---@param Menu table
---@param Item table
---@return nil
---@public
function UIMenu:BindMenuToItem(Menu, Item)
    if Menu() == "UIMenu" and Item() == "UIMenuItem" then
        Menu.ParentMenu = self
        Menu.ParentItem = Item
        self.Children[Item] = Menu
    end
end

---ReleaseMenuFromItem
---@param Item table
---@return boolean
---@public
function UIMenu:ReleaseMenuFromItem(Item)
    if Item() == "UIMenuItem" then
        if not self.Children[Item] then
            return false
        end
        self.Children[Item].ParentMenu = nil
        self.Children[Item].ParentItem = nil
        self.Children[Item] = nil
        return true
    end
end

---PageCounterName
---@param text string
---@return nil
---@public
function UIMenu:PageCounterName(String)
    self.PageCounter.isCustom = true
    self.PageCounter.PreText = String
    self.PageCounter.Text:Text(self.PageCounter.PreText)
    self.PageCounter.Text:Draw()
end

---Draw
---@return nil
---@public
function UIMenu:Draw()
    if not self._Visible then
        return
    end
    HideHudComponentThisFrame(19)
    if self.Settings.ControlDisablingEnabled then
        self:DisEnableControls(false)
    end
    if self.Settings.InstructionalButtons then
        DrawScaleformMovieFullscreen(self.InstructionalScaleform, 255, 255, 255, 255, 0)
    end
    if self.Settings.ScaleWithSafezone then
        SetScriptGfxAlign(76, 84)
        SetScriptGfxAlignParams(0, 0, 0, 0)
        if self.Settings.DrawOrder ~= nil then
            SetScriptGfxDrawOrder(tonumber(self.Settings.DrawOrder))
        end
        self.DrawOffset.X, self.DrawOffset.Y = GetScriptGfxPosition(0,0)
    end
    if self.ReDraw then
        self:DrawCalculations()
    end
    if self.Logo then
        self.Logo:Draw()
    elseif self.Banner then
        self.Banner:Draw()
    end
    self.Title:Draw()
    if self.Subtitle.Rectangle then
        self.Subtitle.Rectangle:Draw()
        self.Subtitle.Text:Draw()
    end
    if #self.Items ~= 0 or #self.Windows ~= 0 then
        self.Background:Draw()
    end
    if #self.Windows ~= 0 then
        local WindowOffset = 0
        for index = 1, #self.Windows do
            if self.Windows[index - 1] then
                WindowOffset = WindowOffset + self.Windows[index - 1].Background:Size().Height
            end
            local Window = self.Windows[index]
            Window:Position(WindowOffset + self.Subtitle.ExtraY - 37)
            Window:Draw()
        end
    end
    if #self.Items == 0 then
        if self.Settings.ScaleWithSafezone then
            ResetScriptGfxAlign()
        end
        return
    end

    local CurrentSelection = self:CurrentSelection()
    self.Items[CurrentSelection]:Selected(true)

    if self.Items[CurrentSelection]:Description() ~= "" then
        self.Description.Bar:Draw()
        self.Description.Rectangle:Draw()
        self.Description.Text:Draw()
    end

    if self.Items[CurrentSelection].Panels ~= nil then
        if #self.Items[CurrentSelection].Panels ~= 0 then
            local PanelOffset = self:CaclulatePanelPosition(self.Items[CurrentSelection]:Description() ~= "")
            for index = 1, #self.Items[CurrentSelection].Panels do
                if self.Items[CurrentSelection].Panels[index - 1] then
                    PanelOffset = PanelOffset + self.Items[CurrentSelection].Panels[index - 1].Background:Size().Height + 5
                end
                self.Items[CurrentSelection].Panels[index]:Position(PanelOffset)
                self.Items[CurrentSelection].Panels[index]:Draw()
            end
        end
    end

    local WindowHeight = self:CalculateWindowHeight()

    if #self.Items <= self.Pagination.Total + 1 then
        local ItemOffset = self.Subtitle.ExtraY - 37 + WindowHeight
        for index = 1, #self.Items do
            local Item = self.Items[index]
            Item:Position(ItemOffset)
            Item:Draw()
            ItemOffset = ItemOffset + self:CalculateItemHeightOffset(Item)
        end
    else
        local ItemOffset = self.Subtitle.ExtraY - 37 + WindowHeight
        for index = self.Pagination.Min + 1, self.Pagination.Max, 1 do
            if self.Items[index] then
                local Item = self.Items[index]
                Item:Position(ItemOffset)
                Item:Draw()
                ItemOffset = ItemOffset + self:CalculateItemHeightOffset(Item)
            end
        end

        self.Extra.Up:Draw()
        self.Extra.Down:Draw()
        self.ArrowSprite:Draw()

        if self.PageCounter.isCustom ~= true then
            if self.PageCounter.Text ~= nil then
                local Caption = self.PageCounter.PreText .. CurrentSelection .. " / " .. #self.Items
                self.PageCounter.Text:Text(Caption)
                self.PageCounter.Text:Draw()
            end
        end
    end

    if self.PageCounter.isCustom ~= false then
        if self.PageCounter.Text ~= nil then
            self.PageCounter.Text:Text(self.PageCounter.PreText)
            self.PageCounter.Text:Draw()
        end
    end

    if self.Settings.ScaleWithSafezone then
        ResetScriptGfxAlign()
    end
end

---ProcessMouse
---@return nil
---@public
function UIMenu:ProcessMouse()
    if not self._Visible or self.JustOpened or #self.Items == 0 or tobool(Controller()) or not self.Settings.MouseControlsEnabled then
        EnableControlAction(0, 2, true)
        EnableControlAction(0, 1, true)
        EnableControlAction(0, 25, true)
        EnableControlAction(0, 24, true)
        if self.Dirty then
            for _, Item in pairs(self.Items) do
                if Item:Hovered() then
                    Item:Hovered(false)
                end
            end
        end
        return
    end

    local WindowHeight = self:CalculateWindowHeight()
    local Limit = #self.Items
    local ItemOffset = 0

    ShowCursorThisFrame()

    if #self.Items > self.Pagination.Total + 1 then
        Limit = self.Pagination.Max
    end

    local W, H = GetResolution()

    if IsMouseInBounds(0, 0, 30, H) and self.Settings.MouseEdgeEnabled then
        SetGameplayCamRelativeHeading(GetGameplayCamRelativeHeading() + 5)
        SetCursorSprite(6)
    elseif IsMouseInBounds(W - 30, 0, 30, H) and self.Settings.MouseEdgeEnabled then
        SetGameplayCamRelativeHeading(GetGameplayCamRelativeHeading() - 5)
        SetCursorSprite(7)
    elseif self.Settings.MouseEdgeEnabled then
        SetCursorSprite(1)
    end

    for i = self.Pagination.Min + 1, Limit, 1 do
        local X, Y = self.Position.X, self.Position.Y + 144 - 37 + self.Subtitle.ExtraY + ItemOffset + WindowHeight
        local Item = self.Items[i]
        local Type, SubType = Item()
        local Width, Height = 431 + self.WidthOffset, self:CalculateItemHeightOffset(Item)

        if IsMouseInBounds(X, Y, Width, Height, self.DrawOffset) then
            Item:Hovered(true)
            if not self.Controls.MousePressed then
                if IsDisabledControlJustPressed(0, 24) then
                    Citizen.CreateThread(function()
                        local _X, _Y, _Width, _Height = X, Y, Width, Height
                        self.Controls.MousePressed = true
                        if Item:Selected() and Item:Enabled() then
                            if SubType == "UIMenuListItem" then
                                if IsMouseInBounds(Item.LeftArrow.X, Item.LeftArrow.Y, Item.LeftArrow.Width, Item.LeftArrow.Height, self.DrawOffset) then
                                    self:GoLeft()
                                elseif not IsMouseInBounds(Item.RightArrow.X, Item.RightArrow.Y, Item.RightArrow.Width, Item.RightArrow.Height, self.DrawOffset) then
                                    self:SelectItem()
                                end
                                if IsMouseInBounds(Item.RightArrow.X, Item.RightArrow.Y, Item.RightArrow.Width, Item.RightArrow.Height, self.DrawOffset) then
                                    self:GoRight()
                                elseif not IsMouseInBounds(Item.LeftArrow.X, Item.LeftArrow.Y, Item.LeftArrow.Width, Item.LeftArrow.Height, self.DrawOffset) then
                                    self:SelectItem()
                                end
                            elseif SubType == "UIMenuSliderItem" then
                                if IsMouseInBounds(Item.LeftArrow.X, Item.LeftArrow.Y, Item.LeftArrow.Width, Item.LeftArrow.Height, self.DrawOffset) then
                                    self:GoLeft()
                                elseif not IsMouseInBounds(Item.RightArrow.X, Item.RightArrow.Y, Item.RightArrow.Width, Item.RightArrow.Height, self.DrawOffset) then
                                    self:SelectItem()
                                end
                                if IsMouseInBounds(Item.RightArrow.X, Item.RightArrow.Y, Item.RightArrow.Width, Item.RightArrow.Height, self.DrawOffset) then
                                    self:GoRight()
                                elseif not IsMouseInBounds(Item.LeftArrow.X, Item.LeftArrow.Y, Item.LeftArrow.Width, Item.LeftArrow.Height, self.DrawOffset) then
                                    self:SelectItem()
                                end
                            elseif SubType == "UIMenuSliderProgressItem" then
                                if IsMouseInBounds(Item.LeftArrow.X, Item.LeftArrow.Y, Item.LeftArrow.Width, Item.LeftArrow.Height, self.DrawOffset) then
                                    self:GoLeft()
                                elseif not IsMouseInBounds(Item.RightArrow.X, Item.RightArrow.Y, Item.RightArrow.Width, Item.RightArrow.Height, self.DrawOffset) then
                                    self:SelectItem()
                                end
                                if IsMouseInBounds(Item.RightArrow.X, Item.RightArrow.Y, Item.RightArrow.Width, Item.RightArrow.Height, self.DrawOffset) then
                                    self:GoRight()
                                elseif not IsMouseInBounds(Item.LeftArrow.X, Item.LeftArrow.Y, Item.LeftArrow.Width, Item.LeftArrow.Height, self.DrawOffset) then
                                    self:SelectItem()
                                end
                            elseif SubType == "UIMenuSliderHeritageItem" then
                                if IsMouseInBounds(Item.LeftArrow.X, Item.LeftArrow.Y, Item.LeftArrow.Width, Item.LeftArrow.Height, self.DrawOffset) then
                                    self:GoLeft()
                                elseif not IsMouseInBounds(Item.RightArrow.X, Item.RightArrow.Y, Item.RightArrow.Width, Item.RightArrow.Height, self.DrawOffset) then
                                    self:SelectItem()
                                end
                                if IsMouseInBounds(Item.RightArrow.X, Item.RightArrow.Y, Item.RightArrow.Width, Item.RightArrow.Height, self.DrawOffset) then
                                    self:GoRight()
                                elseif not IsMouseInBounds(Item.LeftArrow.X, Item.LeftArrow.Y, Item.LeftArrow.Width, Item.LeftArrow.Height, self.DrawOffset) then
                                    self:SelectItem()
                                end
                            elseif SubType == "UIMenuProgressItem" then
                                if IsMouseInBounds(Item.Bar.X, Item.Bar.Y - 12, Item.Data.Max, Item.Bar.Height + 24, self.DrawOffset) then
                                    local CursorX, CursorY = ConvertToPixel(GetControlNormal(0, 239), 0)
                                    Item:CalculateProgress(CursorX)
                                    self.OnProgressChange(self, Item, Item.Data.Index)
                                    Item.OnProgressChanged(self, Item, Item.Data.Index)
                                    if not Item.Pressed then
                                        Item.Pressed = true
                                        Citizen.CreateThread(function()
                                            Item.Audio.Id = GetSoundId()
                                            PlaySoundFrontend(Item.Audio.Id, Item.Audio.Slider, Item.Audio.Library, 1)
                                            Citizen.Wait(100)
                                            StopSound(Item.Audio.Id)
                                            ReleaseSoundId(Item.Audio.Id)
                                            Item.Pressed = false
                                        end)
                                    end
                                else
                                    self:SelectItem()
                                end
                            else
                                self:SelectItem()
                            end
                        elseif not Item:Selected() then
                            self:CurrentSelection(i - 1)
                            PlaySoundFrontend(-1, self.Settings.Audio.Error, self.Settings.Audio.Library, true)
                            self.OnIndexChange(self, self:CurrentSelection())
                            self.ReDraw = true
                            self:UpdateScaleform()
                        elseif not Item:Enabled() and Item:Selected() then
                            PlaySoundFrontend(-1, self.Settings.Audio.Error, self.Settings.Audio.Library, true)
                        end
                        Citizen.Wait(175)
                        while IsDisabledControlPressed(0, 24) and IsMouseInBounds(_X, _Y, _Width, _Height, self.DrawOffset) do
                            if Item:Selected() and Item:Enabled() then
                                if SubType == "UIMenuListItem" then
                                    if IsMouseInBounds(Item.LeftArrow.X, Item.LeftArrow.Y, Item.LeftArrow.Width, Item.LeftArrow.Height, self.DrawOffset) then
                                        self:GoLeft()
                                    end
                                    if IsMouseInBounds(Item.RightArrow.X, Item.RightArrow.Y, Item.RightArrow.Width, Item.RightArrow.Height, self.DrawOffset) then
                                        self:GoRight()
                                    end
                                elseif SubType == "UIMenuSliderItem" then
                                    if IsMouseInBounds(Item.LeftArrow.X, Item.LeftArrow.Y, Item.LeftArrow.Width, Item.LeftArrow.Height, self.DrawOffset) then
                                        self:GoLeft()
                                    end
                                    if IsMouseInBounds(Item.RightArrow.X, Item.RightArrow.Y, Item.RightArrow.Width, Item.RightArrow.Height, self.DrawOffset) then
                                        self:GoRight()
                                    end
                                elseif SubType == "UIMenuSliderProgressItem" then
                                    if IsMouseInBounds(Item.LeftArrow.X, Item.LeftArrow.Y, Item.LeftArrow.Width, Item.LeftArrow.Height, self.DrawOffset) then
                                        self:GoLeft()
                                    end
                                    if IsMouseInBounds(Item.RightArrow.X, Item.RightArrow.Y, Item.RightArrow.Width, Item.RightArrow.Height, self.DrawOffset) then
                                        self:GoRight()
                                    end
                                elseif SubType == "UIMenuSliderHeritageItem" then
                                    if IsMouseInBounds(Item.LeftArrow.X, Item.LeftArrow.Y, Item.LeftArrow.Width, Item.LeftArrow.Height, self.DrawOffset) then
                                        self:GoLeft()
                                    end
                                    if IsMouseInBounds(Item.RightArrow.X, Item.RightArrow.Y, Item.RightArrow.Width, Item.RightArrow.Height, self.DrawOffset) then
                                        self:GoRight()
                                    end
                                elseif SubType == "UIMenuProgressItem" then
                                    if IsMouseInBounds(Item.Bar.X, Item.Bar.Y - 12, Item.Data.Max, Item.Bar.Height + 24, self.DrawOffset) then
                                        local CursorX, CursorY = ConvertToPixel(GetControlNormal(0, 239), 0)
                                        Item:CalculateProgress(CursorX)
                                        self.OnProgressChange(self, Item, Item.Data.Index)
                                        Item.OnProgressChanged(self, Item, Item.Data.Index)
                                        if not Item.Pressed then
                                            Item.Pressed = true
                                            Citizen.CreateThread(function()
                                                Item.Audio.Id = GetSoundId()
                                                PlaySoundFrontend(Item.Audio.Id, Item.Audio.Slider, Item.Audio.Library, 1)
                                                Citizen.Wait(100)
                                                StopSound(Item.Audio.Id)
                                                ReleaseSoundId(Item.Audio.Id)
                                                Item.Pressed = false
                                            end)
                                        end
                                    else
                                        self:SelectItem()
                                    end
                                end
                            elseif not Item:Selected() then
                                self:CurrentSelection(i - 1)
                                PlaySoundFrontend(-1, self.Settings.Audio.Error, self.Settings.Audio.Library, true)
                                self.OnIndexChange(self, self:CurrentSelection())
                                self.ReDraw = true
                                self:UpdateScaleform()
                            elseif not Item:Enabled() and Item:Selected() then
                                PlaySoundFrontend(-1, self.Settings.Audio.Error, self.Settings.Audio.Library, true)
                            end
                            Citizen.Wait(125)
                        end
                        self.Controls.MousePressed = false
                    end)
                end
            end
        else
            Item:Hovered(false)
        end
        ItemOffset = ItemOffset + self:CalculateItemHeightOffset(Item)
    end

    local ExtraX, ExtraY = self.Position.X, 144 + self:CalculateItemHeight() + self.Position.Y + WindowHeight

    if #self.Items <= self.Pagination.Total + 1 then
        return
    end

    if IsMouseInBounds(ExtraX, ExtraY, 431 + self.WidthOffset, 18, self.DrawOffset) then
        self.Extra.Up:Colour(30, 30, 30, 255)
        if not self.Controls.MousePressed then
            if IsDisabledControlJustPressed(0, 24) then
                Citizen.CreateThread(function()
                    local _ExtraX, _ExtraY = ExtraX, ExtraY
                    self.Controls.MousePressed = true
                    if #self.Items > self.Pagination.Total + 1 then
                        self:GoUpOverflow()
                    else
                        self:GoUp()
                    end
                    Citizen.Wait(175)
                    while IsDisabledControlPressed(0, 24) and IsMouseInBounds(_ExtraX, _ExtraY, 431 + self.WidthOffset, 18, self.DrawOffset) do
                        if #self.Items > self.Pagination.Total + 1 then
                            self:GoUpOverflow()
                        else
                            self:GoUp()
                        end
                        Citizen.Wait(125)
                    end
                    self.Controls.MousePressed = false
                end)
            end
        end
    else
        self.Extra.Up:Colour(0, 0, 0, 200)
    end

    if IsMouseInBounds(ExtraX, ExtraY + 18, 431 + self.WidthOffset, 18, self.DrawOffset) then
        self.Extra.Down:Colour(30, 30, 30, 255)
        if not self.Controls.MousePressed then
            if IsDisabledControlJustPressed(0, 24) then
                Citizen.CreateThread(function()
                    local _ExtraX, _ExtraY = ExtraX, ExtraY
                    self.Controls.MousePressed = true
                    if #self.Items > self.Pagination.Total + 1 then
                        self:GoDownOverflow()
                    else
                        self:GoDown()
                    end
                    Citizen.Wait(175)
                    while IsDisabledControlPressed(0, 24) and IsMouseInBounds(_ExtraX, _ExtraY + 18, 431 + self.WidthOffset, 18, self.DrawOffset) do
                        if #self.Items > self.Pagination.Total + 1 then
                            self:GoDownOverflow()
                        else
                            self:GoDown()
                        end
                        Citizen.Wait(125)
                    end
                    self.Controls.MousePressed = false
                end)
            end
        end
    else
        self.Extra.Down:Colour(0, 0, 0, 200)
    end
end

---AddInstructionButton
---@param button table
---@return nil
---@public
function UIMenu:AddInstructionButton(button)
    if type(button) == "table" and #button == 2 then
        table.insert(self.InstructionalButtons, button)
    end
end

---RemoveInstructionButton
---@param button table
---@return nil
---@public
function UIMenu:RemoveInstructionButton(button)
    if type(button) == "table" then
        for i = 1, #self.InstructionalButtons do
            if button == self.InstructionalButtons[i] then
                table.remove(self.InstructionalButtons, i)
                break
            end
        end
    else
        if tonumber(button) then
            if self.InstructionalButtons[tonumber(button)] then
                table.remove(self.InstructionalButtons, tonumber(button))
            end
        end
    end
end

---AddEnabledControl
---@param Inputgroup number
---@param Control number
---@param Controller table
---@return nil
---@public
function UIMenu:AddEnabledControl(Inputgroup, Control, Controller)
    if tonumber(Inputgroup) and tonumber(Control) then
        table.insert(self.Settings.EnabledControls[(Controller and "Controller" or "Keyboard")], { Inputgroup, Control })
    end
end

---RemoveEnabledControl
---@param Inputgroup number
---@param Control number
---@param Controller table
---@return nil
---@public
function UIMenu:RemoveEnabledControl(Inputgroup, Control, Controller)
    local Type = (Controller and "Controller" or "Keyboard")
    for Index = 1, #self.Settings.EnabledControls[Type] do
        if Inputgroup == self.Settings.EnabledControls[Type][Index][1] and Control == self.Settings.EnabledControls[Type][Index][2] then
            table.remove(self.Settings.EnabledControls[Type], Index)
            break
        end
    end
end

---UpdateScaleform
---@return nil
---@public
function UIMenu:UpdateScaleform()
    if not self._Visible or not self.Settings.InstructionalButtons then
        return
    end

    PushScaleformMovieFunction(self.InstructionalScaleform, "CLEAR_ALL")
    PopScaleformMovieFunction()

    PushScaleformMovieFunction(self.InstructionalScaleform, "TOGGLE_MOUSE_BUTTONS")
    PushScaleformMovieFunctionParameterInt(0)
    PopScaleformMovieFunction()

    PushScaleformMovieFunction(self.InstructionalScaleform, "CREATE_CONTAINER")
    PopScaleformMovieFunction()

    PushScaleformMovieFunction(self.InstructionalScaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieMethodParameterButtonName(GetControlInstructionalButton(2, 176, 0))
    PushScaleformMovieFunctionParameterString(GetLabelText("HUD_INPUT2"))
    PopScaleformMovieFunction()

    if self.Controls.Back.Enabled then
        PushScaleformMovieFunction(self.InstructionalScaleform, "SET_DATA_SLOT")
        PushScaleformMovieFunctionParameterInt(1)
        PushScaleformMovieMethodParameterButtonName(GetControlInstructionalButton(2, 177, 0))
        PushScaleformMovieFunctionParameterString(GetLabelText("HUD_INPUT3"))
        PopScaleformMovieFunction()
    end

    local count = 2

    for i = 1, #self.InstructionalButtons do
        if self.InstructionalButtons[i] then
            if #self.InstructionalButtons[i] == 2 then
                PushScaleformMovieFunction(self.InstructionalScaleform, "SET_DATA_SLOT")
                PushScaleformMovieFunctionParameterInt(count)
                PushScaleformMovieMethodParameterButtonName(self.InstructionalButtons[i][1])
                PushScaleformMovieFunctionParameterString(self.InstructionalButtons[i][2])
                PopScaleformMovieFunction()
                count = count + 1
            end
        end
    end

    PushScaleformMovieFunction(self.InstructionalScaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PushScaleformMovieFunctionParameterInt(-1)
    PopScaleformMovieFunction()
end
