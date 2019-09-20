resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
	'client/main.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua'
}

ui_page "html/warrants_list.html"

files {
    'html/css/images/ui-bg_glass_55_fbf9ee_1x400.png',
	'html/css/images/ui-bg_glass_65_ffffff_1x400.png',
	'html/css/images/ui-bg_glass_75_dadada_1x400.png',
	'html/css/images/ui-bg_glass_75_e6e6e6_1x400.png',
	'html/css/images/ui-bg_glass_95_fef1ec_1x400.png',
	'html/css/images/ui-bg_highlight-soft_75_cccccc_1x100.png',
	'html/css/images/ui-icons_2e83ff_256x240.png',
	'html/css/images/ui-icons_222222_256x240.png',
	'html/css/images/ui-icons_454545_256x240.png',
	'html/css/images/ui-icons_888888_256x240.png',
	'html/css/images/ui-icons_cd0a0a_256x240.png',
	'html/css/jquery-ui.css',
	'html/js/jquery-ui.min.js',
	'html/script.js',
	'html/js/angular.min.js',
	"html/warrants_list.html",
	"html/bootstrap/css/bootstrap.css",
	"html/bootstrap/css/bootstrap.min.css",
	"html/bootstrap/fonts/glyphicons-halflings-regular.eot",
	"html/bootstrap/fonts/glyphicons-halflings-regular.svg",
	"html/bootstrap/fonts/glyphicons-halflings-regular.ttf",
	"html/bootstrap/fonts/glyphicons-halflings-regular.woff",
	"html/bootstrap/fonts/glyphicons-halflings-regular.woff2",
	"html/bootstrap/js/bootstrap.js",
	"html/bootstrap/js/bootstrap.min.js",
	"html/css/local.css",
	"html/js/jquery-1.10.2.min.js",
	"html/js/shieldui-all.min.js",
	'html/font-awesome/css/font-awesome.min.css',
	'html/font-awesome/css/font-awesome.css',
	'html/font-awesome/fonts/FontAwesome.otf',
	'html/font-awesome/fonts/fontawesome-webfont.eot',
	'html/font-awesome/fonts/fontawesome-webfont.svg',
	'html/font-awesome/fonts/fontawesome-webfont.ttf',
	'html/font-awesome/fonts/fontawesome-webfont.woff',
	'html/font-awesome/fonts/fontawesome-webfont.woff2'
}

dependencies {
	'es_extended',
	'esx_policejob'
}