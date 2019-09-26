ConfigBarber = {}

ConfigBarber.Price = 100

ConfigBarber.DrawDistance = 15.0
ConfigBarber.MarkerSize   = {x = 1.5, y = 1.5, z = 1.0}
ConfigBarber.MarkerColor  = {r = 250, g = 100, b = 100}
ConfigBarber.MarkerType   = 1
ConfigBarber.Locale = 'fr'

ConfigBarber.Zones = {}

ConfigBarber.Shops = {
  {x = -814.308,  y = -183.823,  z = 36.568},
  {x = 136.826,   y = -1708.373, z = 28.291},
  {x = -1282.604, y = -1116.757, z = 5.990},
  {x = 1931.513,  y = 3729.671,  z = 31.844},
  {x = 1212.840,  y = -473.921,  z = 65.450},
  {x = -32.885,   y = -152.319,  z = 56.076},
  {x = -278.077,  y = 6228.463,  z = 30.695},
}

for i=1, #ConfigBarber.Shops, 1 do

	ConfigBarber.Zones['Shop_' .. i] = {
	 	Pos   = ConfigBarber.Shops[i],
	 	Size  = ConfigBarber.MarkerSize,
	 	Color = ConfigBarber.MarkerColor,
	 	Type  = ConfigBarber.MarkerType
  }

end