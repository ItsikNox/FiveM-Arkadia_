resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

-- Example custom radios
supersede_radio "RADIO_02_POP" { url = "http://generationfm-rap.ice.infomaniak.ch/generationfm-rap-high.mp3", volume = 0.2, name = "Génération RAP/HIP-HOP"  }
supersede_radio "RADIO_03_HIPHOP_NEW" { url = "http://direct.mouv.fr/live/mouv-midfi.mp3", volume = 0.2, name = "Mouv' Radio"  }
supersede_radio "RADIO_01_CLASS_ROCK" { url = "http://www.skyrock.fm/stream.php/tunein16_128mp3.mp3", volume = 0.2, name = "SkyRock"  }
supersede_radio "RADIO_04_PUNK" { url = "http://icecast.skyrock.net/s/natio_mp3_128k", volume = 0.4, name = "Radio Custom"  }

files {
	"index.html"
}

ui_page "index.html"

client_scripts {
	"data.js",
	"client.js"
}
