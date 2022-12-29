-- Set colorscheme
--[[ require('onedarkpro').setup{ ]]
--[[   dark_theme = "onedark", ]]
--[[   light_theme = "onelight", ]]
--[[ } ]]
--[[ require('onedarkpro').load() ]]

require 'plugin_config.catppuccin'

require('auto-dark-mode').setup{
  update_interval = 100,
  set_dark_mode = function ()
    vim.o.background = 'dark'
    vim.cmd.colorscheme "catppuccin-mocha"
  end,
  set_light_mode = function ()
    vim.o.background = 'light'
    vim.cmd.colorscheme "catppuccin-latte"
  end,
}

require('auto-dark-mode').init()

