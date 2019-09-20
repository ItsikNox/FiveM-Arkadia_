# Changelog
All notable changes to this project will be documented in this file.

## [Released]

## [1.2.2] - 2018-11-11
### Changed
- Fix playerCoords
- Add client export for GetVehicleInDirection function

## [1.2.1] - 2018-10-09
### Changed
- Fix enable on Area

## [1.2] - 2018-10-08
### Added
- Implement GetPlayerPed function
- Implement GetPlayerCoords function
- Implement GetDistanceBetween3DCoords function
- Implement GetObjects function
- Implement GetPeds function
- Implement GetVehicles function
- Implement GetPickups function
- Implement GetEntityInDirection function
- Implement GetEntityObjectInDirection function
- Implement GetPedInDirection function
- Implement GetPlayerPedInDirection function
- Implement GetPlayerServerIdInDirection function
- Implement GetVehicleInDirection function
- Implement GetObjectInDirection function
- Implement GetEntitiesInArea function
- Implement GetObjectsInArea function
- Implement GetPedsInArea function
- Implement GetPickupsInArea function
- Implement GetVehiclesInArea function
- Implement GetEntitiesInAround function
- Implement GetObjectsInAround function
- Implement GetPedsInAround function
- Implement GetPickupsInAround function
- Implement GetVehiclesInAround function
- Implement GetPlayersPed function
- Implement GetPlayersId function
- Implement GetPlayersPedOrderById function
- Implement GetEntitiesInAround function
- Add client export for GetPlayerPed function
- Add client export for GetPlayerCoords function
- Add client export for GetDistanceBetween3DCoords function
- Add client export for GetObjects function
- Add client export for GetPeds function
- Add client export for GetVehicles function
- Add client export for GetPickups function
- Add client export for GetEntityInDirection function
- Add client export for GetEntityObjectInDirection function
- Add client export for GetPedInDirection function
- Add client export for GetPlayerPedInDirection function
- Add client export for GetPlayerServerIdInDirection function
- Add client export for GetVehicleInDirection function
- Add client export for GetObjectInDirection function
- Add client export for GetEntitiesInArea function
- Add client export for GetObjectsInArea function
- Add client export for GetPedsInArea function
- Add client export for GetPickupsInArea function
- Add client export for GetVehiclesInArea function
- Add client export for GetEntitiesInAround function
- Add client export for GetObjectsInAround function
- Add client export for GetPedsInAround function
- Add client export for GetPickupsInAround function
- Add client export for GetVehiclesInAround function
- Add client export for GetPlayersPed function
- Add client export for GetPlayersId function
- Add client export for GetPlayersPedOrderById function
- Add client export for Clone function
- Add client export for Copy function
- Add client export for GetEntitiesInAround function
- Add server export for Copy function
- Add server export for SetDebug function

### Changed
- Optimization and refactoring Areas functions
- Optimization and refactoring Trigger functions
- Optimization and refactoring Marker functions
- Raname TablePrint function on PrintTable
- Rename ft_libs:TablePrint event on ft_libs:PrintTable
- Add lock option on buttons for menu

## [1.1] - 2018-00-00
### Added
- Implement selecteButton function pushed by @THEJean-Kevin
- Add variable defaultButtonPosition pushed by @THEJean-Kevin
- Rename selecteButton function to SelecteButton
- Refactoring SelecteButton function
- Refactoring variable defaultButtonPosition
- Implement DPrint function pushed by @izio38
- Implement DebugPrint function pushed by @izio38
- Refactoring DPrint function
- Remane DPrint function to DebugPrint
- Implement SetArea function
- Implement SetBlip function
- Implement SetMarker function
- Implement SetTrigger function
- Implement GetRandomString function
- Add client event ft_libs:DebugMode
- Add client export for DebugPrint function
- Add client export for SetDebug function
- Add client export for SetArea function
- Add client export for SetBlip function
- Add client export for SetMarker function
- Add client export for SetTrigger function
- Add client export for SelecteButton function
- Add client export for GetRandomString function
- Add server export for DebugPrint function
- Add server export for GetRandomString function

### Changed
- Rename CurrentMenu in GetCurrentMenu
- Refactoring menu
- Implement multiple table in call CleanMenuButtons function
- Implement multiple table in call SetMenuButtons function
- Implement multiple table in call SetMenuValue function
- Implement multiple table in call AddMenuButton function
- Implement multiple table in call RemoveMenuButton function
- Add default text on butons in menu is empty
- Add Citizen.Wait on AddMenuButton function
- Change variable name on AddMenuButton function
- Rename file client.client to load.client.lua
- Change event ft_libs:PrintTable to ft_libs:TablePrint
- Add source on header in all files
- Replace Citizen.Trace to print on PrintTable function
- Add customTitle on DebugPrint function
- Rename variables steamID to identifier on GetSteamIDFormSource
- Add check on AddArea if areas exist
- Add check on AddMarker if marker exist
- Add check on AddBlip if blip exist
- Add check on AddTrigger if trigger exist

## [1.0] - 2018-07-19
### Added
- Implement GetSteamIDFormSource function
- Implement GetIpFormSource function
- Implement Copy function
- Implement Clone function
- Implement Clone function
- Add server export for GetSteamIDFormSource function
- Add server export for GetIpFormSource function

### Changed
- Global refactoring and optimization
- Add continuously up or down for menu
- Add resource_manifest_version
- Fix Areas exports
- Change variables name for areas
- Fix clone variable on Areas
- Add customTitle on OpenTextInput function
- Change Citizen.Wait on OpenTextInput function
- Change Citizen.Wait on Marker functions
- Change Citizen.Wait on Trigger functions
- Add Wrap variable on Text function

### Removed
- Remove one frame system

## [Pre-Released]

## [0.7] - 2018-03-17
### Added
- Implement Areas functions
- Add client export for AddAreas function
- Add client export for RemoveAreas function
- Add client export for EnableAreas function
- Add client export for DisableAreas function
- Add client export for SwitchAreas function
- Add client export for PrimaryMenu function
- Add client export for AdvancedNotification function

### Changed
- Add primarymenu variable on menu
- Fix variable on Text function
- Fix menu display
- Fix blip rotation
- Fix variables on menu
- Refactoring and optimize marker
- Fix currentMarker on marker
- Refactoring and optimize blip
- Fix error on blip
- Refactoring and optimize area

### Removed
- Clear all Citizen.Trace

## [0.6] - 2018-03-01
### Added
- Implement Maker functions
- Add client export for AddMarker function
- Add client export for RemoveMarker function
- Add client export for EnableMarker function
- Add client export for DisableMarker function
- Add client export for SwitchMarker function
- Add client export for CurrentMarker function

## [0.5] - 2018-02-27
### Added
- Implement Triggers functions
- Add client export for AddTrigger function
- Add client export for RemoveTrigger function
- Add client export for SwitchTrigger function
- Add client export for EnableTrigger function
- Add client export for DisableTrigger function
- Add client export for CurrentTrigger function

## [0.4] - 2018-02-26
### Added
- Implement Blip functions
- Add client export for AddBlip function
- Add client export for RemoveBlip function
- Add client export for ShowBlip function
- Add client export for HideBlip function

### Changed
- Add check for settings.center in Text function

## [0.3] - 2018-02-24
### Added
- Implement Menu functions
- Add client export for AddMenu function
- Add client export for RemoveMenu function
- Add client export for AddMenu function
- Add client export for MenuIsOpen function
- Add client export for CurrentMenu function
- Add client export for FreezeMenu function
- Add client export for OpenMenu function
- Add client export for CloseMenu function
- Add client export for NextMenu function
- Add client export for BackMenu function
- Add client export for CleanMenuButtons function
- Add client export for SetMenuButtons function
- Add client export for SetMenuValue function
- Add client export for AddMenuButton function
- Add client export for RemoveMenuButton function

## [0.2] - 2018-02-11
### Added
- Implement TableLength function
- Implement Round function
- Implement CommaValue function
- Implement GetEntityDirection function
- Implement OpenTextInput function
- Implement TextNotification function
- Implement client event ft_libs:TextNotification
- Implement server event ft_libs:PrintTable
- Implement send event ft_libs:OnClientReady for client
- Implement send event ft_libs:OnClientReady for server
- Add client export for TableLength function
- Add client export for Round function
- Add client export forCommaValue function
- Add client export for GetEntityDirection function
- Add client export for OpenTextInput function
- Add client export for TextNotification function
- Add server export for Round function

### Changed
- Change variable names for OpenTextInput

## [0.1] - 2018-02-04
### Added
- Implement HelpPromt function
- Implement LoadingPromt function
- Implement Notification function
- Implement AdvancedNotification function
- Implement OpenTextInput function
- Implement Text function
- Implement client event ft_libs:AdvancedNotification
- Implement client event ft_libs:Notification
- Add client export for HelpPromt function
- Add client export for LoadingPromt function
- Add client export for Notification function
- Add client export for OpenTextInput function
- Add client export for Text function
- Adding a readme with instructions and links
- Implement one frame for all check function
