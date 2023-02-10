-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.python3_host_prog = "/opt/homebrew/bin/python3"
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt

-- opt.hlsearch = true
-- opt.showtabline = 0
-- opt.laststatus = 3
opt.guifont = "MonoLisa Nerd Font Mono:h13"
-- opt.breakindent = true
opt.fileencoding = "utf-8"
-- opt.expandtab = true
-- opt.softtabstop = 2

vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")
