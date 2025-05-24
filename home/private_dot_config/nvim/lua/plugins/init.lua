require "config.init"

return {
  { import = "plugins.treesitter" },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    init = function() vim.g.snacks_animate = true end,
    opts = {},
    config = function(_, opts)
      local notify = vim.notify
      require("snacks").setup(opts)
      -- HACK: restore vim.notify after snacks setup and let noice.nvim take over
      -- this is needed to have early notifications show up in noice history
      vim.notify = notify
    end,
  },
  { import = "plugins.colorscheme.catppuccin" },
  { import = "plugins.ui" },
  { import = "plugins.util" },
  { import = "plugins.editor" },
  { import = "plugins.coding" },
  { import = "plugins.lsp.core" },
  { import = "plugins.linting" },
  { import = "plugins.formatting" },
  { import = "plugins.dap" },
  { import = "plugins.test" },
  { import = "plugins.lang" },
  { import = "plugins.ai" },
}
