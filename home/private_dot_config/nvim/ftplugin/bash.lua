-- lsp
vim.lsp.enable "bashls"

-- treesitter
require("nvim-treesitter").install "bash"

-- format
require("conform").formatters_by_ft.bash = { "shfmt" }
