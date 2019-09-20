resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'locales/fr.lua',
	'config.lua',
	'server/faction_sv.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/fr.lua',
	'config.lua',
	'faction/bandits_cl.lua',
	'client/menufaction_cl.lua'
}
