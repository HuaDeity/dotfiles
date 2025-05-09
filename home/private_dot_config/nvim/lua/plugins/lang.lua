return {
  {
    "linux-cultist/venv-selector.nvim",
    enabled = function()
      return LazyVim.has_extra("lang.python")
    end,
    opts = {
      search = {
        cwd = false,
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        python = { "ruff" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = {
          -- To fix auto-fixable lint errors.
          "ruff_fix",
          -- To run the Ruff formatter.
          "ruff_format",
          -- To organize the imports.
          "ruff_organize_imports",
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- just
        "just",
      },
    },
  },

  vim.lsp.enable({ "just-lsp" }),
}
