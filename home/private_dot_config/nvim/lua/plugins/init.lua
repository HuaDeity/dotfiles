require "config.init"

return {
  { import = "plugins.treesitter" },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {},
    config = function(_, opts)
      local notify = vim.notify
      require("snacks").setup(opts)
      -- HACK: restore vim.notify after snacks setup and let noice.nvim take over
      -- this is needed to have early notifications show up in noice history
      vim.notify = notify
    end,
    specs = {
      {
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = { disabled_filetypes = { "snacks" } },
      },
    },
  },
  { import = "plugins.colorscheme" },
  { import = "plugins.ui" },
  { import = "plugins.util" },
  { import = "plugins.editor" },
  { import = "plugins.coding" },
  { import = "plugins.lang" },
  { import = "plugins.ai" },
}
