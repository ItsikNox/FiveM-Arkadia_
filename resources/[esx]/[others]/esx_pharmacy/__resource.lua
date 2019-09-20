description 'Pharmacie'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'server/esx_pharmacy.server.lua',
    'locales/fr.lua',
    'config.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'client/esx_pharmacy.client.lua',
    'client/esx_pharmacy_gui.client.lua',
    'locales/fr.lua',
    'config.lua'
}