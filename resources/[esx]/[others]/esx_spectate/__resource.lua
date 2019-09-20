resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_scripts {
 '@mysql-async/lib/MySQL.lua',
 'server/main.lua'
 }
 
client_script 'client/main.lua'

ui_page {
  'ui/index.html'
}

files {
  'ui/index.html',
  'ui/style.css',
  'ui/main.js',
}