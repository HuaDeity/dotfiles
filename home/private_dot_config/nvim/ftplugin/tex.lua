local treesitter_disable_filetypes = vim.g.treesitter_disable_filetypes
vim.list_extend(treesitter_disable_filetypes, { "tex" })
vim.g.treesitter_disable_filetypes = treesitter_disable_filetypes
vim.bo.syntax = "ON" -- only if additional legacy syntax is needed

vim.keymap.set("n", "<leader>K", "<plug>(vimtex-doc-package)", { desc = "Vimtex Docs", silent = true, buffer = true })
vim.wo.wrap = true
vim.wo.spell = true

-- lint
-- require("lint").linters_by_ft.tex = { "chktex" }

-- format
require("conform").formatters_by_ft.tex = { "tex-fmt" }
