-- lsp
vim.lsp.enable "bashls"

-- treesitter
require("nvim-treesitter").install { "bash", "dotenv" }

-- format
require("conform").formatters_by_ft.sh = { "shfmt" }
