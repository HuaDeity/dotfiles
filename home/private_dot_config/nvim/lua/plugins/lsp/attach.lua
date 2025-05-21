local M = {}
local inlay_hints_excluded = {}

---@type LazyKeysLspSpec[]|nil
M._keys = nil

---@alias LazyKeysLspSpec LazyKeysSpec|{has?:string|string[], cond?:fun():boolean}
---@alias LazyKeysLsp LazyKeys|{has?:string|string[], cond?:fun():boolean}

---@return LazyKeysLspSpec[]
function M.get()
  if M._keys then return M._keys end
    -- stylua: ignore
    M._keys =  {
      { "gd", function () vim.lsp.buf.definition() end, desc = "Goto Definition", has = "definition" },
      { "gD", function () vim.lsp.buf.declaration() end, desc = "Goto Declaration", has = "declaration" },
      { "gy", function () vim.lsp.buf.type_definition() end, desc = "Goto T[y]pe Definition", has = "typeDefinition" },
      { "gh", function () vim.lsp.buf.hover() end, desc = "Hover", has = "hover"},
      { "grn", function() vim.lsp.buf.rename() end, desc = "Rename", has = "rename" },
      { "gra", function () vim.lsp.buf.code_action() end, desc = "Code Action", mode = { "n", "x" }, has = "codeAction" },
      { "grr", function () vim.lsp.buf.references() end, desc = "References", nowait = true, has = "references" },
      { "gri", function () vim.lsp.buf.implementation() end, desc = "Goto Implementation", has = "implementation" },
      { "gO", function () vim.lsp.buf.document_symbol() end, desc = "LSP Symbols", has = "documentSymbol" },
      { "gS", function () vim.lsp.buf.workspace_symbol() end, desc = "LSP Workspace Symbols", has = "workspace/symbol" },
      { "<C-s>", function () vim.lsp.buf.signature_help() end, mode = { "i", "s" }, desc = "Signature Help", has = "signatureHelp" },
      -- { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File", mode ={"n"}, has = { "workspace/didRenameFiles", "workspace/willRenameFiles" } },
      -- { "<leader>cA", LazyVim.lsp.action.source, desc = "Source Action", has = "codeAction" },
      -- { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
      -- { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
      -- { "]]", function() Snacks.words.jump(vim.v.count1) end, has = "documentHighlight",
      --   desc = "Next Reference", cond = function() return Snacks.words.is_enabled() end },
      -- { "[[", function() Snacks.words.jump(-vim.v.count1) end, has = "documentHighlight",
      --   desc = "Prev Reference", cond = function() return Snacks.words.is_enabled() end },
      -- { "<a-n>", function() Snacks.words.jump(vim.v.count1, true) end, has = "documentHighlight",
      --   desc = "Next Reference", cond = function() return Snacks.words.is_enabled() end },
      -- { "<a-p>", function() Snacks.words.jump(-vim.v.count1, true) end, has = "documentHighlight",
      --   desc = "Prev Reference", cond = function() return Snacks.words.is_enabled() end },
    }
  return M._keys
end

---@param client table The LSP client
---@param bufnr number The buffer number
---@param method string|string[]
function M.has(client, bufnr, method)
  if type(method) == "table" then
    for _, m in ipairs(method) do
      if M.has(client, bufnr, m) then return true end
    end
    return false
  end
  method = method:find "/" and method or "textDocument/" .. method
  return client:supports_method(method, bufnr)
end

---@param client table The LSP client
---@param bufnr number The buffer number
function M.setup(client, bufnr)
  local Keys = require "lazy.core.handler.keys"
  local spec = vim.tbl_extend("force", {}, M.get())
  local keymaps = Keys.resolve(spec)

  for _, keys in pairs(keymaps) do
    local has = not keys.has or M.has(client, bufnr, keys.has)
    local cond = not (keys.cond == false or ((type(keys.cond) == "function") and not keys.cond()))

    if has and cond then
      local opts = Keys.opts(keys)
      opts.cond = nil
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = bufnr
      vim.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
    end
  end

  -- Setup document highlighting if supported
  if M.has(client, bufnr, "documentHighlight") then
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
  if M.has(client, bufnr, "inlayHint") then
    if
      vim.api.nvim_buf_is_valid(bufnr)
      and vim.bo[bufnr].buftype == ""
      and not vim.tbl_contains(inlay_hints_excluded, vim.bo[bufnr].filetype)
    then
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
    end
  end

  -- code lens
  if M.has(client, bufnr, "codeLens") then
    vim.lsp.codelens.refresh()
    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      callback = function() vim.lsp.codelens.refresh { bufnr = bufnr } end,
    })
  end
end

return M
