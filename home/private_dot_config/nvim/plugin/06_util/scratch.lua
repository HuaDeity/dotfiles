vim.keymap.set("n", "<leader>.", function() require("snacks").scratch() end, { desc = "Toggle Scratch Buffer" })
vim.keymap.set("n", "<leader>S", function() require("snacks").scratch.select() end, { desc = "Select Scratch Buffer" })
