vim.pack.add({
  "https://github.com/nvim-mini/mini.move",
})

require("mini.move").setup {
  mappings = {
    -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
    left = "<",
    right = ">",
    down = "<M-Down>",
    up = "<M-Up>",

    -- Move current line in Normal mode
    line_left = "<",
    line_right = ">",
    line_down = "<M-Down>",
    line_up = "<M-Up>",
  },
}
