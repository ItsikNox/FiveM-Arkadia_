---@type table
UIMenuStatisticsPanel = setmetatable({}, UIMenuStatisticsPanel)

---@type table
UIMenuStatisticsPanel.__index = UIMenuStatisticsPanel

---@type table
---@return string
UIMenuStatisticsPanel.__call = function()
    return "UIMenuPanel", "UIMenuStatisticsPanel"
end

---New
---@return table
---@public
function UIMenuStatisticsPanel.New()
    local _UIMenuStatisticsPanel = {
        Background = UIResRectangle.New(0, 0, 431, 47, 0, 0, 0, 170),
        Divider = true,
        ParentItem = nil,
        Items = {},
    }
    return setmetatable(_UIMenuStatisticsPanel, UIMenuStatisticsPanel)
end

---AddStatistics
---@param Name string
---@return nil
---@public
function UIMenuStatisticsPanel:AddStatistics(Name)
    local Items = {
        Text = UIResText.New(Name or "", 0, 0, 0.35, 255, 255, 255, 255, 0, "Left"),
        BackgroundProgressBar = UIResRectangle.New(0, 0, 200, 10, 255, 255, 255, 100),
        ProgressBar = UIResRectangle.New(0, 0, 100, 10, 255, 255, 255, 255),
        Divider = {
            [1] = UIResRectangle.New(0, 0, 2, 10, 0, 0, 0, 255),
            [2] = UIResRectangle.New(0, 0, 2, 10, 0, 0, 0, 255),
            [3] = UIResRectangle.New(0, 0, 2, 10, 0, 0, 0, 255),
            [4] = UIResRectangle.New(0, 0, 2, 10, 0, 0, 0, 255),
            [5] = UIResRectangle.New(0, 0, 2, 10, 0, 0, 0, 255),
        },
    }
    table.insert(self.Items, Items)
end

---SetParentItem
---@param Item number
---@return table
---@public
function UIMenuStatisticsPanel:SetParentItem(Item)
    if Item() == "UIMenuItem" then
        self.ParentItem = Item
    else
        return self.ParentItem
    end
end

---SetPercentage
---@param ItemID number
---@param Number number
---@return nil
---@public
function UIMenuStatisticsPanel:SetPercentage(ItemID, Number)
    if ItemID ~= nil then
        if Number <= 0 then
            self.Items[ItemID].ProgressBar.Width = 0
        else
            if Number <= 100 then
                self.Items[ItemID].ProgressBar.Width = Number * 2.0
            else
                self.Items[ItemID].ProgressBar.Width = 100 * 2.0
            end
        end
    else
        error("Missing arguments, ItemID")
    end
end

---GetPercentage
---@param ItemID number
---@return number
---@public
function UIMenuStatisticsPanel:GetPercentage(ItemID)
    if ItemID ~= nil then
        return self.Items[ItemID].ProgressBar.Width * 2.0
    else
        error("Missing arguments, ItemID")
    end
end

---Position
---@param Y number
---@return nil
---@public
function UIMenuStatisticsPanel:Position(Y)
    if tonumber(Y) then
        local ParentOffsetX, ParentOffsetWidth = self.ParentItem:Offset().X, self.ParentItem:SetParentMenu().WidthOffset
        self.Background:Position(ParentOffsetX, Y)
        for i = 1, #self.Items do
            local OffsetItemCount = 40 * i
            self.Items[i].Text:Position(ParentOffsetX + (ParentOffsetWidth / 2) + 13, Y - 34 + OffsetItemCount)
            self.Items[i].BackgroundProgressBar:Position(ParentOffsetX + (ParentOffsetWidth / 2) + 200, Y - 22 + OffsetItemCount)
            self.Items[i].ProgressBar:Position(ParentOffsetX + (ParentOffsetWidth / 2) + 200, Y - 22 + OffsetItemCount)
            if self.Divider ~= false then
                for _ = 1, #self.Items[i].Divider, 1 do
                    local DividerOffsetWidth = _ * 40
                    self.Items[i].Divider[_]:Position(ParentOffsetX + (ParentOffsetWidth / 2) + 200 + DividerOffsetWidth, Y - 22 + OffsetItemCount)
                    self.Background:Size(431 + self.ParentItem:SetParentMenu().WidthOffset, 47 + OffsetItemCount - 39)
                end
            end
        end
    end
end

---Draw
---@return nil
---@public
function UIMenuStatisticsPanel:Draw()
    self.Background:Draw()
    for i = 1, #self.Items do
        self.Items[i].Text:Draw()
        self.Items[i].BackgroundProgressBar:Draw()
        self.Items[i].ProgressBar:Draw()
        for _ = 1, #self.Items[i].Divider do
            self.Items[i].Divider[_]:Draw()
        end
    end
end