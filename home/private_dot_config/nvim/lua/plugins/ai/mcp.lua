return {
  {
    "ravitemer/mcphub.nvim",
    cmd = "MCPHub",
    build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
    -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
    -- build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
    opts = {
      auto_approve = true,
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts) table.insert(opts.sections.lualine_x, 2, require "mcphub.extensions.lualine") end,
  },
}
