require('bufferline').setup{
  options = {
    close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
    right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
    offsets = { { filetype = "NvimTree", text = "File Tree", padding = 1} },
    separator_style = "thin", -- | "thick" | "slant" | { 'any', 'any' },
  },
}

