return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000, -- Make sure to load this before all the other start plugins.
    opts = {
      integrations = {
        blink_cmp = true,
        copilot_vim = true,
        dap = true,
        dap_ui = true,
        dropbar = {
          enabled = true,
          color_mode = true,
        },
        flash = true,
        fzf = true,
        gitsigns = true,
        grug_far = true,
        lsp_trouble = true,
        markdown = true,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
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
        neotest = true,
        noice = true,
        octo = true,
        overseer = true,
        rainbow_delimiters = true,
        render_markdown = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
    config = function(_, opts)
      ---@diagnostic disable-next-line: missing-fields
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  -- {
  --   "akinsho/bufferline.nvim",
  --   optional = true,
  --   opts = { highlights = require("catppuccin.groups.integrations.bufferline").get() },
  -- },
}
