return {
  {
    "akinsho/toggleterm.nvim",
    keys = {
      { "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true } },
    },
    config = function()
      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

      function _lazygit_toggle()
        lazygit:toggle()
      end

      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        map("t", "<esc>", [[<C-\><C-n>]], opts)
        map("t", "jk", [[<C-\><C-n>]], opts)
        map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
        map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
        map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
        map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
      end

      -- if you only want these mappings for toggle term use term://*toggleterm#* instead
      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    end,
  },
}
