vim.pack.add({
  "https://github.com/dstein64/vim-startuptime",
})
vim.g.startuptime_tries = 10

require("snacks").toggle.profiler():map "<leader>dpp"
require("snacks").toggle.profiler_highlights():map "<leader>dph"
vim.keymap.set(
  "n",
  "<leader>dps",
  function() require("snacks").profiler.scratch() end,
  { desc = "Profiler Scratch Buffer" }
)
