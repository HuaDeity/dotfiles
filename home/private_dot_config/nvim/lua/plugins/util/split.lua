local term = vim.trim((vim.env.TERM_PROGRAM or ""):lower())
local mux = term == "tmux" or term == "wezterm" or vim.env.KITTY_LISTEN_ON

return {
  {
    "mrjones2014/smart-splits.nvim",
    event = mux and "VeryLazy" or nil,
    opts = {
      default_amount = 2,
    },
    keys = {
      { "<C-h>", function() require("smart-splits").move_cursor_left() end, desc = "Go to Left Window" },
      { "<C-j>", function() require("smart-splits").move_cursor_down() end, desc = "Go to Lower Window" },
      { "<C-k>", function() require("smart-splits").move_cursor_up() end, desc = "Go to Upper Window" },
      { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "Go to Right Window" },
      -- { "<C-\\>", function() require("smart-splits").move_cursor_previous() end, desc = "Go to prev Window" },
      { "<A-k>", function() require("smart-splits").resize_up() end, desc = "Increase Window Height" },
      { "<A-j>", function() require("smart-splits").resize_down() end, desc = "Decrease Window Height" },
      { "<A-h>", function() require("smart-splits").resize_left() end, desc = "Decrease Window Width" },
      { "<A-l>", function() require("smart-splits").resize_right() end, desc = "Increase Window Width" },
    },
  },
}
