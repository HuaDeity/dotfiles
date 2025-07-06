vim.pack.add { "https://github.com/mrjones2014/smart-splits.nvim" }

require("smart-splits").setup {
  default_amount = 2,
}

vim.keymap.set("n", "<C-h>", function() require("smart-splits").move_cursor_left() end, { desc = "Go to Left Window" })
vim.keymap.set("n", "<C-j>", function() require("smart-splits").move_cursor_down() end, { desc = "Go to Lower Window" })
vim.keymap.set("n", "<C-k>", function() require("smart-splits").move_cursor_up() end, { desc = "Go to Upper Window" })
-- stylua: ignore
vim.keymap.set("n", "<C-l>", function() require("smart-splits").move_cursor_right() end, { desc = "Go to Right Window" })
-- vim.keymap.set("n", "<C-\\>", function() require("smart-splits").move_cursor_previous() end, { desc = "Go to prev Window" })
vim.keymap.set("n", "<A-k>", function() require("smart-splits").resize_up() end, { desc = "Increase Window Height" })
vim.keymap.set("n", "<A-j>", function() require("smart-splits").resize_down() end, { desc = "Decrease Window Height" })
vim.keymap.set("n", "<A-h>", function() require("smart-splits").resize_left() end, { desc = "Decrease Window Width" })
vim.keymap.set("n", "<A-l>", function() require("smart-splits").resize_right() end, { desc = "Increase Window Width" })
