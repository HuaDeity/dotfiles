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
