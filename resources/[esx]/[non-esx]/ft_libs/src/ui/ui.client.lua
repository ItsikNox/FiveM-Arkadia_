--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_libs
--

--
-- Display info in corner top left
--
function HelpPromt(text)

	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, false, false, -1)

end

--
-- Display loading promt
--
function LoadingPromt(settings)

	settings = settings or {}
	local text = settings.text or "Text"
	local type = settings.type or 4
	local time = settings.time or 1000

	N_0xaba17d7ce615adbf("STRING")
	AddTextComponentString(text)
	N_0xbd12f8228410d9b4(type)
	N_0x10d373323e5b9c0d()

end

--
-- Display notification on the top map
--
function Notification(message)

	SetNotificationTextEntry('STRING')
	AddTextComponentString(message)
	DrawNotification(false, false)

end

--
-- Display notification on the top map
--
function AdvancedNotification(settings)

	settings = settings or {}
	local icon = settings.icon or "CHAR_DEFAULT"
	local type = settings.type or 1
	local text = settings.text or ""
	local title = settings.title or ""
	local subTitle = settings.subTitle or ""

	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	SetNotificationMessage(icon, icon, true, type, title, subTitle)
	DrawNotification(false, true)

end

--
-- Display text on the screen
--
function Text(settings)

	settings = settings or {}
	local text = settings.text or "Text"
	local font = settings.font or 1
	local x = settings.x or 0
	local y = settings.y or 0
	local scale = settings.scale or 1.0
	local red = settings.red or 255
	local green = settings.green or 255
	local blue = settings.blue or 255
	local alpha = settings.alpha or 255
	local startWrap = settings.startWrap or 0.0
	local endWrap = settings.endWrap or 1.0

	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(red, green, blue, alpha)
	SetTextWrap(startWrap, endWrap)
	if settings.center == true then
		SetTextCentre(true)
	end
	if settings.right == true then
		SetTextJustification(2)
	end
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)

end

--
-- Open input
--
function OpenTextInput(settings)

	settings = settings or {}
	local title = settings.title or "FMMC_KEY_TIP8"
	local defaultText = settings.defaultText or ""
	local maxInputLength = settings.maxInputLength or 255

	local customTitle = false
	if title ~= nil and settings.customTitle ~= nil and settings.customTitle == true then
		AddTextEntry('FT_TEXT', title)
		title = "FT_TEXT"
	end

	DisplayOnscreenKeyboard(true, title, "", defaultText, "", "", "", maxInputLength)

	while UpdateOnscreenKeyboard() == 0 do
		DisableAllControlActions(0)
		Citizen.Wait(10)
	end

	local result = GetOnscreenKeyboardResult()
	if result then
		return result
	else
		return nil
	end

end

--
-- Text on center
--
function TextNotification(settings)

	settings = settings or {}
	local text = settings.text or "Text"
	local time = settings.time or 1000

	SetTextEntry_2("STRING")
	AddTextComponentString(text)
	DrawSubtitleTimed(time, true)

end

--
-- 3D text
--
function Show3DText(settings)

	settings = settings or {}
	local x = settings.x or 0.0
	local y = settings.y or 0.0
	local z = settings.z + 1 or 0.0
	local text = settings.text or "3D TEXT"
	local font = settings.font or 1
	local red = settings.red or 255
	local green = settings.green or 255
	local blue = settings.blue or 255
	local alpha = settings.alpha or 255
	local scale = settings.scale or 1.0
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)

	if onScreen then
		local px, py, pz = table.unpack(GetGameplayCamCoords())
		local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)
		local scale = ( 1 / dist) * 2
		local fov = ( 1 / GetGameplayCamFov() ) * 100
		local scale = scale * fov

		SetTextScale(0.2 * scale, 0.2 * scale)
		SetTextFont(font)
		SetTextProportional(1)
		SetTextScale(scale, scale)
		SetTextColour(red, green, blue, alpha)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		SetDrawOrigin(x, y, z, 0)
		DrawText(0.0, 0.0)
		ClearDrawOrigin()
	end

end

--
-- Events
--
RegisterNetEvent('ft_libs:Notification')
AddEventHandler('ft_libs:Notification', Notification)

RegisterNetEvent('ft_libs:AdvancedNotification')
AddEventHandler('ft_libs:AdvancedNotification', AdvancedNotification)

RegisterNetEvent('ft_libs:TextNotification')
AddEventHandler('ft_libs:TextNotification', TextNotification)
