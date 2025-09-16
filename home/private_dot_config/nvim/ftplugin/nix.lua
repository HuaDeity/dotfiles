-- lsp
vim.lsp.enable { "nixd" }

-- treesitter
require("nvim-treesitter").install "nix"

-- format
require("conform").formatters_by_ft.nix = { "nixfmt" }
