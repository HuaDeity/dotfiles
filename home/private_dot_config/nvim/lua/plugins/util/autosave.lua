local excluded_filetypes = {
  "gitcommit", -- commits should definitely be saved explicitly
}
local excluded_filenames = {}
local immediate_triggers = { "BufLeave", "FocusLost", "QuitPre", "VimSuspend" } -- vim events that trigger auto-save. See :h events
local deferred_triggers = { "InsertLeave", "TextChanged", "TextChangedI" }

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
    event = vim.tbl_deep_extend("force", immediate_triggers, deferred_triggers),
    opts = {
      trigger_events = { -- See :h events
        immediate_save = immediate_triggers, -- vim events that trigger an immediate save
        defer_save = deferred_triggers, -- vim events that trigger a deferred save (saves after `debounce_delay`)
      },
      -- function that determines whether to save the current buffer or not
      -- return true: if buffer is ok to be saved
      -- return false: if it's not ok to be saved
      condition = save_condition,
      noautocmd = true,
    },
  },
}
