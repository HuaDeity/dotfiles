return {
  { import = "lazyvim.plugins.extras.util.octo" },
  -- {
  --   "alanhamlett/neovim-wakatime",
  --   config = true,
  -- },
  {
    "keaising/im-select.nvim",
    config = function()
      require("im_select").setup({})
    end,
  },
}
