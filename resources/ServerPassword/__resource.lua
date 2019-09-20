------------------------------------
-- Server Password, Made by FAXES --
------------------------------------
-- Config can be found in the files

dependency 'es_extended'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'server.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'client.lua'
}