return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "prettier",
        "black",
        -- "google_java_format",
      })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          nls.builtins.code_actions.gitsigns,
          nls.builtins.formatting.prettierd.with({
            extra_filetypes = { "toml" },
            extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
          }),
          nls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
          nls.builtins.formatting.stylua,
          -- nls.builtins.formatting.google_java_format,
          nls.builtins.diagnostics.flake8,
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      -- keys[#keys + 1] = { "K", "<cmd>echo 'hello'<cr>" }
      -- disable a keymap
      -- keys[#keys + 1] = { "K", false }
      -- add a keymap
      keys[#keys + 1] = { "<leader>ds", require("telescope.builtin").lsp_document_symbols }
      keys[#keys + 1] = { "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols }
      keys[#keys + 1] = { "<leader>wa", vim.lsp.buf.add_workspace_folder }
      keys[#keys + 1] = { "<leader>wr", vim.lsp.buf.remove_workspace_folder }
    end,
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
        sumneko_lua = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },
      },
      setup = {
        clangd = function(_, opts)
          opts.capabilities.offsetEncoding = { "utf-16" }
        end,
      },
    },
  },
}
