version '1.0.2'

client_script('client.lua')

server_script "@mysql-async/lib/MySQL.lua"
server_script "server.lua"

ui_page('html/index.html')

files({
  'html/index.html',
  'html/script.js',
  'html/style.css',
  'html/cursor.png',
  'html/img/bg1.jpg',
  'html/img/cursor.png',
  'html/new/index.html',
  'html/new/bootstrap.min.css',
  'html/new/bootstrap-extend.css',
  'html/new/master_style.css',
  'html/new/master_style_dark.css',
  'html/new/master_style_rtl.css',
  'html/new/images/bg.jpg',
  'html/new/images/bg1.jpg',
  'html/new/images/bg2.jpg',
  'html/new/js/jquery-3.3.1.js',
})

exports {
  'openRegistry'
}