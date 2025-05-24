return {
  {
    "folke/snacks.nvim",
    dependencies = {
      "echasnovski/mini.icons",
    },
    opts = function(_, opts)
      local icons = require "mini.icons"
      opts.dashboard = {
        preset = {
          -- stylua: ignore
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = icons.get('directory', '.config'), key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = icons.get('filetype', "lazy"), key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      }
    end,
  },
  {
    "dstein64/nvim-scrollview",
    optional = true,
    opts = {
      excluded_filetypes = { "snacks_dashboard" },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = {
      options = {
        disabled_filetypes = {
          statusline = { "snacks_dashboard" },
        },
      },
    },
  },
}
