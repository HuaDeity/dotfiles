-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.deprecation_warnings = true

-- Make line numbers default
vim.o.number = true

-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function() vim.o.clipboard = "unnamedplus" end)
if vim.env.SSH_TTY then vim.g.clipboard = "osc52" end

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 200

-- Decrease mapped sequence wait time
vim.o.timeoutlen = vim.g.vscode and 1000 or 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.listchars:append { precedes = "<", extends = ">" }

vim.o.smoothscroll = true

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 4

-- Disable line wrap
vim.o.wrap = false
-- Wrap lines at convenient point
vim.o.linebreak = true
-- Columns of context
vim.o.sidescrolloff = 8

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- True color support
vim.o.termguicolors = true

-- Enable auto write
vim.o.autowrite = true

vim.o.completeopt = "menu,menuone,noselect"

-- Hide * markup for bold and italic, but not markers with substitutions
vim.o.conceallevel = 2

vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

vim.o.formatoptions = "jcroqlnt" -- tcqj

vim.o.grepformat = "%f:%l:%c:%m"

vim.o.grepprg = "rg --vimgrep"

vim.o.jumpoptions = "view"

-- global statusline
vim.o.laststatus = 3

-- Popup blend
vim.o.pumblend = 10

-- Disable the default ruler
vim.o.ruler = false

vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

vim.opt.shortmess:append { W = true, I = true, c = true, C = true }

-- Round indent
vim.o.shiftround = true

vim.opt.spelllang = { "en" }

vim.o.splitkeep = "screen"

-- vim.o.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]

vim.o.undolevels = 10000

-- Allow cursor to move where there is no text in visual block mode
vim.o.virtualedit = "block"

-- Command-line completion mode
vim.o.wildmode = "longest:full,full"

-- Minimum window width
vim.o.winminwidth = 5
