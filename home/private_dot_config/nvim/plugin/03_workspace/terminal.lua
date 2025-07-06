vim.keymap.set("n", "<leader>ft", function() Snacks.terminal() end, { desc = "Terminal" })
vim.keymap.set("n", "C-`", function() Snacks.terminal() end, { desc = "Terminal" })
vim.keymap.set("n", "C-S-`", function() Snacks.terminal.open() end, { desc = "New Terminal" })
