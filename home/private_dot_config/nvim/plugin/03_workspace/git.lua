vim.pack.add {
  "https://github.com/echasnovski/mini-git",
  "https://github.com/NeogitOrg/neogit",
  "https://github.com/pwntester/octo.nvim",
}

vim.keymap.set({ "n", "x" }, "<leader>gy", function() Snacks.gitbrowse() end, { desc = "Git Browser(Open)" })
-- stylua: ignore
---@diagnostic disable-next-line: missing-fields
vim.keymap.set({ "n", "x" }, "<leader>gY", function() Snacks.gitbrowse{ open = function(url) vim.fn.setreg("+", url) end, notify = false } end, { desc = "Git Browser(Copy)" })

if vim.g.vim_picker == "snacks" then
  vim.keymap.set("n", "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "Git Branches" })
  vim.keymap.set("n", "<leader>gB", function() Snacks.picker.git_log_line() end, { desc = "Git Blame Line" })
  vim.keymap.set("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git Diff (hunks)" })
  vim.keymap.set("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Current File History" })
  vim.keymap.set("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git Log" })
  vim.keymap.set("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" })
  vim.keymap.set("n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "Git Stash" })
end

require("mini.git").setup()
require("neogit").setup {
  graph_style = "kitty",
  integrations = { diffview = true, snacks = true },
}

vim.keymap.set("n", "<leader>gg", function() require("neogit").open() end, { desc = "Git Panel" })

require("octo").setup {
  enable_builtin = true,
  default_to_projects_v2 = true,
  default_merge_method = "squash",
  picker = "snacks",
}

vim.keymap.set("n", "<leader>gi", "<cmd>Octo issue list<CR>", { desc = "List Issues (Octo)" })
vim.keymap.set("n", "<leader>gI", "<cmd>Octo issue search<CR>", { desc = "Search Issues (Octo)" })
vim.keymap.set("n", "<leader>gp", "<cmd>Octo pr list<CR>", { desc = "List PRs (Octo)" })
vim.keymap.set("n", "<leader>gP", "<cmd>Octo pr search<CR>", { desc = "Search PRs (Octo)" })
vim.keymap.set("n", "<leader>gr", "<cmd>Octo repo list<CR>", { desc = "List Repos (Octo)" })
vim.keymap.set("n", "<leader>gS", "<cmd>Octo search<CR>", { desc = "Search (Octo)" })
