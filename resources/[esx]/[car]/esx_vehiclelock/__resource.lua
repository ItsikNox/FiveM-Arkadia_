-- Credit @Foxi10

-- Key Script

server_script {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua'
}

client_scripts {
	'client/main.lua',
	'config.lua'
}
