local M = {}

M.setup = function()
  local config = {
    virtual_text = false, -- disable virtual text
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

return M
