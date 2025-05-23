-- Diagnostic Config
-- See :help vim.diagnostic.Opts
local diagnostic_icons = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " ",
}
vim.diagnostic.config {
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = function(diagnostic)
      for d, icon in pairs(diagnostic_icons) do
        if diagnostic.severity == vim.diagnostic.severity[d:upper()] then return icon end
        return " "
      end
    end,
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = diagnostic_icons.Error,
      [vim.diagnostic.severity.WARN] = diagnostic_icons.Warn,
      [vim.diagnostic.severity.HINT] = diagnostic_icons.Hint,
      [vim.diagnostic.severity.INFO] = diagnostic_icons.Info,
    },
  },
  float = { source = "if_many" },
}

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
      -- delete default keymaps
      vim.keymap.del("n", "grn") -- Rename
      vim.keymap.del({ "n", "x" }, "gra") -- Code Action
      vim.keymap.del("n", "grr") -- References
      vim.keymap.del("n", "gri") -- Implementation
      vim.keymap.del("n", "gO") -- Document Symbol
      vim.keymap.del({ "i", "s" }, "<C-s>") -- Signature Help

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
  },
}
