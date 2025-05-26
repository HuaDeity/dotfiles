return {
  {
    "keaising/im-select.nvim",
    enabled = function() return vim.env.SSH_TTY == nil end,
    lazy = false,
    opts = {},
  },
}
