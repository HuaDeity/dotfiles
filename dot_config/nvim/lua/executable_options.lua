-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true

-- Smart case
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250

-- Set term gui colors (most terminals support this)
vim.o.termguicolors = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Allows neovim to access the system clipboard
vim.o.clipboard = "unnamedplus"

-- We don't need to see things like -- INSERT -- anymore
vim.o.showmode = false

-- Always show tabs
vim.o.showtabline = 0

vim.o.laststatus = 3

-- Display lines as one long line
vim.o.wrap = false

-- The font used in graphical neovim applications
vim.o.guifont = "Iosevka Nerd Font Mono:h15"

-- Make line numbers default
vim.o.number = true

-- Always show the sign column, otherwise it would shift the text each time
vim.o.signcolumn = 'yes'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- The encoding written to a file
vim.o.fileencoding = "utf-8"

-- Make indenting smarter again
vim.o.smartindent = true

-- Convert tabs to spaces
vim.o.expandtab = true

-- The number of spaces inserted for each indentation
vim.o.shiftwidth = 2

vim.o.softtabstop = 2

-- Insert 2 spaces for a tab
vim.o.tabstop = 2

vim.o.splitbelow = true

vim.o.splitright = true

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
