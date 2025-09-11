-- lsp
vim.lsp.enable "protols"

-- treesitter
vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdate",
  callback = function()
    require("nvim-treesitter.parsers").proto = {
      install_info = {
        url = "https://github.com/coder3101/tree-sitter-proto",
        revision = "0f514c4a6fa64003bfa0705a4fb3f224899f7a36", -- commit hash for revision to check out; HEAD if missing
      },
      maintainers = { "@coder3101" },
      tier = 2,
    }
  end,
})

require("nvim-treesitter").install "proto"
