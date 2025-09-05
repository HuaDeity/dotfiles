require("neogen").setup {
  snippet_engine = "nvim",
}
-- stylua: ignore
vim.keymap.set("n", "<leader>cn", function() require("neogen").generate() end, {desc = "Generate Annotations (Neogen)"})
