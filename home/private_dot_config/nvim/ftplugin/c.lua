vim.pack.add { "https://github.com/p00f/clangd_extensions.nvim" }

-- lsp
vim.lsp.enable { "clangd" }

-- treesitter
require("nvim-treesitter").install "cpp"

-- format
require("conform").formatters_by_ft.c = { "clang-format" }
require("conform").formatters_by_ft.cpp = { "clang-format" }

-- dap
local dap = require "dap"
dap.adapters.codelldb = {
  type = "executable",
  command = "codelldb",
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

dap.configurations.c = dap.configurations.cpp
