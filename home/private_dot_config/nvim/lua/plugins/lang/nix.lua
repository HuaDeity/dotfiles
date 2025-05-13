-- lsp
vim.lsp.enable "nil_ls"

return {
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    optinal = true,
    opts = { ensure_installed = { "nix" } },
  },

  -- format
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        nix = { "nixfmt" },
      },
    },
  },
}
