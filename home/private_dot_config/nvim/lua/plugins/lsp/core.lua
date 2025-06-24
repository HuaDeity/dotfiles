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

      local snack_opts = ViM.opts "snacks.nvim"
      local mappings = {
        -- zed specific
        { "cd", function() vim.lsp.buf.rename() end, desc = "vim.lsp.buf.rename()" },
        { "g.", function() vim.lsp.buf.code_action() end, desc = "vim.lsp.buf.code_action()", mode = { "n", "x" } },
        { "<C-x><C-l>", function() vim.lsp.buf.code_action() end, desc = "vim.lsp.buf.code_action()", mode = { "i" } },
      }
      if vim.tbl_get(snack_opts, "picker", "enabled") ~= false then
        vim.list_extend(mappings, {
          { "grr", function() Snacks.picker.lsp_references() end, desc = "vim.lsp.buf.references()" },
          { "gri", function() Snacks.picker.lsp_implementations() end, desc = "vim.lsp.buf.implementation()" },
          { "gO", function() Snacks.picker.lsp_symbols() end, desc = "vim.lsp.buf.document_symbol()" },

          -- zed specific
          { "gA", function() Snacks.picker.lsp_references() end, desc = "vim.lsp.buf.references()" },

          { "gI", function() Snacks.picker.lsp_implementations() end, desc = "vim.lsp.buf.implementation()" },
          { "gs", function() Snacks.picker.lsp_symbols() end, desc = "vim.lsp.buf.document_symbol()" },
          { "gS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "vim.lsp.buf.workspace_symbol()" },

          { "<leader>cl", function() Snacks.picker.lsp_config() end, desc = "Lsp Info" },
        })
      else
        vim.list_extend(mappings, {
          -- zed specific
          { "gA", function() vim.lsp.buf.references() end, desc = "vim.lsp.buf.references()" },

          { "gI", function() vim.lsp.buf.implementation() end, desc = "vim.lsp.buf.implementation()" },
          { "gs", function() vim.lsp.buf.document_symbol() end, desc = "vim.lsp.buf.document_symbol()" },
          { "gS", function() vim.lsp.buf.workspace_symbol() end, desc = "vim.lsp.buf.workspace_symbol()" },
        })
      end
      mappings = vim.tbl_filter(function(m) return m[1] and #m[1] > 0 end, mappings)

      for _, mapping in ipairs(mappings) do
        vim.keymap.set(mapping.mode or "n", mapping[1], mapping[2], { desc = mapping.desc })
      end
    end,
  },
  {
    "mason-org/mason.nvim",
    cmd = { "Mason" },
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = {} },
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
