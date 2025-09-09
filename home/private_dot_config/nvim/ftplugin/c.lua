vim.pack.add {
  "https://github.com/p00f/clangd_extensions.nvim",
  "https://github.com/Civitasv/cmake-tools.nvim",
}

require("cmake-tools").setup {}

-- keymap
vim.keymap.set("n", "<F5>", "<cmd>CMakeDebug<cr>", { buffer = true })

-- lsp
vim.lsp.enable { "clangd" }

-- treesitter
require("nvim-treesitter").install "cpp"

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
