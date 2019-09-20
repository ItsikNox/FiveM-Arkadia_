--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_libs
--

--
--
--
function Menu(data)

    local self = {

        x = 0.9,
        y = 0.25,
        title = data.title or nil,
        menuTitle = data.menuTitle or nil,
        titleScale = data.titleScale or 1.0,
        textScale = data.textScale or 0.36,
        subTextScale = data.subTextScale or 0.36,
        position = data.position or 2,
        width = data.width or 0.2,
        height = data.height or 0.04,
        defaultButtonPosition = data.defaultButtonPosition or 1,

        colors = {
            header = {
                red = 93,
                blue = 202,
                green = 166,
                alpha = 150,
            },
            button = {
                red = 0,
                green = 0,
                blue = 0,
                alpha = 150,
            },
            buttonHover = {
                red = 255,
                green = 255,
                blue = 255,
                alpha = 255,
            },
            text = {
                red = 255,
                green = 255,
                blue = 255,
                alpha = 255,
            },
            textHover = {
                red = 0,
                green = 0,
                blue = 0,
                alpha = 255,
            }
        },

        back = {
            eventClient = nil,
            eventServer = nil,
            callback = nil,
        },

        buttons = data.buttons or {},

    }

    -- Closable menu
    self.closable = true
    if data.closable ~= nil then
        self.closable = data.closable
    end

    -- Lock back menu
    self.backLock = false
    if data.backLock ~= nil then
        self.backLock = data.backLock
    end

    -- Get position (1 = left / 2 - right [default])
    if data.position == 1 then
        self.x = self.width / 2
    end

    -- Get color
    if data.colors ~= nil then

        if data.colors.header ~= nil then

            if data.colors.header.red ~= nil then
                self.colors.header.red = data.colors.header.red
            end

            if data.colors.header.blue ~= nil then
                self.colors.header.blue = data.colors.header.blue
            end

            if data.colors.header.green ~= nil then
                self.colors.header.green = data.colors.header.green
            end

            if data.colors.header.alpha ~= nil then
                self.colors.header.alpha = data.colors.header.alpha
            end

        end

        if data.button ~= nil then

            if data.button.red ~= nil then
                self.button.red = data.button.red
            end

            if data.button.blue ~= nil then
                self.button.blue = data.button.blue
            end

            if data.header.green ~= nil then
                self.button.green = data.button.green
            end

            if data.button.alpha ~= nil then
                self.button.alpha = data.button.alpha
            end

        end

        if data.buttonHover ~= nil then

            if data.buttonHover.red ~= nil then
                self.buttonHover.red = data.buttonHover.red
            end

            if data.button.blue ~= nil then
                self.buttonHover.blue = data.buttonHover.blue
            end

            if data.header.green ~= nil then
                self.buttonHover.green = data.buttonHover.green
            end

            if data.button.alpha ~= nil then
                self.buttonHover.alpha = data.buttonHover.alpha
            end

        end

        if data.text ~= nil then

            if data.text.red ~= nil then
                self.text.red = data.text.red
            end

            if data.text.blue ~= nil then
                self.text.blue = data.text.blue
            end

            if data.text.green ~= nil then
                self.text.green = data.text.green
            end

            if data.text.alpha ~= nil then
                self.text.alpha = data.text.alpha
            end

        end

        if data.textHover ~= nil then

            if data.textHover.red ~= nil then
                self.textHover.red = data.textHover.red
            end

            if data.textHover.blue ~= nil then
                self.textHover.blue = data.textHover.blue
            end

            if data.textHover.green ~= nil then
                self.textHover.green = data.textHover.green
            end

            if data.textHover.alpha ~= nil then
                self.textHover.alpha = data.textHover.alpha
            end

        end

    end

    --
    -- Get back action
    --
    if data.back ~= nil then

        if data.back.eventClient ~= nil then
            self.back.eventClient = data.back.eventClient
        end

        if data.back.eventServer ~= nil then
            self.back.eventServer = data.back.eventServer
        end

        if data.back.callback ~= nil then
            self.back.callback = data.back.callback
        end

    end

    --
    -- Display big title
    --
    self.ShowBigTitle = function()

        if self.title ~= nil then
            Text({
                text = self.title,
                x = self.x,
                y = self.y,
                scale = self.titleScale,
                center = true,
            })
        end

    end

    --
    --
    --
    self.SowHeader = function(selectedButton)

        local y = self.y
        if self.title ~= nil then
            y = y + 0.08
        end

        -- Top menu
        local countText = selectedButton .. "/" .. TableLength(self.buttons)

        -- Sub title
        DrawRect(self.x, y, self.width, self.height, self.colors.header.red, self.colors.header.green, self.colors.header.blue, self.colors.header.alpha)
        if self.menuTitle ~= nil then
            Text({
                text = self.menuTitle,
                font = 0,
                x = self.x - (self.width / 2) + 0.005,
                y = y - (self.height / 2) + 0.0028,
                scale = 0.4,
            })
        end

        -- Numbers
        Text({
            text = countText,
            font = 0,
            center = 0,
            x = self.x + self.width / 2 - 0.0385,
            y = y - 0.015,
            scale = 0.4,
        })

    end

    --
    --
    --
    self.DrawMenuButton = function(data, x, y, width, height, selected)

        local color = {}
        if selected then
            color.text = self.colors.textHover
            color.rect = self.colors.buttonHover
        else
            color.text = self.colors.text
            color.rect = self.colors.button
        end

        local textScale = self.textScale
        local subTextScale = self.subTextScale

        Text({
            text = data.text or "Default text",
            font = 0,
            x = x - (self.width / 2) + 0.005,
            y = y - (self.height / 2) + 0.0035,
            scale = textScale,
            red = color.text.red,
            blue = color.text.blue,
            green = color.text.green,
        })
        DrawRect(x, y, width, height, color.rect.red, color.rect.blue, color.rect.green, color.rect.alpha)

        if data.subText ~= nil then
            Text({
                text = data.subText,
                font = 0,
                right = true,
                startWrap = self.x,
                endWrap = (self.x + (self.width / 2)) - 0.005,
                x = x - (self.width / 2),
                y = y - (self.height / 2) + 0.0035,
                scale = subTextScale,
                red = color.text.red,
                blue = color.text.blue,
                green = color.text.green
            })
        end

    end

    --
    --
    --
    self.DrawMenuButtons = function(from, to, selectedButton)

        local y = self.y + self.height
        if self.title ~= nil then
            y = y + 0.08
        end

        for i, button in pairs(self.buttons) do

            if i >= from and i <= to then
                if i == selectedButton then
                    selected = true
                else
                    selected = false
                end

                self.DrawMenuButton(button, self.x, y, self.width, self.height, selected)
                y = y + 0.04
            end
        end

    end

    --
    --
    --
    self.Hover = function(selectedButton)

        local button = self.buttons[selectedButton]

        if button.hover ~= nil then

            -- Execute function
            if button.hover.callback ~= nil then
                local callback = button.hover.callback
                Citizen.CreateThread(function()
                    callback(button.data)
                end)
            end

            -- Send to server event
            if button.hover.eventServer ~= nil then
                TriggerServerEvent(button.hover.eventServer, button.data)
            end

            -- Send to client event
            if button.hover.eventClient ~= nil then
                TriggerEvent(button.hover.eventClient, button.data)
            end

        end

    end

    --
    --
    --
    self.Exec = function(selectedButton)

        local button = self.buttons[selectedButton]

        if button.exec ~= nil and button.lock ~= false then

            -- Execute function
            if button.exec.callback ~= nil then
                local callback = button.exec.callback
                Citizen.CreateThread(function()
                    callback(button.data)
                end)
            end

            -- Send to server event
            if button.exec.eventServer ~= nil then
                TriggerServerEvent(button.exec.eventServer, button.data)
            end

            -- Send to client event
            if button.exec.eventClient ~= nil then
                TriggerEvent(button.exec.eventClient, button.data)
            end

        end

    end

    --
    --
    --
    self.Back = function()

        if self.back ~= nil then

            if self.back.callback ~= nil then
                local callback = self.back.callback
                Citizen.CreateThread(function()
                    callback()
                end)
            end

            -- Send to server event
            if self.back.eventServer ~= nil then
                TriggerServerEvent(self.back.eventServer)
            end

            -- Send to client event
            if self.back.eventClient ~= nil then
                TriggerEvent(self.back.eventClient)
            end

        end

    end

    --
    --
    --
    self.Show = function(from, to, selectedButton)

        self.ShowBigTitle()
        self.SowHeader(selectedButton)
        self.DrawMenuButtons(from, to, selectedButton)

    end

    return self

end
