vim.keymap.set("n", "<S-z>Z", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
vim.keymap.set("n", "<S-z>Q", function() Snacks.bufdelete { force = true } end, { desc = "Delete Buffer(Force)" })
vim.keymap.set("n", "<S-z>A", function() Snacks.bufdelete.other() end, { desc = "Delete Other Buffers" })
