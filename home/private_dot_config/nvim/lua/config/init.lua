_G.ViM = require "util"

---@class ViMConfig: ViMOptions
local M = {}

ViM.config = M

---@class ViMOptions
local options = {}

---@param name "autocmds" | "keymaps"
function M.load(name)
  if require("lazy.core.cache").find("config." .. name)[1] then
    ViM.try(function() require("config." .. name) end, { msg = "Failed loading " .. "config." .. name })
  end
end

local lazy_autocmds = vim.fn.argc(-1) == 0
if not lazy_autocmds then M.load "autocmds" end
local group = vim.api.nvim_create_augroup("ViM", { clear = true })
vim.api.nvim_create_autocmd("User", {
  group = group,
  pattern = "VeryLazy",
  callback = function()
    if lazy_autocmds then M.load "autocmds" end
    M.load "keymaps"

    vim.api.nvim_create_user_command("LazyHealth", function()
      vim.cmd [[Lazy! load all]]
      vim.cmd [[checkhealth]]
    end, { desc = "Load all plugins and run :checkhealth" })

    local health = require "lazy.health"
    vim.list_extend(health.valid, {
      "recommended",
      "desc",
      "vscode",
    })

    io.write "\x1b[>1s"
  end,
})

setmetatable(M, {
  __index = function(_, key)
    ---@cast options ViMConfig
    return options[key]
  end,
})

return M
