_G.dd = function(...) require("snacks.debug").inspect(...) end
_G.bt = function(...) require("snacks.debug").backtrace() end
_G.p = function(...) require("snacks.debug").profile(...) end
vim.print = _G.dd

-- delay notifications till vim.notify was replaced or after 500ms
local function lazy_notify()
  local notifs = {}
  local function temp(...) table.insert(notifs, vim.F.pack_len(...)) end

  local orig = vim.notify
  vim.notify = temp

  local timer = assert(vim.uv.new_timer())
  local check = assert(vim.uv.new_check())

  local replay = function()
    timer:stop()
    check:stop()
    if vim.notify == temp then
      vim.notify = orig -- put back the original notify if needed
    end
    vim.schedule(function()
      ---@diagnostic disable-next-line: no-unknown
      for _, notif in ipairs(notifs) do
        vim.notify(vim.F.unpack_len(notif))
      end
    end)
  end

  -- wait till vim.notify has been replaced
  check:start(function()
    if vim.notify ~= temp then replay() end
  end)
  -- or if it took more than 500ms, then something went wrong
  timer:start(500, 0, replay)
end

lazy_notify()

-- load options here, before lazy init while sourcing plugin modules
-- this is needed to make sure options will be correctly applied
-- after installing missing plugins
require "config.options"

if vim.g.deprecation_warnings == false then vim.deprecate = function() end end

require "config.lazy"
