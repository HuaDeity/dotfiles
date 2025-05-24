return {
  {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    cmd = "HighlightColors",
    opts = {},
  },
}
