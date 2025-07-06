vim.pack.add { "https://github.com/lawrence-laz/neotest-zig" }
-- lsp
vim.lsp.enable "zls"

-- treesitter
require("nvim-treesitter").install "zig"

-- test
local adapter = require "neotest-zig"
local adapters = require("neotest.config").adapters
table.insert(adapters, adapter)
