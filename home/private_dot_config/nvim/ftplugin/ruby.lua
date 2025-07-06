-- lsp
vim.lsp.enable "ruby_lsp"

-- treesitter
require("nvim-treesitter").install "ruby"

-- lint
require("lint").linters_by_ft.ruby = { "robocop" }

-- format
require("conform").formatters_by_ft.ruby = { "robocop" }
