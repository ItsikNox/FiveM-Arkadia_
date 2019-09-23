loadscreen_manual_shutdown "yes"
description 'panzarload'

files {
    -- Main
    'edit_this.html',
    'keks.css',
    
    -- Musiken
    'music/music.ogg'
}

loadscreen 'edit_this.html'

client_script "client.lua"
