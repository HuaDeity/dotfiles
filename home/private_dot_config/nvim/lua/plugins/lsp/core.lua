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
      -- custom keymaps
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
    specs = {
      {
        "nvim-lualine/lualine.nvim",
        optional = true,
        opts = {
          extensions = { "mason" },
        },
      },
    },
  },
}
