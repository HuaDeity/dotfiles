require("trouble").setup()

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
-- stylua: ignore
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>cS", "<cmd>Trouble lsp toggle<cr>", { desc = "LSP references/definitions/... (Trouble)" })
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
vim.keymap.set("n", "[q", function()
  if require("trouble").is_open() then
    ---@diagnostic disable-next-line: missing-fields, missing-parameter
    require("trouble").prev { skip_groups = true, jump = true }
  else
    local ok, err = pcall(vim.cmd.cprev)
    if not ok then vim.notify(err, vim.log.levels.ERROR) end
  end
end, { desc = "Previous Trouble/Quickfix Item" })
vim.keymap.set("n", "]q", function()
  if require("trouble").is_open() then
    ---@diagnostic disable-next-line: missing-fields, missing-parameter
    require("trouble").next { skip_groups = true, jump = true }
  else
    local ok, err = pcall(vim.cmd.cnext)
    if not ok then vim.notify(err, vim.log.levels.ERROR) end
  end
end, { desc = "Next Trouble/Quickfix Item" })

-- location list
vim.keymap.set("n", "<leader>xl", function()
  local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
  if not success and err then vim.notify(err, vim.log.levels.ERROR) end
end, { desc = "Location List" })

-- quickfix list
vim.keymap.set("n", "<leader>xq", function()
  local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not success and err then vim.notify(err, vim.log.levels.ERROR) end
end, { desc = "Quickfix List" })
