-- lsp
vim.lsp.enable "html"

return {
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = {
      ensure_installed = { "html", "xml" },
    },
  },

  -- format
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        html = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {},
  },
}
