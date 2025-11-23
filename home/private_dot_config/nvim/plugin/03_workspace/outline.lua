vim.pack.add({
  "https://github.com/stevearc/aerial.nvim",
})

require("aerial").setup {
  attach_mode = "global",
  backend = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
  default_direction = "prefer_left",
  filter_kind = false,
    -- stylua: ignore
    -- guides = {
    --   mid_item   = "├╴",
    --   last_item  = "└╴",
    --   nested_top = "│ ",
    --   whitespace = "  ",
    -- },
    layout = {
      resize_to_content = false,
      win_opts = {
        -- winfixbuf = true,
        -- winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
        -- signcolumn = "yes",
        -- statuscolumn = " ",
      },
    },
  show_guides = true,
}
vim.keymap.set("n", "<leader>cs", "<cmd>AerialToggle<cr>", { desc = "Symbols" })
if vim.g.vim_picker == "snacks" then
  vim.keymap.set("n", "gs", function() require("aerial").snacks_picker() end, { desc = "Symbols" })
end
