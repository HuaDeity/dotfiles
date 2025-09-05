---@diagnostic disable-next-line: missing-fields
require("edgy").setup {
  left = {
    -- {
    --   -- ft = "snacks_layout_box",
    --   ft = "snacks_picker_list",
    --   title = "Explorer",
    --   size = { width = 30 },
    --   pinned = true,
    --   open = function() require("snacks").explorer() end,
    --   filter = function(buf, win) return vim.api.nvim_win_get_config(win).relative == "" end,
    -- },
    { title = "Aerial", ft = "aerial", pinned = true, open = "AerialOpen" },
    { title = "Neotest Summary", ft = "neotest-summary" },
  },
  right = {
    {
      ft = "codecompanion",
      title = "CodeCompanion",
      size = { width = 30 },
      pinned = true,
      open = "CodeCompanionChat Toggle",
      filter = function(_, win) return vim.api.nvim_win_get_config(win).relative == "" end,
    },
    { title = "Grug Far", ft = "grug-far", size = { width = 0.4 } },
    { title = "Overseer", ft = "OverseerList", open = function() require("overseer").open() end },
  },
  bottom = {
    {
      ft = "snacks_terminal",
      size = { height = 0.4 },
      title = "%{b:snacks_terminal.id}: %{b:term_title}",
      filter = function(_, win)
        return vim.w[win].snacks_win
          and vim.w[win].snacks_win.position == "bottim"
          and vim.w[win].snacks_win.relative == "editor"
          and not vim.w[win].trouble_preview
      end,
    },
    { ft = "qf", title = "QuickFix" },
    {
      ft = "help",
      size = { height = 20 },
      -- don't open help files in edgy that we're editing
      filter = function(buf) return vim.bo[buf].buftype == "help" end,
    },
    {
      ft = "trouble",
      filter = function(_, win)
        return vim.w[win].trouble
          and vim.w[win].trouble.position == "bottom"
          and vim.w[win].trouble.type == "split"
          and vim.w[win].trouble.relative == "editor"
          and not vim.w[win].trouble_preview
      end,
    },
    { title = "Neotest Output", ft = "neotest-output-panel", size = { height = 15 } },
    {
      ft = "noice",
      size = { height = 0.4 },
      filter = function(_, win) return vim.api.nvim_win_get_config(win).relative == "" end,
    },
  },
  top = {},
  keys = {
    -- increase width
    ["<A-l>"] = function(win) win:resize("width", 2) end,
    -- decrease width
    ["<A-h>"] = function(win) win:resize("width", -2) end,
    -- increase height
    ["<A-k>"] = function(win) win:resize("height", 2) end,
    -- decrease height
    ["<A-j>"] = function(win) win:resize("height", -2) end,
  },
}

vim.keymap.set("n", "<leader>ue", function() require("edgy").toggle() end, { desc = "Edgy Toggle" })
-- stylua: ignore
vim.keymap.set("n", "<leader>uE", function() require("edgy").select() end, { desc = "Edgy Select Window" })
vim.keymap.set({ "n", "i" }, "<D-b>", function() require("edgy").toggle "left" end, { desc = "Toggle Left Edgy" })
vim.keymap.set({ "n", "i" }, "<D-r>", function() require("edgy").toggle "right" end, { desc = "Toggle Right Edgy" })
vim.keymap.set({ "n", "i" }, "<D-j>", function() require("edgy").toggle "bottom" end, { desc = "Toggle Bottom Edgy" })
vim.keymap.set({ "n", "i" }, "<A-D-y>", function() require("edgy").close() end, { desc = "Close All Edgy" })
