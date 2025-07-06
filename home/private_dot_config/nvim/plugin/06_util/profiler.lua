vim.g.startuptime_tries = 10

vim.pack.add { "https://github.com/dstein64/vim-startuptime" }

Snacks.toggle.profiler():map "<leader>dpp"
Snacks.toggle.profiler_highlights():map "<leader>dph"
vim.keymap.set("n", "<leader>dps", function() Snacks.profiler.scratch() end, { desc = "Profiler Scratch Buffer" })
