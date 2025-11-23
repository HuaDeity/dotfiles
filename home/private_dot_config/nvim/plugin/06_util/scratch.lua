vim.pack.add({
  "https://github.com/folke/persistence.nvim",
  "https://github.com/wakatime/vim-wakatime",
})

vim.keymap.set("n", "<leader>.", function() require("snacks").scratch() end, { desc = "Toggle Scratch Buffer" })
vim.keymap.set("n", "<leader>S", function() require("snacks").scratch.select() end, { desc = "Select Scratch Buffer" })
