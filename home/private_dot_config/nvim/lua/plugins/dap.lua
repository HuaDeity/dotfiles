return {
  { import = "lazyvim.plugins.extras.dap.core" },
  {
    "catppuccin/nvim",
    opts = {
      integrations = {
        dap = true,
        dap_ui = true,
      },
    },
  },
}
