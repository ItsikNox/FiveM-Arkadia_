resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
server_script '@mysql-async/lib/MySQL.lua'
client_script "NativeUI.lua"

client_scripts {

	'cl_barber.lua',
	'config.lua',

}

server_script 'sv_barber.lua'