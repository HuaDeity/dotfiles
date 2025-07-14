vim.pack.add { "https://github.com/nvim-lualine/lualine.nvim" }

if vim.fn.argc(-1) > 0 then
  -- set an empty statusline till lualine loads
  vim.o.statusline = " "
else
  -- hide the statusline on the starter page
  vim.o.laststatus = 0
end

require("lualine").setup {
  options = {
    disabled_filetypes = {
      statusline = { "snacks_dashboard" },
    },
    globalstatus = true,
    theme = "catppuccin",
  },
  sections = {
    lualine_a = {
      "mode",
    },
    lualine_b = {
      "branch",
      {
        "diff",
        symbols = { added = " ", modified = " ", removed = " " },
        source = function()
          local summary = vim.b.minidiff_summary
          return summary
            and {
              added = summary.add,
              modified = summary.change,
              removed = summary.delete,
            }
        end,
      },
      -- { require("gitblame").get_current_blame_text, cond = require("gitblame").is_blame_text_available },
      -- stylua: ignore
      {
        ---@diagnostic disable-next-line: undefined-field
        function() return require("noice").api.status.command.get() end,
        ---@diagnostic disable-next-line: undefined-field
        cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
        color = function() return { fg = Snacks.util.color "Statement" } end,
      },
      -- stylua: ignore
      {
        ---@diagnostic disable-next-line: undefined-field
        function() return require("noice").api.status.mode.get() end,
        ---@diagnostic disable-next-line: undefined-field
        cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
        color = function() return { fg = Snacks.util.color "Constant" } end,
      }
,
    },
    lualine_c = {
      -- "aerial",
      {
        function() return "  " .. require("dap").status() end,
        cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
        color = function() return { fg = Snacks.util.color "Debug" } end,
      },
      Snacks.profiler.status(),
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = {
          error = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.ERROR],
          warn = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.WARN],
          info = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.INFO],
          hint = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.HINT],
        },
      },
    },
    lualine_x = {
      "encoding",
      "fileformat",
      "filetype",
      "copilot",
      -- require "mcphub.extensions.lualine",
      -- require "minuet.lualine"
    },
    lualine_y = {
      "progress",
      {
        function() return require("vectorcode.integrations").lualine()[1]() end,
        cond = function()
          if package.loaded["vectorcode"] == nil then
            return false
          else
            return require("vectorcode.integrations").lualine().cond()
          end
        end,
      },
    },
    lualine_z = {
      "location",
    },
  },
  extensions = { "trouble", "overseer" },
}
