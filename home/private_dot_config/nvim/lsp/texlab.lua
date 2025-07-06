return {
  on_attach = function()
    vim.keymap.set("n", "<leader>K", "<plug>(vimtex-doc-package)", { desc = "Vimtex Docs", silent = true })
  end,
}
