-- lsp
vim.lsp.enable "marksman"

vim.filetype.add {
  extension = { mdx = "markdown.mdx" },
}
return {
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = {
      ensure_installed = { "markdown", "markdown_inline" },
    },
  },

  -- lint
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = { "markdownlint-cli2" },
      },
    },
  },

  -- format
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        ["markdownlint-cli2"] = {
          condition = function(_, ctx)
            local diag = vim.tbl_filter(function(d) return d.source == "markdownlint" end, vim.diagnostic.get(ctx.buf))
            return #diag > 0
          end,
        },
      },
      formatters_by_ft = {
        markdown = function(bufnr)
          return {
            ViM.format.first(bufnr, "prettierd", "prettier"),
            "markdownlint-cli2",
            "injected",
          }
        end,
        ["markdown.mdx"] = function(bufnr)
          return {
            ViM.format.first(bufnr, "prettierd", "prettier"),
            "markdownlint-cli2",
            "injected",
          }
        end,
      },
    },
  },

  {
    "itspriddle/vim-marked",
    enabled = function() return vim.fn.has "mac" end,
    ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
  },

  {
    "mason-org/mason.nvim",
    optional = true,
    opts = { ensure_installed = { "markdownlint-cli2" } },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      code = {
        sign = true,
        -- width = "block",
        -- right_pad = 1,
      },
      completions = {
        lsp = {
          enabled = true,
        },
        blink = {
          enabled = true,
        },
      },
      heading = {
        sign = true,
        icons = {},
      },
      checkbox = {
        enabled = true,
      },
    },
    ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      Snacks.toggle({
        name = "Render Markdown",
        get = function() return require("render-markdown.state").enabled end,
        set = function(enabled)
          local m = require "render-markdown"
          if enabled then
            m.enable()
          else
            m.disable()
          end
        end,
      }):map "<leader>um"
    end,
  },
}
