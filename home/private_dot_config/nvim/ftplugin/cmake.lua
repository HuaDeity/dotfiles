vim.pack.add { "https://github.com/Civitasv/cmake-tools.nvim" }

-- lsp
vim.lsp.enable { "neocmake" }

-- treesitter
require("nvim-treesitter").install "cmake"
