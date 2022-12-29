-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = true,
    --[[ theme = 'onedarkpro', ]]
    theme = 'catppuccin',
    component_separators = { left = '|' , right = '|'},
    section_separators = { left = '' , right = ''},
    globalstatus = true,
  },
}
