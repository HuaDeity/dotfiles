vim.pack.add({
  "https://github.com/MagicDuck/grug-far.nvim",
})

require("grug-far").setup {
  headerMaxWidth = 80,
}

vim.keymap.set({ "n", "v" }, "<leader>sr", function()
  local grug = require "grug-far"
  local ext = vim.bo.buftype == "" and vim.fn.expand "%:e"
  grug.open {
    transient = true,
    prefills = {
      filesFilter = ext and ext ~= "" and "*." .. ext or nil,
    },
  }
end, { desc = "Search and Replace" })

-- Clear search on escape
vim.keymap.set({ "i", "n", "s" }, "<esc>", function()
  vim.cmd "noh"
  return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

if vim.g.vim_picker == "snacks" then
  -- stylua: ignore start
  vim.keymap.set("n", "g/", function() require("snacks").picker.grep() end, { desc = "Grep" })
  vim.keymap.set("n", "<leader>,", function() require("snacks").picker.buffers() end, { desc = "Buffers" })
  vim.keymap.set("n", "<leader>/", function() require("snacks").picker.grep() end, { desc = "Grep" })
  vim.keymap.set("n", "<leader>:", function() require("snacks").picker.command_history() end, { desc = "Command History" })
  vim.keymap.set("n", "<leader><space>", function() require("snacks").picker.smart() end, { desc = "Smart Pick" })
  vim.keymap.set("n", "<leader>n", function() require("snacks").picker.notifications() end, { desc = "Notification History" })
  -- find
  vim.keymap.set("n", "<leader>fb", function() require("snacks").picker.buffers() end, { desc = "Buffers" })
  vim.keymap.set("n", "<leader>fB", function() require("snacks").picker.buffers { hidden = true, nofile = true } end, { desc = "Buffers (all)" })
  vim.keymap.set("n", "<leader>fc", function() require("snacks").picker.files { cwd = vim.fn.stdpath "config" } end, { desc = "Find Config File" })
  vim.keymap.set("n", "<leader>ff", function() require("snacks").picker.files() end, { desc = "Find Files" })
  vim.keymap.set("n", "<leader>fg", function() require("snacks").picker.git_files() end, { desc = "Find Files (git-files)" })
  vim.keymap.set("n", "<leader>fr", function() require("snacks").picker.recent() end, { desc = "Recent" })
  vim.keymap.set("n", "<leader>fR", function() require("snacks").picker.recent { filter = { cwd = true } } end, { desc = "Recent (cwd)" })
  vim.keymap.set("n", "<leader>fp", function() require("snacks").picker.projects() end, { desc = "Projects" })
  -- grep
  vim.keymap.set("n", "<leader>sb", function() require("snacks").picker.lines() end, { desc = "Buffer Lines" })
  vim.keymap.set("n", "<leader>sB", function() require("snacks").picker.grep_buffers() end, { desc = "Grep Open Buffers" })
  vim.keymap.set("n", "<leader>sg", function() require("snacks").picker.grep() end, { desc = "Grep" })
  vim.keymap.set({ "n", "x" }, "<leader>sw", function() require("snacks").picker.grep_word() end, { desc = "Visual selection or word" })
  -- grep
  vim.keymap.set("n", "<leader>sb", function() require("snacks").picker.lines() end, { desc = "Buffer Lines" })
  vim.keymap.set("n", "<leader>sB", function() require("snacks").picker.grep_buffers() end, { desc = "Grep Open Buffers" })
  vim.keymap.set("n", "<leader>sg", function() require("snacks").picker.grep() end, { desc = "Grep" })
  vim.keymap.set({ "n", "x" }, "<leader>sw", function() require("snacks").picker.grep_word() end, { desc = "Visual selection or word" })
  -- search
  vim.keymap.set("n", '<leader>s"', function() require("snacks").picker.registers() end, { desc = "Registers" })
  vim.keymap.set("n", "<leader>s/", function() require("snacks").picker.search_history() end, { desc = "Search History" })
  vim.keymap.set("n", "<leader>sa", function() require("snacks").picker.autocmds() end, { desc = "Autocmds" })
  vim.keymap.set("n", "<leader>sc", function() require("snacks").picker.command_history() end, { desc = "Command History" })
  vim.keymap.set("n", "<leader>sC", function() require("snacks").picker.commands() end, { desc = "Commands" })
  vim.keymap.set("n", "<leader>sd", function() require("snacks").picker.diagnostics() end, { desc = "Diagnostics" })
  vim.keymap.set("n", "<leader>sD", function() require("snacks").picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
  vim.keymap.set("n", "<leader>sh", function() require("snacks").picker.help() end, { desc = "Help Pages" })
  vim.keymap.set("n", "<leader>sH", function() require("snacks").picker.highlights() end, { desc = "Highlights" })
  vim.keymap.set("n", "<leader>si", function() require("snacks").picker.icons() end, { desc = "Icons" })
  vim.keymap.set("n", "<leader>sj", function() require("snacks").picker.jumps() end, { desc = "Jumps" })
  vim.keymap.set("n", "<leader>sk", function() require("snacks").picker.keymaps() end, { desc = "Keymaps" })
  vim.keymap.set("n", "<leader>sl", function() require("snacks").picker.loclist() end, { desc = "Location List" })
  vim.keymap.set("n", "<leader>sm", function() require("snacks").picker.marks() end, { desc = "Marks" })
  vim.keymap.set("n", "<leader>sM", function() require("snacks").picker.man() end, { desc = "Man Pages" })
  vim.keymap.set("n", "<leader>sp", function() require("snacks").picker.lazy() end, { desc = "Search for Plugin Spec" })
  vim.keymap.set("n", "<leader>sq", function() require("snacks").picker.qflist() end, { desc = "Quickfix List" })
  vim.keymap.set("n", "<leader>sR", function() require("snacks").picker.resume() end, { desc = "Resume" })
  vim.keymap.set("n", "<leader>ss", function() require("snacks").picker.pickers() end, { desc = "Search Select Snacks" })
  vim.keymap.set("n", "<leader>su", function() require("snacks").picker.undo() end, { desc = "Undotree" })
  -- stylua: ignore end
end
