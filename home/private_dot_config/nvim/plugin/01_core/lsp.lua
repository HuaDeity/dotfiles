local function lsp_attach(client, bufnr)
  -- stylua: ignore start
  -- File rename capability
  if client:supports_method("workspace/didRenameFiles", bufnr) or client:supports_method("workspace/willRenameFiles", bufnr) then
    vim.keymap.set("n", "grN", function() require("snacks").rename.rename_file() end, { desc = "Rename File", buffer = bufnr })
  end

  -- LSP navigation keys
  if vim.g.vim_picker == "snacks" then
    if client:supports_method("textDocument/definition", bufnr) then
      vim.keymap.set("n", "gd", function() require("snacks").picker.lsp_definitions() end, { desc = "Goto Definition", buffer = bufnr })
    end
    if client:supports_method("textDocument/declaration", bufnr) then
      vim.keymap.set("n", "gD", function() require("snacks").picker.lsp_declarations() end, { desc = "Goto Declaration", buffer = bufnr })
    end
    if client:supports_method("textDocument/typeDefinition", bufnr) then
      vim.keymap.set("n", "gy", function() require("snacks").picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition", buffer = bufnr })
    end
  else
    if client:supports_method("textDocument/definition", bufnr) then
      vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { desc = "Goto Definition", buffer = bufnr })
    end
    if client:supports_method("textDocument/declaration", bufnr) then
      vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, { desc = "Goto Declaration", buffer = bufnr })
    end
    if client:supports_method("textDocument/typeDefinition", bufnr) then
      vim.keymap.set("n", "gy", function() vim.lsp.buf.type_definition() end, { desc = "Goto T[y]pe Definition", buffer = bufnr })
    end
  end
  -- stylua: ignore end

  -- code lens
  if client:supports_method("textDocument/codeLens", bufnr) then
    -- vim.lsp.codelens.refresh()
    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      callback = function() vim.lsp.codelens.refresh { bufnr = 0 } end,
    })
  end

  -- fold
  if client:supports_method("textDocument/foldingRange", bufnr) then
    local win = vim.api.nvim_get_current_win()
    vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
  end

  -- inlay hints
  if client:supports_method("textDocument/inlayHint", bufnr) then
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
  end
end

vim.lsp.config("*", {
  capabilities = {
    workspace = {
      fileOperations = {
        didRename = true,
        willRename = true,
      },
    },
  },
})

-- zed specific
vim.keymap.set("n", "cd", function() vim.lsp.buf.rename() end, { desc = "vim.lsp.buf.rename()" })
vim.keymap.set({ "n", "x" }, "g.", function() vim.lsp.buf.code_action() end, { desc = "vim.lsp.buf.code_action()" })
vim.keymap.set("i", "<C-x><C-l>", function() vim.lsp.buf.code_action() end, { desc = "vim.lsp.buf.code_action()" })
if vim.g.vim_picker == "snacks" then
  -- stylua: ignore start
  vim.keymap.set("n", "grr", function() require("snacks").picker.lsp_references() end, { desc = "vim.lsp.buf.references()" })
  vim.keymap.set("n", "gri", function() require("snacks").picker.lsp_implementations() end, { desc = "vim.lsp.buf.implementation()" })
  vim.keymap.set("n", "gO", function() require("snacks").picker.lsp_symbols() end, { desc = "vim.lsp.buf.document_symbol()" })
  vim.keymap.set("n", "gA", function() require("snacks").picker.lsp_references() end, { desc = "vim.lsp.buf.references()" }) -- zed specific
  vim.keymap.set("n", "gI", function() require("snacks").picker.lsp_implementations() end, { desc = "vim.lsp.buf.implementation()" })
  vim.keymap.set("n", "gs", function() require("snacks").picker.lsp_symbols() end, { desc = "vim.lsp.buf.document_symbol()" })
  vim.keymap.set("n", "gS", function() require("snacks").picker.lsp_workspace_symbols() end, { desc = "vim.lsp.buf.workspace_symbol()" })
  vim.keymap.set("n", "<leader>cl", function() require("snacks").picker.lsp_config() end, { desc = "Lsp Info" })
  -- stylua: ignore end
else
  vim.keymap.set("n", "gA", function() vim.lsp.buf.references() end, { desc = "vim.lsp.buf.references()" })
  vim.keymap.set("n", "gI", function() vim.lsp.buf.implementation() end, { desc = "vim.lsp.buf.implementation()" })
  vim.keymap.set("n", "gs", function() vim.lsp.buf.document_symbol() end, { desc = "vim.lsp.buf.document_symbol()" })
  vim.keymap.set("n", "gS", function() vim.lsp.buf.workspace_symbol() end, { desc = "vim.lsp.buf.workspace_symbol()" })
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("Lsp_Attach", { clear = true }),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    lsp_attach(client, args.buf)
  end,
})

vim.lsp.handlers["client/registerCapability"] = (function(overridden)
  return function(err, res, ctx)
    local result = overridden(err, res, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if not client then return end
    for bufnr, _ in pairs(client.attached_buffers) do
      lsp_attach(client, bufnr)
    end
    return result
  end
end)(vim.lsp.handlers["client/registerCapability"])

require("snacks").toggle.inlay_hints():map "<leader>uh"
