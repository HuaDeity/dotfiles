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
            tool_group = {
              -- this will register a tool group called `@vectorcode_toolbox` that contains all 3 tools
              enabled = true,
              -- a list of extra tools that you want to include in `@vectorcode_toolbox`.
              -- if you use @vectorcode_vectorise, it'll be very handy to include
              -- `file_search` here.
              extras = {},
              collapse = false, -- whether the individual tools should be shown in the chat
            },
            tool_opts = {
              ---@type VectorCode.CodeCompanion.LsToolOpts
              ls = {},
              ---@type VectorCode.CodeCompanion.VectoriseToolOpts
              vectorise = {},
              ---@type VectorCode.CodeCompanion.QueryToolOpts
              query = {
                max_num = { chunk = -1, document = -1 },
                default_num = { chunk = 50, document = 10 },
                include_stderr = false,
                use_lsp = false,
                no_duplicate = true,
                chunk_mode = false,
              },
            },
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
