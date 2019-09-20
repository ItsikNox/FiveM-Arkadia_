--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_libs
--

--
trigger = {}

-- class table
local Trigger = {}

--
-- Enter
--
function Trigger:Enter()

    Citizen.CreateThread(function()

        if self.enter.callback ~= nil then
            local callback = self.enter.callback
            callback(self.data)
        end

        if self.enter.eventClient ~= nil then
            TriggerEvent(self.enter.eventClient, self.data)
        end

        if self.enter.eventServer ~= nil then
            TriggerServerEvent(self.enter.eventServer, self.data)
        end

    end)
end

--
--
--
function Trigger:Active()
    Citizen.CreateThread(function()

        if self.active.callback ~= nil then
            local callback = self.active.callback
            callback(self.data)
        end

        if self.active.eventClient ~= nil then
            TriggerEvent(self.active.eventClient, self.data)
        end

        if self.active.eventServer ~= nil then
            TriggerServerEvent(self.active.eventServer, self.data)
        end

    end)
end

--
--
--
function Trigger:Exit()
    Citizen.CreateThread(function()

        if self.exit.callback ~= nil then
            local callback = self.exit.callback
            callback(self.data)
        end

        if self.exit.eventClient ~= nil then
            TriggerEvent(self.exit.eventClient, self.data)
        end

        if self.exit.eventServer ~= nil then
            TriggerServerEvent(self.exit.eventServer, self.data)
        end

    end)
end

--
--
--
function trigger.new(data)

    assert(type(data.x) == "number", "Trigger : x must be number")
    assert(type(data.y) == "number", "Trigger : y must be number")
    assert(type(data.z) == "number", "Trigger : z must be number")

    local self = data
    self.weight = data.weight or 2.0
    self.height = data.height or 2.0
    self.enter = data.enter or {}
    self.exit = data.exit or {}
    self.active = data.active or {}
    self.data = data.data or {}

    if data.enable == nil or type(data.enable) ~= "boolean" then
        self.enable = true
    end

    setmetatable(self, { __index = Trigger })
    return self

end
