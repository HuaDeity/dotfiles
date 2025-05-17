-- lsp
vim.lsp.config("texlab", {
  on_attach = function()
    vim.keymap.set("n", "<leader>K", "<plug>(vimtex-doc-package)", { desc = "Vimtex Docs", silent = true })
  end,
})
vim.lsp.enable "texlab"
vim.lsp.enable "ltex_plus"

return {
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = {
      ensure_installed = { "bibtex", "latex" },
      disabled_filetypes = { "tex" },
    },
  },
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
    end,
    keys = {
      { "<localLeader>l", "", desc = "+vimtex", ft = "tex" },
    },
  },

  -- lint
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        tex = { "chktex" },
      },
    },
  },

  -- format
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        tex = { "latexindent" },
      },
    },
  },
}
