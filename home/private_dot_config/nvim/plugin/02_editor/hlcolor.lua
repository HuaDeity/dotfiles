vim.pack.add { "https://github.com/brenoprata10/nvim-highlight-colors" }

require("nvim-highlight-colors").setup {
  enable_named_colors = false,
  enable_short_hex = false,
  enable_tailwind = true,
}
