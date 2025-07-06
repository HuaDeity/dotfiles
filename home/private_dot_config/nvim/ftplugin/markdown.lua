vim.pack.add { "https://github.com/itspriddle/vim-marked" }

-- lsp
vim.lsp.enable { "ltex_plus", "marksman", "markdown_oxide" }

-- lint
require("lint").linters_by_ft.markdown = { "markdownlint-cli2" }

-- format
---@param bufnr integer
---@param ... string
---@return string
local function first(bufnr, ...)
  local conform = require "conform"
  for i = 1, select("#", ...) do
    local formatter = select(i, ...)
    if conform.get_formatter_info(formatter, bufnr).available then return formatter end
  end
  return select(1, ...)
end
require("conform").formatters_by_ft.markdown = function(bufnr)
  return {
    first(bufnr, "prettierd", "prettier"),
    "markdownlint-cli2",
    "injected",
  }
end

require("conform").formatters["markdownlint-cli2"] = {
  condition = function(_, ctx)
    local diag = vim.tbl_filter(function(d) return d.source == "markdownlint" end, vim.diagnostic.get(ctx.buf))
    return #diag > 0
  end,
}

vim.wo.wrap = true
vim.wo.spell = true
