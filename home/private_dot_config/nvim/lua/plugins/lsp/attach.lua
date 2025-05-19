-- Create a module
local M = {}
local inlay_hints_excluded = {}

---@param client table The LSP client
---@param bufnr number The buffer number
function M.setup(client, bufnr)
  local function client_supports_method(method)
    method = method:find "/" and method or "textDocument/" .. method
    return client:supports_method(method, bufnr)
  end

  local map = function(keys, func, desc, mode, args)
    mode = mode or "n"
    local opts = {
      buffer = bufnr,
      desc = "LSP: " .. desc,
    }
    if args and type(args) == "table" then
      for k, v in pairs(args) do
        opts[k] = v
      end
    end
    vim.keymap.set(mode, keys, func, opts)
  end

  if client_supports_method "definition" then
    map("gd", function() Snacks.picker.lsp_definitions() end, "Definition")
  end

  if client_supports_method "declaration" then
    map("gD", function() Snacks.picker.lsp_declarations() end, "Declaration")
  end

  if client_supports_method "typeDefinition" then
    map("gy", function() Snacks.picker.lsp_type_definitions() end, "Type Definition")
  end

  if client_supports_method "implementation" then
    map("gI", function() Snacks.picker.lsp_implementations() end, "Implementation")
  end

  if client_supports_method "rename" then
    -- Rename the variable under your cursor.
    map("cd", vim.lsp.buf.rename, "Rename(Change Definition)")
    map("<leader>cd", function()
      local inc_rename = require "inc_rename"
      return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand "<cword>"
    end, "Rename (inc-rename.nvim)", { expr = true })
  end

  if client_supports_method "references" then
    map("gA", function() Snacks.picker.lsp_references() end, "Goto All References", { nowait = true })
  end

  if client_supports_method "documentSymbol" then
    map("gs", function() Snacks.picker.lsp_symbols { filter = ViM.config.kind_filter } end, "Symbols")
  end

  if client_supports_method "workspace/symbols" then
    map(
      "gS",
      function() Snacks.picker.lsp_workspace_symbols { filter = ViM.config.kind_filter } end,
      "Workspace Symbols"
    )
  end

  if client_supports_method "hover" then map("gh", vim.lsp.buf.hover, "Hover", { "n", "v" }) end

  if client_supports_method "codeAction" then map("g.", vim.lsp.buf.code_action, "Code Action", { "n", "v" }) end

  -- Setup document highlighting if supported
  if client_supports_method "documentHighlight" then
    local highlight_augroup = vim.api.nvim_create_augroup("vilsp-highlight-" .. bufnr, { clear = false })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      group = highlight_augroup,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = bufnr,
      group = highlight_augroup,
      callback = vim.lsp.buf.clear_references,
    })

    vim.api.nvim_create_autocmd("LspDetach", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds { group = highlight_augroup, buffer = bufnr }
      end,
    })
  end

  -- inlay hints
  if client_supports_method "inlayHint" then
    if
      vim.api.nvim_buf_is_valid(bufnr)
      and vim.bo[bufnr].buftype == ""
      and not vim.tbl_contains(inlay_hints_excluded, vim.bo[bufnr].filetype)
    then
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
    end
  end

  -- code lens
  if client_supports_method "codeLens" then
    vim.lsp.codelens.refresh()
    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      callback = function() vim.lsp.codelens.refresh { bufnr = bufnr } end,
    })
  end
end

return M
