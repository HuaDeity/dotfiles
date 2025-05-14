return {
  {
    "NMAC427/guess-indent.nvim",
    cmd = "GuessIndent",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {},
  },
  -- {
  --   "Darazaki/indent-o-matic",
  --   cmd = "IndentOMatic",
  --   event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  -- },
  -- { -- Add indentation guides even on blank lines
  --   "lukas-reineke/indent-blankline.nvim",
  --   -- Enable `lukas-reineke/indent-blankline.nvim`
  --   -- See `:help ibl`
  --   main = "ibl",
  --   opts = {},
  -- },
}
