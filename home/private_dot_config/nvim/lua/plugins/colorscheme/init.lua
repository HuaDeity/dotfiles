return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("catppuccin").setup {
        integrations = {
          blink_cmp = true,
          copilot_vim = true,
          dap = true,
          dap_ui = true,
          flash = true,
          fzf = true,
          gitsigns = true,
          grug_far = true,
          lsp_trouble = true,
          markdown = true,
          mason = true,
          mini = true,
          neotest = true,
          noice = true,
          octo = true,
          rainbow_delimiters = true,
          render_markdown = true,
          treesitter = true,
          treesitter_context = true,
          which_key = true,
        },
      }

      vim.cmd.colorscheme "catppuccin"
    end,
  },
}
