return {
  {
    "catppuccin/nvim",
    opts = {
      integrations = {
        dap = true,
        dap_ui = true,
        octo = true,
        rainbow_delimiters = true,
        render_markdown = true,
      },
    },
  },
  {
    "f-person/auto-dark-mode.nvim",
    opts = {},
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
