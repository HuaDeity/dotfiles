return {
  {
    "linux-cultist/venv-selector.nvim",
    enabled = function()
      return LazyVim.has_extra("lang.python")
    end,
  },

  -- just
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "just" } },
  },

  vim.lsp.enable("just-lsp"),
}
