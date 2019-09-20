

---@type table
NativeUI = {}

---CreatePool
---@return table
---@public
function NativeUI.CreatePool()
    return MenuPool.New()
end

---CreateMenu
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
function NativeUI.CreateMenu(Title, Subtitle, X, Y, TxtDictionary, TxtName, Heading, R, G, B, A)
    return UIMenu.New(Title, Subtitle, X, Y, TxtDictionary, TxtName, Heading, R, G, B, A)
end

---CreateItem
---@param Text string
---@param Description string
---@return table
---@public
function NativeUI.CreateItem(Text, Description)
    return UIMenuItem.New(Text, Description)
end

---CreateColouredItem
---@param Text string
---@param Description string
---@param MainColour table
---@param HighlightColour table
---@return table
---@public
function NativeUI.CreateColouredItem(Text, Description, MainColour, HighlightColour)
    return UIMenuColouredItem.New(Text, Description, MainColour, HighlightColour)
end

---CreateCheckboxItem
---@param Text string
---@param Check boolean
---@param Description string
---@return table
---@public
function NativeUI.CreateCheckboxItem(Text, Check, Description, CheckboxStyle)
    return UIMenuCheckboxItem.New(Text, Check, Description, CheckboxStyle)
end

---CreateListItem
---@param Text string
---@param Items number
---@param Index table
---@param Description string
---@return table
---@public
function NativeUI.CreateListItem(Text, Items, Index, Description)
    return UIMenuListItem.New(Text, Items, Index, Description)
end

---CreateSliderItem
---@param Text string
---@param Items number
---@param Index table
---@param Description string
---@param Divider boolean
---@param SliderColors table
---@param BackgroundSliderColors table
---@return table
---@public
function NativeUI.CreateSliderItem(Text, Items, Index, Description, Divider, SliderColors, BackgroundSliderColors)
    return UIMenuSliderItem.New(Text, Items, Index, Description, Divider, SliderColors, BackgroundSliderColors)
end

---CreateSliderHeritageItem
---@param Text string
---@param Items number
---@param Index table
---@param Description string
---@param SliderColors table
---@param BackgroundSliderColors table
---@return table
---@public
function NativeUI.CreateSliderHeritageItem(Text, Items, Index, Description, SliderColors, BackgroundSliderColors)
    return UIMenuSliderHeritageItem.New(Text, Items, Index, Description, SliderColors, BackgroundSliderColors)
end

---CreateSliderProgressItem
---@param Text string
---@param Items number
---@param Index number
---@param Description string
---@param SliderColors table
---@param BackgroundSliderColors table
---@return table
---@public
function NativeUI.CreateSliderProgressItem(Text, Items, Index, Description, SliderColors, BackgroundSliderColors)
    return UIMenuSliderProgressItem.New(Text, Items, Index, Description, SliderColors, BackgroundSliderColors)
end

---CreateProgressItem
---@param Text string
---@param Items number
---@param Index table
---@param Description number
---@param Counter boolean
---@return table
---@public
function NativeUI.CreateProgressItem(Text, Items, Index, Description, Counter)
    return UIMenuProgressItem.New(Text, Items, Index, Description, Counter)
end

---CreateHeritageWindow
---@param Mum number
---@param Dad number
---@return table
---@public
function NativeUI.CreateHeritageWindow(Mum, Dad)
    return UIMenuHeritageWindow.New(Mum, Dad)
end

---CreateGridPanel
---@param TopText string
---@param LeftText string
---@param RightText string
---@param BottomText string
---@param CirclePositionX number
---@param CirclePositionY number
---@return table
---@public
function NativeUI.CreateGridPanel(TopText, LeftText, RightText, BottomText, CirclePositionX, CirclePositionY)
    return UIMenuGridPanel.New(TopText, LeftText, RightText, BottomText, CirclePositionX, CirclePositionY)
end

---CreateHorizontalGridPanel
---@param LeftText string
---@param RightText string
---@param RightText number
---@return table
---@public
function NativeUI.CreateHorizontalGridPanel(LeftText, RightText, CirclePositionX)
    return UIMenuHorizontalOneLineGridPanel.New(LeftText, RightText, CirclePositionX)
end

---CreateVerticalGridPanel
---@param TopText string
---@param BottomText string
---@param CirclePositionY number
---@return table
---@public
function NativeUI.CreateVerticalGridPanel(TopText, BottomText, CirclePositionY)
    return UIMenuVerticalOneLineGridPanel.New(TopText, BottomText, CirclePositionY)
end

---CreateColourPanel
---@param Title string
---@param Colours table
---@return table
---@public
function NativeUI.CreateColourPanel(Title, Colours)
    return UIMenuColourPanel.New(Title, Colours)
end

---CreatePercentagePanel
---@param MinText string
---@param MaxText string
---@return table
---@public
function NativeUI.CreatePercentagePanel(MinText, MaxText)
    return UIMenuPercentagePanel.New(MinText, MaxText)
end

---CreateStatisticsPanel
---@return table
---@public
function NativeUI.CreateStatisticsPanel()
    return UIMenuStatisticsPanel.New()
end

---CreateSprite
---@param TxtDictionary string
---@param TxtName string
---@param X number
---@param Y number
---@param Width number
---@param Height number
---@param Heading number
---@param R number
---@param G number
---@param B number
---@param A number
---@return table
---@public
function NativeUI.CreateSprite(TxtDictionary, TxtName, X, Y, Width, Height, Heading, R, G, B, A)
    return Sprite.New(TxtDictionary, TxtName, X, Y, Width, Height, Heading, R, G, B, A)
end

---CreateRectangle
---@param X number
---@param Y number
---@param Width number
---@param Height number
---@param R number
---@param G number
---@param B number
---@param A number
---@return table
---@public
function NativeUI.CreateRectangle(X, Y, Width, Height, R, G, B, A)
    return UIResRectangle.New(X, Y, Width, Height, R, G, B, A)
end

---CreateText
---@param Text string
---@param X number
---@param Y number
---@param Scale number
---@param R number
---@param G number
---@param B number
---@param A number
---@param Font number
---@param Alignment number
---@param DropShadow number
---@param Outline number
---@param WordWrap number
---@return table
---@public
function NativeUI.CreateText(Text, X, Y, Scale, R, G, B, A, Font, Alignment, DropShadow, Outline, WordWrap)
    return UIResText.New(Text, X, Y, Scale, R, G, B, A, Font, Alignment, DropShadow, Outline, WordWrap)
end

---CreateTimerBarProgress
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
function NativeUI.CreateTimerBarProgress(Text, TxtDictionary, TxtName, X, Y, Heading, R, G, B, A)
    return UITimerBarProgressItem.New(Text, TxtDictionary, TxtName, X, Y, Heading, R, G, B, A)
end

---CreateTimerBar
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
function NativeUI.CreateTimerBar(Text, TxtDictionary, TxtName, X, Y, Heading, R, G, B, A)
    return UITimerBarItem.New(Text, TxtDictionary, TxtName, X, Y, Heading, R, G, B, A)
end

---CreateTimerBarProgressWithIcon
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
function NativeUI.CreateTimerBarProgressWithIcon(TxtDictionary, TxtName, IconDictionary, IconName, X, Y, Heading, R, G, B, A)
    return UITimerBarProgressWithIconItem.New(TxtDictionary, TxtName, IconDictionary, IconName, X, Y, Heading, R, G, B, A)
end

---TimerBarPool
---@return table
---@public
function NativeUI.TimerBarPool()
    return UITimerBarPool.New()
end

---ProgressBarPool
function NativeUI.ProgressBarPool()
    return UIProgressBarPool.New()
end

---CreateProgressBarItem
---@param Text string
---@param X number
---@param Y number
---@param Heading number
---@param R number
---@param G number
---@param B number
---@param A number
function NativeUI.CreateProgressBarItem(Text, X, Y, Heading, R, G, B, A)
    return UIProgressBarItem.New(Text, X, Y, Heading, R, G, B, A)
end