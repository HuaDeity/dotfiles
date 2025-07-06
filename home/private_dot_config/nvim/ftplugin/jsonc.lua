vim.pack.add { "https://github.com/b0o/SchemaStore.nvim" }

-- lsp
vim.lsp.enable "jsonls"

-- treesitter
require("nvim-treesitter").install "jsonc"

-- lint
require("lint").linters_by_ft.jsonc = { "biomejs" }

-- format
require("conform").formatters_by_ft.jsonc = { "biome-check", "biome", "biome-organize-imports" }

vim.opt_local.conceallevel = 0
