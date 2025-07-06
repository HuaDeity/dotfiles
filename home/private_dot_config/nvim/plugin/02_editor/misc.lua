vim.pack.add {
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
  "https://github.com/smjonas/inc-rename.nvim",
}

-- new file
vim.keymap.set("n", "<D-n>", "<cmd>enew<cr>", { desc = "New File" })
-- save file
vim.keymap.set({ "i", "x", "n", "s" }, "<D-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

require("render-markdown").setup {
  code = {
    sign = true,
    -- width = "block",
    -- right_pad = 1,
  },
  completions = {
    lsp = {
      enabled = true,
    },
    blink = {
      enabled = true,
    },
  },
  heading = {
    sign = true,
    icons = {},
  },
  checkbox = {
    enabled = true,
  },
  preset = "lazy",
}

Snacks.toggle({
  name = "Render Markdown",
  get = function() return require("render-markdown.state").enabled end,
  set = function(enabled)
    local m = require "render-markdown"
    if enabled then
      m.enable()
    else
      m.disable()
    end
  end,
}):map "<leader>um"
