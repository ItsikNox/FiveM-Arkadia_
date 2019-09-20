---@type table
UITimerBarItem = setmetatable({}, UITimerBarItem)

---@type table
UITimerBarItem.__index = UITimerBarItem

---@type table
UITimerBarItem.__call = function()
    return "UITimerBarItem"
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
function UITimerBarItem.New(Text, TxtDictionary, TxtName, X, Y, Heading, R, G, B, A)
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
    local _UITimerBarItem = {
        Background = Sprite.New(TxtDictionary, TxtName, 0, 0, 350, 35, Heading, R, G, B, A),
        Text = UIResText.New(Text or "N/A", 0, 0, 0.35, 255, 255, 255, 255, 0, "Right"),
        TextTimerBar = UIResText.New("N/A", 0, 0, 0.45, 255, 255, 255, 255, 0, "Right"),
        Position = { X = 1540, Y = 1060 },
    }
    return setmetatable(_UITimerBarItem, UITimerBarItem)
end

---SetTextTimerBar
---@param Text string
---@return nil
---@public
function UITimerBarItem:SetTextTimerBar(Text)
    self.TextTimerBar:Text(Text)
end

---SetText
---@param Text string
---@return nil
---@public
function UITimerBarItem:SetText(Text)
    self.Text:Text(Text)
end

---SetTextTimerBarColor
---@param R number
---@param G number
---@param B number
---@param A number
---@return nil
---@public
function UITimerBarItem:SetTextTimerBarColor(R, G, B, A)
    self.TextTimerBar:Colour(R, G, B, A)
end

---SetTextColor
---@param R number
---@param G number
---@param B number
---@param A number
---@return nil
---@public
function UITimerBarItem:SetTextColor(R, G, B, A)
    self.Text:Colour(R, G, B, A)
end

---Draw
---@param Interval number
---@return nil
---@public
function UITimerBarItem:Draw(Interval)
    self.Background:Position(self.Position.X, self.Position.Y - Interval)
    self.Text:Position(self.Position.X + 170.0, self.Position.Y - Interval + 7.0)
    self.TextTimerBar:Position(self.Position.X + 340.0, self.Position.Y - Interval)
    self.Background:Draw()
    self.TextTimerBar:Draw()
    self.Text:Draw()
end
