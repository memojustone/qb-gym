fx_version 'adamant'
game 'gta5'

description 'qb-gym for QBCORE'

version '1.0.0'


server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/main.lua'
}

client_scripts {
  'client/main.lua'
}

shared_scripts {
  'config.lua'
}

lua54 'yes'