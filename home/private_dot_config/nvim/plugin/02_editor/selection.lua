-- Send XTSHIFTESCAPE to the parent terminal on startup and reset on exit

-- Enable on startup (lazy loaded after UI is ready)
vim.api.nvim_create_autocmd("UIEnter", {
  group = vim.api.nvim_create_augroup("enter_xtshiftescape", { clear = true }),
  pattern = "*",
  once = true,
  callback = function() io.write "\x1b[>1s" end,
})

-- Disable on exit (restores default behavior)
vim.api.nvim_create_autocmd("VimLeave", {
  group = vim.api.nvim_create_augroup("leave_xtshiftescape", { clear = true }),
  pattern = "*",
  callback = function() io.write "\x1b[>0s" end,
})
