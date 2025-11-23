vim.pack.add({
  "https://github.com/nvim-mini/mini.surround",
})

require("mini.surround").setup {
  custom_surroundings = {
    -- Use tree-sitter to search for function call
    f = {
      input = require("mini.surround").gen_spec.input.treesitter { outer = "@call.outer", inner = "@call.inner" },
    },
  },
  mappings = {
    add = "ys", -- Add surrounding in Normal and Visual modes
    delete = "ds", -- Delete surrounding
    find = "", -- Find surrounding (to the right)
    find_left = "", -- Find surrounding (to the left)
    highlight = "", -- Highlight surrounding
    replace = "cs", -- Replace surrounding
    update_n_lines = "", -- Update `n_lines`

    -- Add this only if you don't want to use extended mappings
    -- suffix_last = "",
    -- suffix_next = "",
  },
  search_method = "cover_or_next",
}
vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { desc = "Add Surrounding", silent = true })
-- Remap adding surrounding to Visual mode selection
vim.keymap.del("x", "ys")
-- Make special mapping for "add surrounding for line"
vim.keymap.set("n", "yss", "ys_", { desc = "Add Surrounding(Line)", remap = true })
