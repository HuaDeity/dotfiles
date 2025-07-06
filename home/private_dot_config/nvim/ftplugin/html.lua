-- lsp
vim.lsp.enable { "ltex_plus", "html", "superhtml" }

-- treesitter
require("nvim-treesitter").install "html"

-- format
require("conform").formatters_by_ft.html = { "superhtml" }
