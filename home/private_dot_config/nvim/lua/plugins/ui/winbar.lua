return {
  {
    "Bekaboo/dropbar.nvim",
    event = "VeryLazy",
    keys = {
      { "<Leader>;", function() require("dropbar.api").pick() end, desc = "Pick symbols in winbar" },
      { "[;", function() require("dropbar.api").goto_context_start() end, desc = "Go to start of current context" },
      { "];", function() require("dropbar.api").select_next_context() end, desc = "Select next context" },
    },
    opts = {},
  },
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   opts = {
  --     winbar = {
  --       lualine_c = {
  --         { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
  --       },
  --     },
  --   },
  -- },
}
