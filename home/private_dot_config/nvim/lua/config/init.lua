_G.ViM = require "util"

---@class ViMConfig: ViMOptions
local M = {}

ViM.config = M

---@class ViMOptions
local options = {
  -- icons used by other plugins
  -- stylua: ignore
  icons = {
    misc = {
      dots = "󰇘",
    },
    ft = {
      octo = "",
    },
    dap = {
      Stopped             = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
      Breakpoint          = " ",
      BreakpointCondition = " ",
      BreakpointRejected  = { " ", "DiagnosticError" },
      LogPoint            = ".>",
    },
    diagnostics = {
      Error = " ",
      Warn  = " ",
      Hint  = " ",
      Info  = " ",
    },
    git = {
      added    = " ",
      modified = " ",
      removed  = " ",
    },
    kinds = {
      Array         = " ",
      Boolean       = "󰨙 ",
      Class         = " ",
      Codeium       = "󰘦 ",
      Color         = " ",
      Control       = " ",
      Collapsed     = " ",
      Constant      = "󰏿 ",
      Constructor   = " ",
      Copilot       = " ",
      Enum          = " ",
      EnumMember    = " ",
      Event         = " ",
      Field         = " ",
      File          = " ",
      Folder        = " ",
      Function      = "󰊕 ",
      Interface     = " ",
      Key           = " ",
      Keyword       = " ",
      Method        = "󰊕 ",
      Module        = " ",
      Namespace     = "󰦮 ",
      Null          = " ",
      Number        = "󰎠 ",
      Object        = " ",
      Operator      = " ",
      Package       = " ",
      Property      = " ",
      Reference     = " ",
      Snippet       = "󱄽 ",
      String        = " ",
      Struct        = "󰆼 ",
      Supermaven    = " ",
      TabNine       = "󰏚 ",
      Text          = " ",
      TypeParameter = " ",
      Unit          = " ",
      Value         = " ",
      Variable      = "󰀫 ",
      claude = "󰋦",
      openai = "󱢆",
      codestral = "󱎥",
      gemini = "",
      Groq = "",
      Openrouter = "󱂇",
      Ollama = "󰳆",
      ["Llama.cpp"] = "󰳆",
      Deepseek = "",
    },
  },
  ---@type table<string, string[]|boolean>?
  kind_filter = {
    default = {
      "Class",
      "Constructor",
      "Enum",
      "Field",
      "Function",
      "Interface",
      "Method",
      "Module",
      "Namespace",
      "Package",
      "Property",
      "Struct",
      "Trait",
    },
    markdown = false,
    help = false,
    -- you can specify a different filter for each filetype
    lua = {
      "Class",
      "Constructor",
      "Enum",
      "Field",
      "Function",
      "Interface",
      "Method",
      "Module",
      "Namespace",
      -- "Package", -- remove package since luals uses it for control flow structures
      "Property",
      "Struct",
      "Trait",
    },
  },
}

---@param name "autocmds" | "options" | "keymaps" | "lazy"
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
    if lazy_clipboard ~= nil then vim.opt.clipboard = lazy_clipboard end

    ViM.root.setup()

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
  end,
})

setmetatable(M, {
  __index = function(_, key)
    ---@cast options ViMConfig
    return options[key]
  end,
})

return M
