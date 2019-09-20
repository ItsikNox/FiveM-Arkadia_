--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_libs
--

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {

    -- Utils
    "src/utils/utils.common.lua",
    "src/utils/utils.client.lua",

    -- Ui
    "src/ui/ui.client.lua",
    "src/ui/instructionalButtons.client.lua",

    -- Menu
    "src/menu/menu.client.lua",
    "src/menu/menus.client.lua",

    -- Blip
    "src/blip/blip.client.lua",
    "src/blip/blips.client.lua",

    -- Trigger
    "src/trigger/trigger.client.lua",
    "src/trigger/triggers.client.lua",

    -- Marker
    "src/marker/marker.client.lua",
    "src/marker/markers.client.lua",

    -- Area
    "src/area/area.client.lua",
    "src/area/areas.client.lua",

    -- Event 100% load
    "src/load.client.lua",

    -- Entity
    "src/entity/entity.client.lua",
    "src/entity/object.client.lua",
    "src/entity/ped.client.lua",
    "src/entity/pickup.client.lua",
    "src/entity/player.client.lua",
    "src/entity/vehicle.client.lua",

}

exports {

    -- Utils
    "TableLength",
    "Round",
    "CommaValue",
    "SetDebug",
    "Print",
    "PrintTable",
    "TableContainsValue",
    "GetLastContentValue",
    "GetRandomString",
    "GetDistanceBetween3DCoords",
    "PrintTable",
    "Copy",
    "Clone",

    -- Ui
    "HelpPromt",
    "LoadingPromt",
    "Message",
    "Notification",
    "AdvancedNotification",
    "Text",
    "OpenTextInput",
    "TextNotification",
    "Show3DText",

    -- Instructional Buttons
    "AddInstructionalButtons",
    "RemoveInstructionalButtons",
    "DisplayInstructionalButtons",
    "GetCurrentInstructionalButtons",

    -- Menu
    "AddMenu",
    "RemoveMenu",
    "MenuIsOpen",
    "CurrentMenu",
    "PrimaryMenu",
    "GetCurrentMenu",
    "GetPrimaryMenu",
    "FreezeMenu",
    "OpenMenu",
    "CloseMenu",
    "NextMenu",
    "BackMenu",
    "CleanMenuButtons",
    "SetMenuButtons",
    "SetMenuValue",
    "AddMenuButton",
    "RemoveMenuButton",
    "SelecteButton",

    -- Blip
    "AddBlip",
    "RemoveBlip",
    "ShowBlip",
    "HideBlip",

    -- Trigger
    "AddTrigger",
    "RemoveTrigger",
    "SwitchTrigger",
    "EnableTrigger",
    "DisableTrigger",
    "CurrentTrigger",

    -- Marker
    "AddMarker",
    "RemoveMarker",
    "EnableMarker",
    "DisableMarker",
    "SwitchMarker",
    "CurrentMarker",

    -- Areas
    "AddArea",
    "RemoveArea",
    "EnableArea",
    "DisableArea",
    "SwitchArea",

    -- Debug
    "SetDebug",
    "DebugPrint",

    -- Entity
    "GetEntitiesInArea",
    "GetEntityInDirection",
    "GetEntityObjectInDirection",
    "GetEntitiesInAround",

    -- Objects
    "GetObjects",
    "GetObjectsInArea",
    "GetObjectsInAround",
    "GetObjectInDirection",

    -- Peds
    "GetPeds",
    "GetPedsInArea",
    "GetPedsInAround",
    "GetPedInDirection",

    -- Vehicules
    "GetVehicles",
    "GetVehiclesInArea",
    "GetVehiclesInAround",
    "GetVehicleInDirection",

    -- Vehicules
    "GetPickups",
    "GetPickupsInArea",
    "GetPickupsInAround",

    -- Player
    "GetPlayerPed",
    "GetPlayersId",
    "GetPlayersPed",
    "GetPlayerCoords",
    "GetPlayersPedOrderById",
    "GetPlayerPedInDirection",
    "GetPlayerServerIdInDirection",

}

server_scripts {

    -- Utils
    "src/utils/utils.common.lua",
    "src/utils/utils.server.lua",

}

server_exports {

    -- Utils
    "TableLength",
    "PrintTable",
    "Round",
    "GetSteamIDFormSource",
    "GetIpFormSource",
    "TableContainsValue",
    "GetLastContentValue",
    "DebugPrint",
    "SetDebug",
    "GetRandomString",
    "Copy",
    "Clone",

}
