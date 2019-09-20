version '1.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'locales/fr.lua',
	'server/esx_jaillisting_sv.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'locales/fr.lua',
	'locales/en.lua',
	'client/esx_jaillisting_cl.lua'
}
