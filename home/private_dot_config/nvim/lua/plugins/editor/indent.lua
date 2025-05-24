return {
  {
    "folke/snacks.nvim",
    opts = {
      indent = { enabled = true },
      scope = { enabled = true },
    },
  },
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
  -- {
  --   "echasnovski/mini.indentscope",
  --   event = "VeryLazy",
  --   opts = {},
  -- },
}
