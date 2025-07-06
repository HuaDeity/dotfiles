vim.pack.add { "https://github.com/b0o/SchemaStore.nvim" }

-- lsp
vim.lsp.enable "yamlls"

-- treesitter
require("nvim-treesitter").install "yaml"

-- format
require("conform").formatters_by_ft.yaml = { "prettierd", "prettier", stop_after_first = true }
