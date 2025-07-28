if vim.env.PROF then
  local snacks = vim.fn.stdpath "data" .. "/site/pack/core/opt/snacks.nvim"
  vim.opt.rtp:append(snacks)
  ---@diagnostic disable-next-line: missing-fields
  require("snacks.profiler").startup {
    startup = {
      event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
      -- event = "UIEnter",
      -- event = "VeryLazy",
    },
  }
end
