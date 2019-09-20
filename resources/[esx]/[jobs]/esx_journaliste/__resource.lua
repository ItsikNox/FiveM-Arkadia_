resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Reporter Job'

version '1.0.4'

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  '@es_extended/locale.lua',
  'config.lua',
  'server/main.lua',
  'locales/fr.lua'
}

client_scripts {
  '@es_extended/locale.lua',
  'config.lua',
  'client/main.lua',
  'locales/fr.lua'  
}
