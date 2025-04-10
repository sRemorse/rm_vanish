fx_version   'cerulean'
use_experimental_fxv2_oal 'yes'
lua54        'yes'
game         'gta5'


shared_scripts {
    "shared/config.lua",
    "shared/locale.lua",
    "helpers.lua",
}

client_scripts {
    "client/*.lua",
}

server_scripts {
    "server/*.lua",
}

files {
    'locales/*.json',
}

