require("ts-comments").setup()
require("todo-comments").setup()

vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next Todo Comment" })
vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous Todo Comment" })
vim.keymap.set("n", "<leader>xt", "<cmd>Trouble todo toggle<cr>", { desc = "Todo (Trouble)" })
-- stylua: ignore
vim.keymap.set("n", "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", { desc = "Todo/Fix/Fixme (Trouble)" })

---@diagnostic disable: undefined-field
if vim.g.vim_picker == "snacks" then
  vim.keymap.set("n", "<leader>st", function() require("snacks").picker.todo_comments() end, { desc = "Todo" })
  -- stylua: ignore
  vim.keymap.set("n", "<leader>sT", function() require("snacks").picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, { desc = "Todo/Fix/Fixme" })
end
