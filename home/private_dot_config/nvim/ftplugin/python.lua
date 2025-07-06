vim.pack.add {
  "https://github.com/mfussenegger/nvim-dap-python",
  "https://github.com/nvim-neotest/neotest-python",
}

-- lsp
vim.lsp.enable { "basedpyright", "ty" }
-- vim.lsp.enable { "pyrefly", "ty" }

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then return end
    if client.name == "ruff" then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = "LSP: Disable hover capability from Ruff",
})

-- treesitter
require("nvim-treesitter").install { "python", "requirements" }

-- lint
require("lint").linters_by_ft.python = { "ruff" }

-- format
require("conform").formatters_by_ft.python = { "ruff_fix", "ruff_format", "ruff_organize_imports" }

-- debug
require("dap-python").setup "uv"
-- stylua: ignore start
vim.keymap.set("n", "<leader>dPt", function() require('dap-python').test_method() end, { desc = "Debug Method", buffer = true })
vim.keymap.set("n", "<leader>dPc", function() require('dap-python').test_class() end, { desc = "Debug Class", buffer = true })
-- stylua: ignore end

-- test
local adapter = require "neotest-python"
local adapters = require("neotest.config").adapters
table.insert(adapters, adapter)
