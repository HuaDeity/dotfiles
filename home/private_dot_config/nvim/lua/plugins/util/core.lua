return {
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "echasnovski/mini.misc",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("mini.misc").setup(opts)
      MiniMisc.setup_auto_root()
    end,
  },
  {
    "folke/snacks.nvim",
    opts = {
      bigfile = { enabled = true },
      image = { enabled = true },
      quickfile = { enabled = true },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      table.insert(
        opts.sections.lualine_c,
        -- stylua: ignore
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = function() return { fg = Snacks.util.color "Special" } end,
        }
      )
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = {
      extensions = { "lazy" },
    },
  },
}
