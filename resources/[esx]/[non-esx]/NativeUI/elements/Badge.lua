BadgeStyle = {
	None = 0,
	BronzeMedal = 1,
	GoldMedal = 2,
	SilverMedal = 3,
	Alert = 4,
	Crown = 5,
	Ammo = 6,
	Armour = 7,
	Barber = 8,
	Clothes = 9,
	Franklin = 10,
	Bike = 11,
	Car = 12,
	Gun = 13,
	Heart = 14,
	Makeup = 15,
	Mask = 16,
	Michael = 17,
	Star = 18,
	Tattoo = 19,
	Trevor = 20, 
	Lock = 21,
	Tick = 22
}

BadgeTexture = {
	[0] = function()
		return ""
	end,
	[1] = function()
		return "mp_medal_bronze"
	end,
	[2] = function()
		return "mp_medal_gold"
	end,
	[3] = function()
		return "medal_silver"
	end,
	[4] = function()
		return "mp_alerttriangle"
	end,
	[5] = function()
		return "mp_hostcrown"
	end,
	[6] = function(Selected)
		if Selected then
			return "shop_ammo_icon_b"
		else 
			return "shop_ammo_icon_a"
		end
	end,
	[7] = function(Selected)
		if Selected then
			return "shop_armour_icon_b"
		else 
			return "shop_armour_icon_a"
		end
	end,
	[8] = function(Selected)
		if Selected then
			return "shop_barber_icon_b"
		else 
			return "shop_barber_icon_a"
		end
	end,
	[9] = function(Selected)
		if Selected then
			return "shop_clothing_icon_b"
		else 
			return "shop_clothing_icon_a"
		end
	end,
	[10] = function(Selected)
		if Selected then
			return "shop_franklin_icon_b"
		else 
			return "shop_franklin_icon_a"
		end
	end,
	[11] = function(Selected)
		if Selected then
			return "shop_garage_bike_icon_b"
		else 
			return "shop_garage_bike_icon_a"
		end
	end,
	[12] = function(Selected)
		if Selected then
			return "shop_garage_icon_b"
		else 
			return "shop_garage_icon_a"
		end
	end,
	[13] = function(Selected)
		if Selected then
			return "shop_gunclub_icon_b"
		else 
			return "shop_gunclub_icon_a"
		end
	end,
	[14] = function(Selected)
		if Selected then
			return "shop_health_icon_b"
		else 
			return "shop_health_icon_a"
		end
	end,
	[15] = function(Selected)
		if Selected then
			return "shop_makeup_icon_b"
		else
			return "shop_makeup_icon_a"
		end
	end,
	[16] = function(Selected)
		if Selected then
			return "shop_mask_icon_b"
		else 
			return "shop_mask_icon_a"
		end
	end,
	[17] = function(Selected)
		if Selected then
			return "shop_michael_icon_b"
		else 
			return "shop_michael_icon_a"
		end
	end,
	[18] = function()
		return "shop_new_star"
	end,
	[19] = function(Selected)
		if Selected then
			return "shop_tattoos_icon_b"
		else
			return "shop_tattoos_icon_a"
		end
	end,
	[20] = function(Selected)
		if Selected then
			return "shop_trevor_icon_b"
		else 
			return "shop_trevor_icon_a"
		end
	end,
	[21] = function()
		return "shop_lock"
	end,
	[22] = function()
		return "shop_tick_icon"
	end,
}

BadgeDictionary = {
	[0] = function(Selected)
		if Selected then
			return "commonmenu"
		else
			return "commonmenu"
		end
	end,
}

BadgeColour = {
	[5] = function(Selected)
		if Selected then
			return 0, 0, 0, 255
		else
			return 255, 255, 255, 255
		end
	end,
	[21] = function(Selected)
		if Selected then
			return 0, 0, 0, 255
		else
			return 255, 255, 255, 255
		end
	end,
	[22] = function(Selected)
		if Selected then
			return 0, 0, 0, 255
		else
			return 255, 255, 255, 255
		end
	end,
}

function GetBadgeTexture(Badge, Selected)
	if BadgeTexture[Badge] then
		return BadgeTexture[Badge](Selected)
	else
		return ""
	end
end

function GetBadgeDictionary(Badge, Selected)
	if BadgeDictionary[Badge] then
		return BadgeDictionary[Badge](Selected)
	else
		return "commonmenu"
	end
end

function GetBadgeColour(Badge, Selected)
	if BadgeColour[Badge] then
		return BadgeColour[Badge](Selected)
	else
		return 255, 255, 255, 255
	end
end