vim.keymap.set("n", "<leader>fe", function() Snacks.explorer() end, { desc = "Explorer Snacks" })
vim.keymap.set("n", "<leader>e", "<leader>fe", { desc = "Explorer Snacks", remap = true })
