local excluded_filetypes = {
  "gitcommit", -- commits should definitely be saved explicitly
}
local excluded_filenames = {}

---@param buf string|integer
---@return boolean
local function save_condition(buf)
  if
    vim.list_contains(excluded_filetypes, vim.fn.getbufvar(buf, "&filetype"))
    or vim.list_contains(excluded_filenames, vim.fn.expand "%:t")
    -- or vim.fn.getbufvar(buf, "&buftype") ~= ""
  then
    return false
  end
  return true
end

return {
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle",
    event = { "InsertLeave", "TextChanged" },
    opts = {
      -- function that determines whether to save the current buffer or not
      -- return true: if buffer is ok to be saved
      -- return false: if it's not ok to be saved
      condition = save_condition,
      noautocmd = true,
    },
  },
}
