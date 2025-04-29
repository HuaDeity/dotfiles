return {
  {
    "linux-cultist/venv-selector.nvim",
    enabled = function()
      return LazyVim.has_extra("lang.python")
    end,
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
