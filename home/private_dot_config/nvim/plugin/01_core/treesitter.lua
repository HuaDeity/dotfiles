vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("TreesitterUpdate", { clear = true }),
  callback = function(args)
    if args.data.kind == "update" and args.data.spec.name == "nvim-treesitter" then
      require("mini.deps").later(function() vim.cmd "TSUpdate" end)
    end
  end,
  desc = "Treesitter: update parser automatically",
})
vim.pack.add { { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" } }

-- Highlight
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TreesitterHighlight", { clear = true }),
  callback = function() pcall(vim.treesitter.start) end,
  desc = "Treesitter: highlight syntax automatically",
})

require("nvim-treesitter").install { "printf", "regex" }

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

Snacks.toggle.treesitter():map "<leader>uT"
