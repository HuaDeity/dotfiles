vim.pack.add({
  "https://github.com/okuuva/auto-save.nvim",
})

---@param buf string|integer
---@return boolean
local function save_condition(buf)
  if
    vim.list_contains(vim.g.autosave_excluded_filetypes, vim.fn.getbufvar(buf, "&filetype"))
    or vim.list_contains(vim.g.autosave_excluded_filenames, vim.fn.expand "%:t")
    -- or vim.fn.getbufvar(buf, "&buftype") ~= ""
  then
    return false
  end
  return true
end

require("auto-save").setup {
  condition = save_condition,
  noautocmd = true,
}
