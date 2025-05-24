return {
  {
    "keaising/im-select.nvim",
    enabled = function() return vim.env.SSH_TTY ~= 1 end,
    lazy = false,
    opts = {},
  },
}
