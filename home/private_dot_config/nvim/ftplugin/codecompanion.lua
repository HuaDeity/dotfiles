--stylua: ignore
vim.keymap.set({ "n", "i", "x" }, "<D-A-n>", "<cmd>CodeCompanionChat<CR>", { noremap = true, silent = true, buffer = true, desc = "New Chat" })

-- Setup spinner for CodeCompanion
local spinner = require "spinner"

-- Set up autocommands for CodeCompanion events
local group = vim.api.nvim_create_augroup("CodeCompanionSpinner", { clear = true })

vim.api.nvim_create_autocmd("User", {
  pattern = "CodeCompanionRequestStarted",
  group = group,
  callback = function()
    spinner.start_for_filetype("codecompanion", {
      message = "Processing...",
      highlight = "Comment",
      position = "below",
    })
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "CodeCompanionRequestFinished",
  group = group,
  callback = function() spinner.stop_for_filetype "codecompanion" end,
})

-- Buffer-local cleanup when buffer is deleted
vim.api.nvim_create_autocmd("BufDelete", {
  buffer = 0,
  group = group,
  callback = function() spinner.stop_for_buffer(0) end,
})
