-- lsp
vim.lsp.enable "bashls"

---@type string
local xdg_config = vim.env.XDG_CONFIG_HOME or vim.env.HOME .. "/.config"

---@param path string
local function have(path) return vim.uv.fs_stat(xdg_config .. "/" .. path) ~= nil end

local add_installed = { "bash", "printf", "query", "regex" }

if have "hypr" then add_installed = vim.list_extend(add_installed, { "hyprlang" }) end

if have "fish" then add_installed = vim.list_extend(add_installed, { "fish" }) end

if have "rofi" or have "wofi" then add_installed = vim.list_extend(add_installed, { "rasi" }) end

vim.filetype.add {
  extension = { rasi = "rasi", rofi = "rasi", wofi = "rasi" },
  filename = {
    ["vifmrc"] = "vim",
  },
  pattern = {
    [".*/waybar/config"] = "jsonc",
    [".*/mako/config"] = "dosini",
    [".*/kitty/.+%.conf"] = "kitty",
    [".*/hypr/.+%.conf"] = "hyprlang",
    ["%.env%.[%w_.-]+"] = "sh",
  },
}
vim.treesitter.language.register("bash", "kitty")

return {
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = {
      ensure_installed = add_installed,
    },
  },
  -- {
  --   "williamboman/mason.nvim",
  --   opts = { ensure_installed = { "shellcheck" } },
  -- },
}
