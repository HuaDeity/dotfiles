return {
  -- {
  --   "alanhamlett/neovim-wakatime",
  --   config = true,
  -- },
  { "wakatime/vim-wakatime", lazy = false },
  {
    "keaising/im-select.nvim",
    config = function()
      require("im_select").setup({})
    end,
  },
}
