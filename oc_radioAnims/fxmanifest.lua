fx_version("cerulean")
game 'gta5'

author('OverCode - FiveM')
description 'A simple radio anim resource.'
version '1.0 - RELEASE'
client_script 'client.lua'
lua54 'yes'

shared_scripts {
	'@es_extended/imports.lua',
	'@ox_lib/init.lua'
}

files {
	'stream'
}

dependencies {
	'ox_lib',
	'es_extended'
}
