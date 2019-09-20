resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
  'incl.lua',
  'utils.lua',
  'config.lua',
	'client.lua',
}

server_scripts {	
  '@mysql-async/lib/MySQL.lua',
  'incl.lua',
  'utils.lua',
	'config.lua',
	'server.lua',
}