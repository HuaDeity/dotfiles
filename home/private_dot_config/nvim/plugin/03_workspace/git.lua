vim.keymap.set({ "n", "x" }, "<leader>gy", function() require("snacks").gitbrowse() end, { desc = "Git Browser(Open)" })
-- stylua: ignore
---@diagnostic disable-next-line: missing-fields
vim.keymap.set({ "n", "x" }, "<leader>gY", function() require("snacks").gitbrowse{ open = function(url) vim.fn.setreg("+", url) end, notify = false } end, { desc = "Git Browser(Copy)" })

if vim.g.vim_picker == "snacks" then
  vim.keymap.set("n", "<leader>gb", function() require("snacks").picker.git_branches() end, { desc = "Git Branches" })
  vim.keymap.set("n", "<leader>gB", function() require("snacks").picker.git_log_line() end, { desc = "Git Blame Line" })
  vim.keymap.set("n", "<leader>gd", function() require("snacks").picker.git_diff() end, { desc = "Git Diff (hunks)" })
  vim.keymap.set(
    "n",
    "<leader>gf",
    function() require("snacks").picker.git_log_file() end,
    { desc = "Git Current File History" }
  )
  vim.keymap.set("n", "<leader>gl", function() require("snacks").picker.git_log() end, { desc = "Git Log" })
  vim.keymap.set("n", "<leader>gs", function() require("snacks").picker.git_status() end, { desc = "Git Status" })
  vim.keymap.set("n", "<leader>gS", function() require("snacks").picker.git_stash() end, { desc = "Git Stash" })
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
