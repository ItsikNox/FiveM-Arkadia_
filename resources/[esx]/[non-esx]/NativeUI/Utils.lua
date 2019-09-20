function GetResolution()
    local W, H = GetActiveScreenResolution()
    if (W/H) > 3.5 then
        return GetScreenResolution()
    else
        return W, H
    end
end

function FormatXWYH(Value, Value2)
    return Value/1920, Value2/1080
end

function math.round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function tobool(input)
	if input == "true" or tonumber(input) == 1 or input == true then
		return true
	else
		return false
	end
end

function string.split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end

	return t
end

function string.starts(String, Start)
	return string.sub(String, 1, string.len(Start)) == Start
end

function IsMouseInBounds(X, Y, Width, Height)
	local MX, MY = math.round(GetControlNormal(0, 239) * 1920), math.round(GetControlNormal(0, 240) * 1080)
    MX, MY = FormatXWYH(MX, MY)
    X, Y = FormatXWYH(X, Y)
    Width, Height = FormatXWYH(Width, Height)
	return (MX >= X and MX <= X + Width) and (MY > Y and MY < Y + Height)
end

function GetSafeZoneBounds()
	local SafeSize = GetSafeZoneSize()
	SafeSize = math.round(SafeSize, 2)
	SafeSize = (SafeSize * 100) - 90
	SafeSize = 10 - SafeSize

	local W, H = 1920, 1080

	return {X = math.round(SafeSize * ((W/H) * 5.4)), Y = math.round(SafeSize * 5.4)}
end

function Controller()
	return not IsInputDisabled(2)
end

--[[

function UIMenu:ProcessMouse()
	if not self._Visible or self.JustOpened or #self.Items == 0 or tobool(Controller()) or not self.Settings.MouseControlsEnabled then
		EnableControlAction(0, 2, true)
		EnableControlAction(0, 1, true)
		EnableControlAction(0, 25, true)
		EnableControlAction(0, 24, true)
		if self.Dirty then
			for _, Item in pairs(self.Items) do
				if Item:Hovered() then
					Item:Hovered(false)
				end
			end
		end
		return
	end

	local SafeZone = GetSafeZoneBounds()

	local Limit = #self.Items - 1
	local Counter = 0

	ShowCursorThisFrame()

	if #self.Items > self.Pagination.Total + 1 then
		Limit = self.Pagination.Max
	end

	if IsMouseInBounds(0, 0, 30, 1080) and self.Settings.MouseEdgeEnabled then
		SetGameplayCamRelativeHeading(GetGameplayCamRelativeHeading() + 5)
		SetCursorSprite(6)
	elseif IsMouseInBounds(GetScreenResolutionMaintainRatio().Width - 30, 0, 30, 1080) and self.Settings.MouseEdgeEnabled then
		SetGameplayCamRelativeHeading(GetGameplayCamRelativeHeading() - 5)
		SetCursorSprite(7)	
	elseif self.Settings.MouseEdgeEnabled then
		SetCursorSprite(1)
	end

	for i = self.Pagination.Min + 1, Limit, 1 do
		local X, Y = self.Position.X, self.Position.Y + 144 - 37 + self.Subtitle.ExtraY + (Counter * 38)
		local Width, Height = 431 + self.WidthOffset, 38
		local Item = self.Items[i]
		local Type, SubType = Item()

		DrawRectangle(X, Y, Width, Height, 255, 0, 0, 150)
		if SubType == "UIMenuListItem" or SubType == "UIMenuSliderItem" then
			DrawRectangle(Item.LeftArrow.X, Item.LeftArrow.Y, Item.LeftArrow.Width, Item.LeftArrow.Height, 0, 255, 0, 150)
			DrawRectangle(Item.RightArrow.X, Item.RightArrow.Y, Item.RightArrow.Width, Item.RightArrow.Height, 0, 255, 0, 150)
		end

		if IsMouseInBounds(X, Y, Width, Height) then
			Item:Hovered(true)
			if IsDisabledControlJustPressed(0, 24) then
				if Item:Selected() and Item:Enabled() then
					if SubType == "UIMenuListItem" then
						if IsMouseInBounds(Item.LeftArrow.X, Item.LeftArrow.Y, Item.LeftArrow.Width, Item.LeftArrow.Height) then
							self:GoLeft()
						elseif not IsMouseInBounds(Item.RightArrow.X, Item.RightArrow.Y, Item.RightArrow.Width, Item.RightArrow.Height) then
							self:SelectItem()
						end
						if IsMouseInBounds(Item.RightArrow.X, Item.RightArrow.Y, Item.RightArrow.Width, Item.RightArrow.Height) then
							self:GoRight()
						elseif not IsMouseInBounds(Item.LeftArrow.X, Item.LeftArrow.Y, Item.LeftArrow.Width, Item.LeftArrow.Height) then
							self:SelectItem()
						end
					elseif SubType == "UIMenuSliderItem" then
						if IsMouseInBounds(Item.LeftArrow.X, Item.LeftArrow.Y, Item.LeftArrow.Width, Item.LeftArrow.Height) then
							self:GoLeft()
						elseif not IsMouseInBounds(Item.RightArrow.X, Item.RightArrow.Y, Item.RightArrow.Width, Item.RightArrow.Height) then
							self:SelectItem()
						end
						if IsMouseInBounds(Item.RightArrow.X, Item.RightArrow.Y, Item.RightArrow.Width, Item.RightArrow.Height) then
							self:GoRight()
						elseif not IsMouseInBounds(Item.LeftArrow.X, Item.LeftArrow.Y, Item.LeftArrow.Width, Item.LeftArrow.Height) then
							self:SelectItem()
						end
					else
						self:SelectItem()
					end
				elseif not Item:Selected() then
					self:CurrentSelection(i-1)
					PlaySoundFrontend(-1, self.Settings.Audio.Error, self.Settings.Audio.Library, true)
					self.OnIndexChange(self, self:CurrentSelection())
					self.ReDraw = true
				elseif not Item:Enabled() and Item:Selected() then
					PlaySoundFrontend(-1, self.Settings.Audio.Error, self.Settings.Audio.Library, true)
				end
			end
		else
			Item:Hovered(false)
		end
		Counter = Counter + 1
	end

	local ExtraX, ExtraY = self.Position.X, 144 + 38 * (self.Pagination.Total + 1) + self.Position.Y - 37 + self.Subtitle.ExtraY

	if #self.Items <= self.Pagination.Total + 1 then return end

	if IsMouseInBounds(ExtraX, ExtraY, 431 + self.WidthOffset, 18) then
		self.Extra.Up:Colour(30, 30, 30, 255)
		if IsDisabledControlJustPressed(0, 24) then
			if #self.Items > self.Pagination.Total + 1 then
				self:GoUpOverflow()
			else
				self:GoUp()
			end
		end
	else
		self.Extra.Up:Colour(0, 0, 0, 200)
	end

	if IsMouseInBounds(ExtraX, ExtraY + 18, 431 + self.WidthOffset, 18) then
		self.Extra.Down:Colour(30, 30, 30, 255)
		if IsDisabledControlJustReleased(0, 24) then
			if #self.Items > self.Pagination.Total + 1 then
				self:GoDownOverflow()
			else
				self:GoDown()
			end
		end			
	else
		self.Extra.Down:Colour(0, 0, 0, 200)
	end
end
--]]