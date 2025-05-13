return {
  {
    "Davidyz/VectorCode",
    cmd = "VectorCode",
    build = "uv tool upgrade vectorcode", -- optional but recommended. This keeps your CLI up-to-date.
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_y, 2, {
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
