vim.pack.add { "https://github.com/stevearc/conform.nvim" }

--@param buf? integer
local function format_enabled(buf)
  buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
  local gaf = vim.g.autoformat
  local baf = vim.b[buf].autoformat

  -- If the buffer has a local value, use that
  if baf ~= nil then return baf end

  if vim.tbl_contains(vim.g.format_ignore_filetypes, vim.bo[buf].filetype) then return false end

  local bufname = vim.api.nvim_buf_get_name(buf)
  for _, path in ipairs(vim.g.format_ignore_paths) do
    if bufname:match(path) then return false end
  end

  -- Otherwise use the global value if set, or true by default
  return gaf == nil or gaf
end

---@param enable? boolean
---@param buf? boolean
local function format_enable(enable, buf)
  if enable == nil then enable = true end
  if buf then
    vim.b.autoformat = enable
  else
    vim.g.autoformat = enable
    vim.b.autoformat = nil
  end
end

---@param buf? boolean
local function format_snacks_toggle(buf)
  return Snacks.toggle {
    name = "Auto Format (" .. (buf and "Buffer" or "Global") .. ")",
    get = function()
      if not buf then return vim.g.autoformat == nil or vim.g.autoformat end
      return format_enabled()
    end,
    set = function(state) format_enable(state, buf) end,
  }
end

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

require("conform").setup {
  default_format_opts = {
    lsp_format = "fallback",
  },
  format_on_save = function(bufnr)
    if not format_enabled(bufnr) then return end
    return {
      timeout_ms = 500,
    }
  end,
}

vim.keymap.set("", "<leader>cf", function()
  require("conform").format({ async = true }, function(err)
    if not err then
      local mode = vim.api.nvim_get_mode().mode
      if vim.startswith(string.lower(mode), "v") then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
      end
    end
  end)
end, { desc = "Format" })

format_snacks_toggle():map "<leader>uf"
format_snacks_toggle(true):map "<leader>uF"
