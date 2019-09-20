---@type table
UITimerBarProgressWithIconItem = setmetatable({}, UITimerBarProgressWithIconItem)

---@type table
UITimerBarProgressWithIconItem.__index = UITimerBarProgressWithIconItem

---@type table
UITimerBarProgressWithIconItem.__call = function()
    return "UITimerBarProgressWithIconItem"
end

---New
---@param Text string
---@param TxtDictionary string
---@param TxtName string
---@param IconDictionary string
---@param IconName string
---@param X number
---@param Y number
---@param Heading number
---@param R number
---@param G number
---@param B number
---@param A number
function UITimerBarProgressWithIconItem.New(TxtDictionary, TxtName, IconDictionary, IconName, X, Y, Heading, R, G, B, A)
    local X, Y = tonumber(X) or 0, tonumber(Y) or 0
    if TxtDictionary ~= nil then
        TxtDictionary = tostring(TxtDictionary) or "timerbars"
    else
        TxtDictionary = "timerbars"
    end
    if TxtName ~= nil then
        TxtName = tostring(TxtName) or "all_black_bg"
    else
        TxtName = "all_black_bg"
    end
    if IconDictionary ~= nil then
        IconDictionary = tostring(IconDictionary) or "mpinventory"
    else
        IconDictionary = "mpinventory"
    end
    if IconName ~= nil then
        IconName = tostring(IconName) or "team_deathmatch"
    else
        IconName = "team_deathmatch"
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
        A = tonumber(A) or 200
    else
        A = 200
    end
    local _UITimerBarProgressWithIconItem = {
        Background = Sprite.New(TxtDictionary, TxtName, 0, 0, 350, 35, Heading, R, G, B, A),
        Icon = Sprite.New(IconDictionary, IconName, 0, 0, 30, 30, 0, 255, 255, 255, 255),
        BackgroundProgressBar = UIResRectangle.New(0, 0, 200, 17, 255, 0, 0, 100),
        ProgressBar = UIResRectangle.New(0, 0, 0, 17, 255, 0, 0, 255),
        Position = { X = 1540, Y = 1060 },
    }
    return setmetatable(_UITimerBarProgressWithIconItem, UITimerBarProgressWithIconItem)
end

---SetTextColor
---@param R number
---@param G number
---@param B number
---@param A number
---@return nil
---@public
function UITimerBarProgressWithIconItem:SetTextColor(R, G, B, A)
    self.Text:Colour(R, G, B, A)
end

---GetPercentage
---@return nil
---@public
function UITimerBarProgressWithIconItem:GetPercentage()
    return math.floor(self.ProgressBar.Width * 1 / 2)
end

---SetPercentage
---@param Number number
---@return nil
---@public
function UITimerBarProgressWithIconItem:SetPercentage(Number)
    if (Number <= 100) then
        self.ProgressBar.Width = Number * 2
    else
        self.ProgressBar.Width = 100 * 2
    end
end

---Draw
---@param Interval number
---@return nil
---@public
function UITimerBarProgressWithIconItem:Draw(Interval)
    self.Background:Position(self.Position.X, self.Position.Y - Interval)
    self.Icon:Position(self.Position.X + 80.0, self.Position.Y - Interval + 2.0)
    self.BackgroundProgressBar:Position(self.Position.X + 142.0, self.Position.Y - Interval + 10.0)
    self.ProgressBar:Position(self.Position.X + 142.0, self.Position.Y - Interval + 10.0)
    self.Background:Draw()
    self.Icon:Draw()
    self.BackgroundProgressBar:Draw()
    self.ProgressBar:Draw()
end