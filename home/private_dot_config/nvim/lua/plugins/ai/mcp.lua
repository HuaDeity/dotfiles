return {
  {
    "ravitemer/mcphub.nvim",
    cmd = "MCPHub",
    build = "bundled_build.lua",
    opts = {
      auto_approve = true,
      use_bundled_binary = true,
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts) table.insert(opts.sections.lualine_x, require "mcphub.extensions.lualine") end,
  },
  {
    "olimorris/codecompanion.nvim",
    optional = true,
    opts = {
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            show_result_in_chat = true, -- Show mcp tool results in chat
            make_vars = true, -- Convert resources to #variables
            make_slash_commands = true, -- Add prompts as /slash commands
          },
        },
      },
    },
  },
}
