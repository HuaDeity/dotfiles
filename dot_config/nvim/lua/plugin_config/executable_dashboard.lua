-- local home = os.getenv('HOME')
local db = require('dashboard')
-- db.preview_command = 'cat | lolcat -F 0.3'
-- db.preview_file_path = home .. '/.config/nvim/static/neovim.cat'
-- db.preview_file_height = 18
-- db.preview_file_width = 43
db.custom_header = {
'               ▄▄██████████▄▄             ',
'               ▀▀▀   ██   ▀▀▀             ',
'       ▄██▄   ▄▄████████████▄▄   ▄██▄     ',
'     ▄███▀  ▄████▀▀▀    ▀▀▀████▄  ▀███▄   ',
'    ████▄ ▄███▀              ▀███▄ ▄████  ',
'   ███▀█████▀▄████▄      ▄████▄▀█████▀███ ',
'   ██▀  ███▀ ██████      ██████ ▀███  ▀██ ',
'    ▀  ▄██▀  ▀████▀  ▄▄  ▀████▀  ▀██▄  ▀  ',
'       ███           ▀▀           ███     ',
'       ██████████████████████████████     ',
'   ▄█  ▀██  ███   ██    ██   ███  ██▀  █▄ ',
'   ███  ███ ███   ██    ██   ███▄███  ███ ',
'   ▀██▄████████   ██    ██   ████████▄██▀ ',
'    ▀███▀ ▀████   ██    ██   ████▀ ▀███▀  ',
'     ▀███▄  ▀███████    ███████▀  ▄███▀   ',
'       ▀███    ▀▀██████████▀▀▀   ███▀     ',
'         ▀    ▄▄▄    ██    ▄▄▄    ▀       ',
'               ▀████████████▀             ',
'																					 ',
}
db.custom_footer = {'HuaDeity'}
db.custom_center = {
    {icon = '  ',
    desc = 'Recently latest session                 ',
    action = 'SessionLoad',
    shortcut = 'SPC s l'},
    {icon = '  ',
    desc = 'Recently opened file                    ',
    action =  'Telescope oldfiles',
    shortcut = 'SPC ?  '},
    {icon = '  ',
    desc = 'Find  File                              ',
    action = 'Telescope find_files',
    shortcut = 'SPC f f'},
    {icon = '  ',
    desc = 'Find  Project                           ',
    action = 'Telescope projects',
    shortcut = 'SPC f p'},
    {icon = '  ',
    desc = 'File  Browser                           ',
    action =  'Telescope file_browser',
    shortcut = 'SPC f b'},
    {icon = '  ',
    desc = 'Find  text                              ',
    action = 'Telescope live_grep',
    shortcut = 'SPC f g'},
    {icon = '  ',
    desc = 'New file                                ',
    action =  'DashboardNewFile',
    shortcut = 'Spc f n'},
    {icon = '  ',
    desc = 'Quit                                    ',
    action = 'qa',
    shortcut = ':qa    '},
}
db.session_directory = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/")
db.session_auto_save_on_exit = ture

