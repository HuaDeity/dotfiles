vim.g.vimtex_view_method = "skim"
vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover

vim.pack.add { "https://github.com/lervag/vimtex" }

require("which-key").add {
  { "<localLeader>l", desc = "+vimtex", buffer = true },
}

-- lsp
vim.lsp.enable { "ltex_plus", "texlab" }

-- treesitter
require("nvim-treesitter").install "bibtex"
vim.treesitter.stop()
vim.bo.syntax = "ON"

vim.wo.wrap = true
vim.wo.spell = true
