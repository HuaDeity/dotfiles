local icons = require "mini.icons"

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      ---@type false | "classic" | "modern" | "helix"
      preset = "helix",
      --- You can add any mappings here, or use `require('which-key').add()` later
      ---@type wk.Spec
      spec = {
        {
          mode = { "n", "v" },
          { "<leader><tab>", group = "tabs" },
          { "<leader>c", group = "code" },
          { "<leader>d", group = "debug" },
          { "<leader>dp", group = "profiler" },
          { "<leader>f", group = "file/find" },
          { "<leader>g", group = "git" },
          { "<leader>gh", group = "hunks" },
          { "<leader>q", group = "quit/session" },
          { "<leader>s", group = "search" },
          { "<leader>u", group = "ui", icon = { icon = "󰙵", color = "cyan" } },
          {
            "<leader>x",
            group = "diagnostics/quickfix",
            icon = { icon = icons.get("filetype", "qf"), color = "green" },
          },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "gr", group = "LSP Stuffs" },
          -- { "gs", group = "surround" },
          { "z", group = "fold" },
          {
            "<S-Z>",
            group = "buffer",
            expand = function() return require("which-key.extras").expand.buf() end,
          },
          {
            "<leader>w",
            group = "windows",
            proxy = "<c-w>",
            expand = function() return require("which-key.extras").expand.win() end,
          },
          -- better descriptions
          { "gx", desc = "Open with system app" },
          { "K", desc = "Keyword Program" },
          { "gh", "K", desc = "Keyword Program", remap = true },
        },
      },
    },
    keys = {
      {
        "<leader>?",
        function() require("which-key").show { global = false } end,
        desc = "Buffer Keymaps (which-key)",
      },
      {
        "<c-w><space>",
        function() require("which-key").show { keys = "<c-w>", loop = true } end,
        desc = "Window Hydra Mode (which-key)",
      },
    },
  },
}
