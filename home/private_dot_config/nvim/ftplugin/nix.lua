-- lsp
vim.lsp.enable { "nil_ls", "nixd" }

-- treesitter
require("nvim-treesitter").install "nix"

-- format
require("conform").formatters_by_ft.nix = { "alejandra" }
