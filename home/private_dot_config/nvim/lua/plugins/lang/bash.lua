vim.filetype.add {
  pattern = {
    ["%.env%.[%w_.-]+"] = "sh",
  },
}

-- lsp
vim.lsp.enable "bashls"

return {
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = { ensure_installed = { "bash" } },
  },

  -- format
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        bash = { "shfmt" },
        sh = { "shfmt" },
      },
    },
  },
}
