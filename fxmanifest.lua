shared_script '@WaveShield/waveshield.lua' --this line was automatically written by WaveShield

fx_version 'cerulean'
game 'gta5'

name "Coke Selling"
author "Made by Logan Murray"
version "1.0"


shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua', -- change en to your language
}

client_scripts {
	'@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
	'client/main.lua',
	'config.lua'
}

server_scripts {
	'server/main.lua',
	'config.lua'
}
