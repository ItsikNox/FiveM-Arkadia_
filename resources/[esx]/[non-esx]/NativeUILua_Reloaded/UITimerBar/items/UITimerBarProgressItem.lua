---@type table
UITimerBarProgressItem = setmetatable({}, UITimerBarProgressItem)

---@type table
UITimerBarProgressItem.__index = UITimerBarProgressItem

---@type table
UITimerBarProgressItem.__call = function()
    return "UITimerBarProgressItem"
end

---New
---@param Text string
---@param TxtDictionary string
---@param TxtName string
---@param X number
---@param Y number
---@param Heading number
---@param R number
---@param G number
---@param B number
---@param A number
---@return table
---@public
function UITimerBarProgressItem.New(Text, TxtDictionary, TxtName, X, Y, Heading, R, G, B, A)
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
    local _UITimerBarProgressItem = {
        Background = Sprite.New(TxtDictionary, TxtName, 0, 0, 350, 35, Heading, R, G, B, A),
        Text = UIResText.New(Text or "N/A", 0, 0, 0.35, 255, 255, 255, 255, 0, "Right"),
        BackgroundProgressBar = UIResRectangle.New(0, 0, 150, 17, 255, 0, 0, 100),
        ProgressBar = UIResRectangle.New(0, 0, 0, 17, 255, 0, 0, 255),
        Position = { X = 1540, Y = 1060 },
    }
    return setmetatable(_UITimerBarProgressItem, UITimerBarProgressItem)
end

---SetTextColor
---@param R number
---@param G number
---@param B number
---@param A number
---@return nil
---@public
function UITimerBarProgressItem:SetTextColor(R, G, B, A)
    self.Text:Colour(R, G, B, A)
end

---GetPercentage
---@return nil
---@public
function UITimerBarProgressItem:GetPercentage()
    return math.floor(self.ProgressBar.Width * 1 / 1.5)
end

---SetPercentage
---@param Number number
---@return nil
---@public
function UITimerBarProgressItem:SetPercentage(Number)
    if (Number <= 100) then
        self.ProgressBar.Width = Number * 1.5
    else
        self.ProgressBar.Width = 100 * 1.5
    end
end

---Draw
---@param Interval number
---@return nil
---@public
function UITimerBarProgressItem:Draw(Interval)
    self.Background:Position(self.Position.X, self.Position.Y - Interval)
    self.Text:Position(self.Position.X + 170.0, self.Position.Y - Interval + 7.0)
    self.BackgroundProgressBar:Position(self.Position.X + 190.0, self.Position.Y - Interval + 10.0)
    self.ProgressBar:Position(self.Position.X + 190.0, self.Position.Y - Interval + 10.0)
    self.Background:Draw()
    self.Text:Draw()
    self.BackgroundProgressBar:Draw()
    self.ProgressBar:Draw()
end