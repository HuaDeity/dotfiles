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
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {
      modes = {
        symbols = {
          win = { position = "left" },
        },
      },
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
      { "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then vim.notify(err, vim.log.levels.ERROR) end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then vim.notify(err, vim.log.levels.ERROR) end
          end
        end,
        desc = "Next Trouble/Quickfix Item",
      },
    },
    specs = {
      {
        "nvim-lualine/lualine.nvim",
        optional = true,
        opts = {
          extensions = { "trouble" },
        },
      },
      {
        "folke/edgy.nvim",
        optional = true,
        opts = function(_, opts)
          local tpos = "bottom"
          opts[tpos] = opts[tpos] or {}
          table.insert(opts[tpos], "Trouble")

          for _, pos in ipairs { "top", "bottom", "left", "right" } do
            opts[pos] = opts[pos] or {}
            table.insert(opts[pos], {
              ft = "trouble",
              filter = function(_buf, win)
                return vim.w[win].trouble
                  and vim.w[win].trouble.position == pos
                  and vim.w[win].trouble.type == "split"
                  and vim.w[win].trouble.relative == "editor"
                  and not vim.w[win].trouble_preview
              end,
            })
          end
        end,
      },
      {
        "nvim-neotest/neotest",
        optional = true,
        opts = {
          consumers = {
            trouble = function(client)
              client.listeners.results = function(adapter_id, results, partial)
                if partial then return end
                local tree = assert(client:get_position(nil, { adapter = adapter_id }))

                local failed = 0
                for pos_id, result in pairs(results) do
                  if result.status == "failed" and tree:get_key(pos_id) then failed = failed + 1 end
                end
                vim.schedule(function()
                  local trouble = require "trouble"
                  if trouble.is_open() then
                    trouble.refresh()
                    if failed == 0 then trouble.close() end
                  end
                end)
                return {}
              end
            end,
          },
          quickfix = {
            open = function() require("trouble").open { mode = "quickfix", focus = false } end,
          },
        },
      },
      -- {
      --   "nvim-lualine/lualine.nvim",
      --   optional = true,
      --   opts = function(_, opts)
      --     local trouble = require "trouble"
      --     local symbols = trouble.statusline {
      --       mode = "symbols",
      --       groups = {},
      --       title = false,
      --       filter = { range = true },
      --       format = "{kind_icon}{symbol.name:Normal}",
      --       hl_group = "lualine_c_normal",
      --     }
      --     table.insert(opts.winbar.lualine_c, {
      --       symbols and symbols.get,
      --       cond = function() return vim.b.trouble_lualine ~= false and symbols.has() end,
      --     })
      --   end,
      -- },
    },
  },
  {
    "echasnovski/mini.map",
    optional = true,
    options = function(_, opts)
      opts.integrations = opts.integrations or {}
      local map = require "mini.map"
      table.insert(
        opts.integrations,
        map.gen_integration.diagnostic {
          error = "DiagnosticFloatingError",
          warn = "DiagnosticFloatingWarn",
          info = "DiagnosticFloatingInfo",
          hint = "DiagnosticFloatingHint",
        }
      )
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      table.insert(opts.sections.lualine_c, {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = {
          error = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.ERROR],
          warn = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.WARN],
          info = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.INFO],
          hint = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.HINT],
        },
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          if context.buffer:current() then return "" end
          local ret = (
            diagnostics_dict.error
              and vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.ERROR] .. diagnostics_dict.error .. " "
            or ""
          )
            .. (
              diagnostics_dict.warning
                and vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.WARN] .. diagnostics_dict.warning
              or ""
            )
          return vim.trim(ret)
        end,
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    opts = function()
      local neotest_ns = vim.api.nvim_create_namespace "neotest"
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
    end,
  },
}
