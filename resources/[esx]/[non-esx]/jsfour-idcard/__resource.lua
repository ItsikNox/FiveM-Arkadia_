resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page 'html/index.html'

server_script {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

client_script {
	'client.lua'
}

files {
	'html/index.html',
	'html/assets/css/style.css',
	'html/assets/js/jquery.js',
	'html/assets/js/init.js',
	'html/assets/fonts/roboto/Roboto-Bold.woff',
	'html/assets/fonts/roboto/Roboto-Bold.woff2',
	'html/assets/fonts/roboto/Roboto-Light.woff',
	'html/assets/fonts/roboto/Roboto-Light.woff2',
	'html/assets/fonts/roboto/Roboto-Medium.woff',
	'html/assets/fonts/roboto/Roboto-Medium.woff2',
	'html/assets/fonts/roboto/Roboto-Regular.woff',
	'html/assets/fonts/roboto/Roboto-Regular.woff2',
	'html/assets/fonts/roboto/Roboto-Thin.woff',
	'html/assets/fonts/roboto/Roboto-Thin.woff2',
	'html/assets/fonts/justsignature/JustSignature.woff',
	'html/assets/css/materialize.min.css',
	'html/assets/js/materialize.js',
	'html/assets/images/idcard.png',
	'html/assets/images/license.png',
	'html/assets/images/firearm.png',
	'html/assets/images/male.png',
	'html/assets/images/female.png',
}
