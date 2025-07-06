vim.pack.add { "https://github.com/keaising/im-select.nvim" }

if not vim.env.SSH_TTY then require("im_select").setup() end
