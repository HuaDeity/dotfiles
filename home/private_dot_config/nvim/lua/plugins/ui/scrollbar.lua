return {
  {
    "dstein64/nvim-scrollview",
    dependencies = { "lewis6991/gitsigns.nvim" },
    event = "VeryLazy",
    opts = {
      excluded_filetypes = { "noice", "snacks_dashboard", "snacks_layout_box" },
      signs_on_startup = {
        "all",
      },
    },
    config = function(_, opts)
      require("scrollview").setup(opts)
      require("scrollview.contrib.gitsigns").setup()
    end,
  },
  -- {
  --   "lewis6991/satellite.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  -- },
}
