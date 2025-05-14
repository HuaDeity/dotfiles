local LazyUtil = require "lazy.core.util"

---@class util: UtilCore
---@field config ViMConfig
---@field ui util.ui
---@field root util.root
---@field format util.format
---@field lualine util.lualine
local M = {}

setmetatable(M, {
  __index = function(t, k)
    if LazyUtil[k] then return LazyUtil[k] end
    ---@diagnostic disable-next-line: no-unknown
    t[k] = require("util." .. k)
    return t[k]
  end,
})

function M.is_win() return vim.uv.os_uname().sysname:find "Windows" ~= nil end

---@param name string
function M.get_plugin(name) return require("lazy.core.config").spec.plugins[name] end

---@param name string
function M.opts(name)
  local plugin = M.get_plugin(name)
  if not plugin then return {} end
  local Plugin = require "lazy.core.plugin"
  return Plugin.values(plugin, "opts", false)
end

function M.is_loaded(name)
  local Config = require "lazy.core.config"
  return Config.plugins[name] and Config.plugins[name]._.loaded
end

---@param name string
---@param fn fun(name:string)
function M.on_load(name, fn)
  if M.is_loaded(name) then
    fn(name)
  else
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

---@generic T
---@param list T[]
---@return T[]
function M.dedup(list)
  local ret = {}
  local seen = {}
  for _, v in ipairs(list) do
    if not seen[v] then
      table.insert(ret, v)
      seen[v] = true
    end
  end
  return ret
end

return M
