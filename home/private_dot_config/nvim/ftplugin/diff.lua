-- treesitter
require("nvim-treesitter").install "diff"

vim.wo.foldexpr = "v:lua.MiniGit.diff_foldexpr()"
