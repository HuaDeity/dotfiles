vim.keymap.set("n", "<leader>ft", function() require("snacks").terminal() end, { desc = "Terminal" })
vim.keymap.set("n", "C-`", function() require("snacks").terminal() end, { desc = "Terminal" })
vim.keymap.set("n", "C-S-`", function() require("snacks").terminal.open() end, { desc = "New Terminal" })
