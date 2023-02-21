return {
  {
    "catppuccin/nvim",
    dependencies = "f-person/auto-dark-mode.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        background = { -- :h background
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false,
        term_colors = false,
        integration = {
          dashboard = true,
          cmp = true,
          treesitter = true,
          mini = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = "italic",
              hints = "italic",
              warnings = "italic",
              information = "italic",
            },
            underlines = {
              errors = "underline",
              hints = "underline",
              warnings = "underline",
              information = "underline",
            },
          },
          telescope = true,
          mason = true,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = true,
          },
          gitsigns = true,
          treesitter_context = true,
          -- neotree = true,
          nvimtree = true,
          leap = true,
          which_key = true,
          illuminate = true,
          lsp_trouble = true,
          notify = true,
          noice = true,
          navic = {
            enabled = true,
            custom_bg = "NONE",
          },
          markdown = true,
          neogit = true,
          symbols_outline = true,
          dap = {
            enabled = true,
            enable_ui = true, -- enable nvim-dap-ui
          },
          ts_rainbow2 = true,
        },
      })
    end,
  },
  {
    "f-person/auto-dark-mode.nvim",
    lazy = false,
    priority = 1001,
    config = function()
      require("auto-dark-mode").setup({
        update_interval = 100,
        set_dark_mode = function()
          vim.o.background = "dark"
        end,
        set_light_mode = function()
          vim.o.background = "light"
        end,
      })
      require("auto-dark-mode").init()
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
      -- colorscheme = "tokyonight",
    },
  },
}
