require("mini.deps").later(function()
  vim.treesitter.stop()
  vim.bo.syntax = "ON"
end)
