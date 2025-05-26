return {
  ---@module "neominimap.config.meta"
  {
    "Isrothy/neominimap.nvim",
    lazy = false, -- NOTE: NO NEED to Lazy load
    init = function()
      --- Put your configuration here
      ---@type Neominimap.UserConfig
      vim.g.neominimap = {
        auto_enable = true,
        click = {
          -- Enable mouse click on the minimap
          enabled = true, ---@type boolean
          -- Automatically switch focus to the minimap when clicked
          auto_switch_focus = true, ---@type boolean
        },
        float = {
          margin = {
            right = 2,
          },
          minimap_width = 10, ---@type integer
        },

        diagnostic = {
          use_event_diagnostics = true, ---@type boolean
          mode = "line", ---@type Neominimap.Handler.Annotation.Mode
        },

        mark = {
          enabled = true,
        },

        search = {
          enabled = false,
        },

        --- Override the default window options
        ---@param opt vim.wo
        ---@param winid integer the window id of the source window, NOT the minimap window
        winopt = function(opt, winid) opt.winblend = 25 end,

        -- How many columns a dot should span
        x_multiplier = 3, ---@type integer
        -- How many rows a dot should span
        y_multiplier = 2, ---@type integer
      }
    end,
    config = function() end,
  },
  {
    "dstein64/nvim-scrollview",
    event = "VeryLazy",
    opts_extend = { "excluded_filetypes" },
    opts = {
      signs_on_startup = {
        "all",
      },
    },
    config = function(_, opts) require("scrollview").setup(opts) end,
  },
  -- {
  --   "lewis6991/satellite.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  -- },
  --   {
  --   "echasnovski/mini.map",
  --   dependencies = { "lewis6991/gitsigns.nvim" },
  --   event = "VeryLazy",
  --   opts = function()
  --     local map = require "mini.map"
  --     return {
  --       integrations = {
  --         map.gen_integration.builtin_search(),
  --       },
  --       symbols = {
  --         encode = map.gen_encode_symbols.dot "3x2",
  --       },
  --       window = {
  --         focusable = true,
  --         show_integration_count = false,
  --       },
  --     }
  --   end,
  --   config = function(_, opts)
  --     require("mini.map").setup(opts)
  --     MiniMap.open()
  --   end,
  --   keys = {
  --     { "<leader>um", function() require("mini.map").toggle() end, desc = "Toggle minimap" },
  --   },
  -- },
}
