resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX trunk inventory'

version '2.1.0'

server_scripts {
  '@async/async.lua',
  '@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/de.lua',
	'locales/en.lua',
	'locales/fr.lua',
  'config.lua',
  'server/classes/c_trunk.lua',
  'server/trunk.lua',
  'server/esx_trunk-sv.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/de.lua',
	'locales/en.lua',
	'locales/fr.lua',
  'config.lua',
  'client/esx_trunk-cl.lua'
}
