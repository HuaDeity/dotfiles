vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

-- Highlight
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TreesitterHighlight", { clear = true }),
  callback = function() pcall(vim.treesitter.start) end,
  desc = "Treesitter: highlight syntax automatically",
})

require("nvim-treesitter").install { "printf", "regex" }

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

require("snacks").toggle.treesitter():map "<leader>uT"
