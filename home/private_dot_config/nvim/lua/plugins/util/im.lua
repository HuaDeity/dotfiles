return {
  {
    "keaising/im-select.nvim",
    enabled = function() return not vim.env.SSH_TTY end,
    lazy = false,
    opts = {},
  },
}
