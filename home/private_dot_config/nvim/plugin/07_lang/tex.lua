vim.g.vimtex_view_method = "skim"

-- vim.g.vimtex_compiler_method = "generic"
vim.g.vimtex_compiler_generic = {
  command = "ls *.tex | entr -c tectonic /_ -Z shell-escape --synctex --keep-logs",
}
vim.g.vimtex_compiler_tectonic = {
  out_dir = "",
  hooks = {},
  options = {
    "-Z",
    "shell-escape",
    "--synctex",
    "--keep-logs",
  },
}

vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover

vim.pack.add { "https://github.com/lervag/vimtex" }

require("which-key").add {
  { "<localLeader>l", desc = "+vimtex", buffer = true },
}

-- lsp
vim.lsp.enable { "ltex_plus", "texlab" }
