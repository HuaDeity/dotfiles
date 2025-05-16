return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
      "mason-org/mason.nvim",
      {
        "mason-org/mason-lspconfig.nvim",
        opts_extend = { "ensure_installed" },
        opts = { automatic_enable = false },
      },
    },
    config = function()
      local lsp_attach = require "plugins.lsp.attach"
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("vilsp-attach", { clear = true }),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          lsp_attach.setup(client, args.buf)
        end,
      })
      vim.lsp.handlers["client/registerCapability"] = (function(overridden)
        return function(err, res, ctx)
          local result = overridden(err, res, ctx)
          local client = vim.lsp.get_client_by_id(ctx.client_id)
          if not client then return end
          for bufnr, _ in pairs(client.attached_buffers) do
            lsp_attach.setup(client, bufnr)
          end
          return result
        end
      end)(vim.lsp.handlers["client/registerCapability"])

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = function(diagnostic)
            local icons = ViM.config.icons.diagnostics
            for d, icon in pairs(icons) do
              if diagnostic.severity == vim.diagnostic.severity[d:upper()] then return icon end
            end
          end,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = ViM.config.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = ViM.config.icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = ViM.config.icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = ViM.config.icons.diagnostics.Info,
          },
        },
        float = { border = "rounded", source = "if_many" },
      }

      vim.lsp.config("*", {
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
      })
    end,
  },
  {
    "mason-org/mason.nvim",
    cmd = { "Mason" },
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    opts = {},
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require "mason-registry"
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger {
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          }
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then p:install() end
        end
      end)
    end,
  },
}
