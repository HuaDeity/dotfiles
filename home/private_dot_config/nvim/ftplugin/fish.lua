--lsp
vim.lsp.enable "fish_lsp"

-- treesitter
require("nvim-treesitter").install "fish"

-- lint
require("lint").linters_by_ft.fish = { "fish" }

-- format
require("conform").formatters_by_ft.fish = { "fish_indent" }
