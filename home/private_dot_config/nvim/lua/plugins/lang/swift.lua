-- lsp
vim.lsp.enable "sourcekit"

return {
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = {
      ensure_installed = { "swift" },
    },
  },
}
