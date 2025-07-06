local diagnostic_icons = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " ",
}
vim.diagnostic.config {
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = function(diagnostic)
      for d, icon in pairs(diagnostic_icons) do
        if diagnostic.severity == vim.diagnostic.severity[d:upper()] then return icon end
        return " "
      end
    end,
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = diagnostic_icons.Error,
      [vim.diagnostic.severity.WARN] = diagnostic_icons.Warn,
      [vim.diagnostic.severity.HINT] = diagnostic_icons.Hint,
      [vim.diagnostic.severity.INFO] = diagnostic_icons.Info,
    },
  },
  float = { source = "if_many" },
}

Snacks.toggle.diagnostics():map "<leader>ud"
