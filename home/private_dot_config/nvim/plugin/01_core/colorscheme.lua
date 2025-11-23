vim.pack.add({
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
})

require("catppuccin").setup {
  integrations = {
    aerial = true,
    blink_cmp = true,
    dap = true,
    diffview = true,
    dropbar = {
      enabled = true,
      color_mode = true,
    },
    flash = true,
    grug_far = true,
    illuminate = {
      enabled = true,
      lsp = true,
    },
    lsp_style = {
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
        ok = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
        ok = { "underline" },
      },
      inlay_hints = {
        background = true,
      },
    },
    lsp_trouble = true,
    mini = true,
    neogit = true,
    neotest = true,
    noice = true,
    octo = true,
    overseer = true,
    rainbow_delimiters = true,
    render_markdown = true,
    treesitter_context = true,
    which_key = true,
  },
}

vim.cmd.colorscheme "catppuccin"

if vim.g.vim_picker == "snacks" then
  vim.keymap.set("n", "<leader>uC", function() require("snacks").picker.colorschemes() end, { desc = "Colorschemes" })
end
require("snacks").toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map "<leader>ub"
