vim.pack.add({
  "https://github.com/folke/which-key.nvim",
})

---@diagnostic disable-next-line: missing-fields
require("which-key").setup {
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
      { "<leader>u", group = "ui" },
      { "<leader>x", group = "diagnostics/quickfix" },
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
      { "<leader>sn", desc = "+noice" },
    },
  },
}

-- stylua: ignore start
vim.keymap.set("n", "<leader>?", function() require("which-key").show { global = false } end, { desc = "Buffer Keymaps (which-key)" })
vim.keymap.set("n", "<c-w><space>", function() require("which-key").show { keys = "<c-w>", loop = true } end, { desc = "Window Hydra Mode (which-key)" })
-- stylua: ignore end
