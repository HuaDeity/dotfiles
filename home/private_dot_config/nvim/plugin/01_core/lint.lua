vim.pack.add({
  "https://github.com/mfussenegger/nvim-lint",
})

local function lint_current_buffer()
  local lint = require "lint"
  -- Use nvim-lint's logic first:
  -- * checks if linters exist for the full filetype first
  -- * otherwise will split filetype by "." and add all those linters
  -- * this differs from conform.nvim which only uses the first filetype that has a formatter
  local names = lint._resolve_linter_by_ft(vim.bo.filetype)

  -- Create a copy of the names table to avoid modifying the original.
  names = vim.list_extend({}, names)

  -- Add fallback linters.
  if #names == 0 then vim.list_extend(names, lint.linters_by_ft["_"] or {}) end

  -- Add global linters.
  vim.list_extend(names, lint.linters_by_ft["*"] or {})

  -- Filter out linters that don't exist or don't match the condition.
  local ctx = { filename = vim.api.nvim_buf_get_name(0) }
  ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
  names = vim.tbl_filter(function(name)
    local apply = true
    local linter = lint.linters[name]
    local custom_linter = vim.g.linter[name]
    if custom_linter then
      if custom_linter.condition and not custom_linter.condition(custom_linter, ctx) then apply = false end
      if custom_linter.root_markers then
        for _, marker in ipairs(custom_linter.root_markers) do
          local found = vim.fs.find(marker, { path = ctx.dirname, upward = true })[1]
          if not found then
            apply = false
            break
          end
        end
      end
    end
    return linter and apply
  end, names)

  -- Run linters.
  if #names > 0 then lint.try_lint(names) end
end

-- Register the lint function to be called on BufWritePost, BufEnter, and InsertLeave
vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("lint", { clear = true }),
  callback = lint_current_buffer,
})
