return {
  {
    "Davidyz/VectorCode",
    cmd = "VectorCode",
    build = "uv tool upgrade vectorcode", -- optional but recommended. This keeps your CLI up-to-date.
  },
  {
    "olimorris/codecompanion.nvim",
    optional = true,
    opts = {
      extensions = {
        vectorcode = {
          opts = {
            add_tool = true,
            add_slash_commands = true,
            tool_opts = {},
          },
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      table.insert(opts.sections.lualine_y, {
        function() return require("vectorcode.integrations").lualine(opts)[1]() end,
        cond = function()
          if package.loaded["vectorcode"] == nil then
            return false
          else
            return require("vectorcode.integrations").lualine(opts).cond()
          end
        end,
      })
    end,
  },
}
