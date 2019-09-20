--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_libs
--

--
blip = {}

-- class table
local Blip = {}

--
-- Show Blip
--
function Blip:Show()

    self.blip = AddBlipForCoord(self.x, self.y, self.z)
    SetBlipSprite(self.blip, self.imageId)
    SetBlipAsShortRange(self.blip, self.shortRange)
    SetBlipColour(self.blip, self.colorId)
    SetBlipScale(self.blip, self.scale)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(self.text)
    EndTextCommandSetBlipName(self.blip)
    if self.rotation ~= nil then
        SetBlipRotation(self.blip, self.rotation)
    end

end

--
-- Hide Blip
--
function Blip:Hide()

    if self.blip ~= nil then
        Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(self.blip)) -- Use native REMOVE_BLIP
    end

end

--
-- Create new instace of Marker
--
function blip.new(data)

    assert(type(data.x) == "number", "Blip : x must be number")
    assert(type(data.y) == "number", "Blip : y must be number")
    assert(type(data.text) == "string", "Blip : text must be text")

    local self = data
    self.blip = nil
    self.imageId = data.imageId or 1
    self.colorId = data.colorId or 0
    self.scale = data.scale or 1.0

    if data.shortRange == nil or type(data.shortRange) ~= "boolean" then
        self.shortRange = true
    end

    if data.enable == nil or type(data.enable) ~= "boolean" then
        self.enable = true
    end

    setmetatable(self, { __index = Blip })
    return self

end
