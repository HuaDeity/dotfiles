vim.g.rustaceanvim = {
  server = {
    on_attach = function(_, bufnr)
      -- stylua: ignore
      vim.keymap.set("n", "gra", function() vim.cmd.RustLsp "codeAction" end, { desc = "vim.cmd.RustLsp(codeAction)", buffer = bufnr })
    end,
    default_settings = {
      -- rust-analyzer language server configuration
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          buildScripts = {
            enable = true,
          },
        },
        -- Add clippy lints for Rust if using rust-analyzer
        checkOnSave = true,
        diagnostics = {
          enable = true,
        },
        procMacro = {
          enable = true,
          ignored = {
            ["async-trait"] = { "async_trait" },
            ["napi-derive"] = { "napi" },
            ["async-recursion"] = { "async_recursion" },
          },
        },
        files = {
          excludeDirs = {
            ".direnv",
            ".git",
            ".github",
            ".gitlab",
            "bin",
            "node_modules",
            "target",
            "venv",
            ".venv",
          },
        },
      },
    },
  },
}

vim.pack.add {
  "https://github.com/Saecki/crates.nvim",
  "https://github.com/mrcjkb/rustaceanvim",
}

-- treesitter
require("nvim-treesitter").install "rust"

require("crates").setup {
  completion = {
    crates = {
      enabled = true,
    },
  },
  lsp = {
    enabled = true,
    actions = true,
    completion = true,
    hover = true,
  },
}

-- test
local adapter = require "rustaceanvim.neotest"
local adapters = require("neotest.config").adapters
table.insert(adapters, adapter)
