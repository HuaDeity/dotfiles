vim.pack.add {
  "https://github.com/fang2hou/go-impl.nvim",
  "https://github.com/leoluz/nvim-dap-go",
  "https://github.com/fredrikaverpil/neotest-golang",
}

-- lsp
vim.lsp.enable { "gopls" }

-- treesitter
require("nvim-treesitter").install { "go" }

-- lint
require("lint").linters_by_ft.go = { "golangcilint" }

-- debug
require("dap-go").setup()

-- test
local adapter = require "neotest-golang"
local adapters = require("neotest.config").adapters
table.insert(adapters, adapter)

vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Go Imports and Format",
  pattern = "*.go",
  group = vim.api.nvim_create_augroup("GoFormatConfig", { clear = true }),
  callback = function(ev)
    local conform_opts = { bufnr = ev.buf, lsp_format = "fallback", timeout_ms = 2000 }
    local client = vim.lsp.get_clients({ name = "gopls", bufnr = ev.buf })[1]

    local enc = (client or {}).offset_encoding or "utf-16"
    local params = vim.lsp.util.make_range_params(0, enc)
    params.context = { only = { "source.organizeImports" } }
    -- params.context = { only = { "refactor.rewrite.addTags" } }

    if not client then
      require("conform").format(conform_opts)
      return
    end

    local request_result = client:request_sync("textDocument/codeAction", params)

    if request_result and request_result.err then
      vim.notify(request_result.err.message, vim.log.levels.ERROR)
      return
    end

    if request_result and request_result.result then
      for _, r in pairs(request_result.result or {}) do
        if r.edit then vim.lsp.util.apply_workspace_edit(r.edit, enc) end
      end
    end

    require("conform").format(conform_opts)
  end,
})
