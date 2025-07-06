vim.pack.add {
  "https://github.com/jbyuki/one-small-step-for-vimkind",
}

-- lsp
vim.lsp.enable "lua_ls"

-- lint
require("lint").linters_by_ft.lua = { "selene" }
local linter = vim.g.linter
linter.selene = { root_markers = { "selene.toml" } }
vim.g.linter = linter

-- format
require("conform").formatters_by_ft.lua = { "stylua" }

require("lazydev").setup {
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    { path = "snacks.nvim", words = { "Snacks" } },
  },
}

-- debug
local dap = require "dap"
dap.configurations.lua = {
  {
    type = "nlua",
    request = "attach",
    name = "Attach to running Neovim instance",
  },
}
dap.adapters.nlua = function(callback, config)
  callback { type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 }
end
