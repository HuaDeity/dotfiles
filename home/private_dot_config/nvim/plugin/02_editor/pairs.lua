require("mini.pairs").setup {
  modes = { insert = true, command = true, terminal = false },
}

local pairs = require "mini.pairs"
local open = pairs.open
---@diagnostic disable-next-line: duplicate-set-field
pairs.open = function(pair, neigh_pattern)
  if vim.fn.getcmdline() ~= "" then return open(pair, neigh_pattern) end
  local o, c = pair:sub(1, 1), pair:sub(2, 2)
  local line = vim.api.nvim_get_current_line()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local next = line:sub(cursor[2] + 1, cursor[2] + 1)
  local before = line:sub(1, cursor[2])
  if o == "`" and (vim.bo.filetype == "markdown" or vim.bo.filetype == "codecompanion") and before:match "^%s*``" then
    return "`\n```" .. vim.api.nvim_replace_termcodes("<up>", true, true, true)
  end
  if next ~= "" and next:match [=[[%w%%%'%[%"%.%`%$]]=] then return o end
  local ok, captures = pcall(vim.treesitter.get_captures_at_pos, 0, cursor[1] - 1, math.max(cursor[2] - 1, 0))
  for _, capture in ipairs(ok and captures or {}) do
    if vim.tbl_contains({ "string" }, capture.capture) then return o end
  end
  if next == c and c ~= o then
    local _, count_open = line:gsub(vim.pesc(pair:sub(1, 1)), "")
    local _, count_close = line:gsub(vim.pesc(pair:sub(2, 2)), "")
    if count_close > count_open then return o end
  end
  return open(pair, neigh_pattern)
end

require("snacks")
  .toggle({
    name = "Mini Pairs",
    get = function() return not vim.g.minipairs_disable end,
    set = function(state) vim.g.minipairs_disable = not state end,
  })
  :map "<leader>up"

require("nvim-ts-autotag").setup()
