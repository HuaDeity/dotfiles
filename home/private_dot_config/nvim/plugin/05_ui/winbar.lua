vim.pack.add { "https://github.com/Bekaboo/dropbar.nvim" }

require("dropbar").setup()

vim.keymap.set("n", "<Leader>;", function() require("dropbar.api").pick() end, { desc = "Pick symbols in winbar" })
-- stylua: ignore
vim.keymap.set("n", "[;", function() require("dropbar.api").goto_context_start() end, { desc = "Go to start of current context" })
vim.keymap.set("n", "];", function() require("dropbar.api").select_next_context() end, { desc = "Select next context" })
