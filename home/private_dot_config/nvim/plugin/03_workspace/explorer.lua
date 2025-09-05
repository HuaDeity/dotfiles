vim.keymap.set("n", "<leader>fe", function() require("snacks").explorer() end, { desc = "Explorer Snacks" })
vim.keymap.set("n", "<leader>e", "<leader>fe", { desc = "Explorer Snacks", remap = true })
