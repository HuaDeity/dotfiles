return {
  {
    "stevearc/aerial.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
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
    },
    keys = {
      { "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Symbols" },
    },
    specs = {
      -- edgy integration
      {
        "folke/edgy.nvim",
        optional = true,
        opts = function(_, opts)
          opts.left = opts.left or {}
          table.insert(opts.left, {
            title = "Aerial",
            ft = "aerial",
            pinned = true,
            open = "AerialOpen",
          })
        end,
      },
      -- -- lualine integration
      -- {
      --   "nvim-lualine/lualine.nvim",
      --   optional = true,
      --   opts = function(_, opts) table.insert(opts.winbar.lualine_c, "aerial") end,
      -- },
    },
  },
}
