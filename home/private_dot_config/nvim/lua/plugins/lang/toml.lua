-- lsp
vim.lsp.enable "taplo"

return {
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = {
      ensure_installed = { "toml" },
    },
  },
}
