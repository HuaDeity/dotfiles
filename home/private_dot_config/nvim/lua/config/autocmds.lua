-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Example: Close NvimTree buffer before auto-saving the current session
-- vim.api.nvim_create_autocmd("User", {
--   pattern = "DBSessionSavePre",
--   callback = function()
--     pcall(vim.cmd, "NvimTreeClose")
--   end,
-- })

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

local function open_nvim_tree(data)

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- create a new, empty buffer
  vim.cmd.enew()

  -- wipe the directory buffer
  vim.cmd.bw(data.buf)

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
