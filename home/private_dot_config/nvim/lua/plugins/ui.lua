return {
  -- Enable rainbow parenthesis
  { "HiPhish/rainbow-delimiters.nvim" },
  {
    "catppuccin/nvim",
    opts = {
      integrations = {
        rainbow_delimiters = true,
      },
    },
  },
}
