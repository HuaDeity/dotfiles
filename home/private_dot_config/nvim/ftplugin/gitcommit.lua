-- lsp
vim.lsp.enable "ltex_plus"

-- treesitter
require("nvim-treesitter").install "gitcommit"

local autosave_excluded_filetypes = vim.g.autosave_excluded_filetypes
vim.list_extend(autosave_excluded_filetypes, { "gitcommit" })
vim.g.autosave_excluded_filetypes = autosave_excluded_filetypes

vim.wo.wrap = true
vim.wo.spell = true
