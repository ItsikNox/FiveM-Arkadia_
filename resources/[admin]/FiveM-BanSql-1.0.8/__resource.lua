resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

version '1.0.8'

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server.lua'
}

client_scripts {
  'client/main.lua'
}

dependencies {
	'essentialmode',
	'async'
}