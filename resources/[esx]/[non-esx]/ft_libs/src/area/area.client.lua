--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_libs
--

--
area = {}

-- class table
local Area = {}

--
-- Enable Area
--
function Area:Enable()

    EnableMarker(self.name)
    EnableTrigger(self.name)
    ShowBlip(self.name)

end

--
-- Disable Area
--
function Area:Disable()

    DisableMarker(self.name)
    DisableTrigger(self.name)
    HideBlip(self.name)

end

--
-- Remove Area
--
function Area:Remove()

    RemoveMarker(self.name)
    RemoveTrigger(self.name)
    RemoveBlip(self.name)

end

--
-- Create new instace of Area
--
function area.new(name, data)

    assert(type(name) == "string", "Area : name must be text")

    local self = data
    self.name = name

    -- Trigger
    if data.trigger ~= nil then
        local triggerData = data.trigger
        triggerData.enable = self.enable
        triggerData.x = data.x
        triggerData.y = data.y
        triggerData.z = data.z
        self.area = AddTrigger(name, triggerData)
    end

    -- Blip
    if data.blip ~= nil then
        local blipData = data.blip
        blipData.enable = self.enable
        blipData.x = data.x
        blipData.y = data.y
        blipData.z = data.z
        self.blip = AddBlip(name, blipData)
    end

    -- Marker
    if data.marker ~= nil then
        local markerData = data.marker
        markerData.enable = self.enable
        markerData.x = data.x
        markerData.y = data.y
        markerData.z = data.z
        self.marker = AddMarker(name, markerData)
    end

    setmetatable(self, { __index = Area })
    return self

end
