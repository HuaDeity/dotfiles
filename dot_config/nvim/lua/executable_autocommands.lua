-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Example: Close NvimTree buffer before auto-saving the current session
vim.api.nvim_create_autocmd('User', {
  pattern = 'DBSessionSavePre',
  callback = function()
    pcall(vim.cmd, 'NvimTreeClose')
  end,
})

-- vim.api.nvim_create_autocmd("ColorSchemePre", {
--     pattern = "*",
--     callback = function()
--       local is_dark_mode = vim.fn.system('defaults read -g AppleInterfaceStyle')
--       if(string.len(is_dark_mode) == 5) then
--         pcall(require('catppuccin').setup, {flavour = 'mocha'})
--       else
--         pcall(require('catppuccin').setup, {flavour = 'latte'})
--       end
--     end
-- })
