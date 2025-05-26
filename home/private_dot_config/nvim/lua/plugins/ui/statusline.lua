return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts_extend = { "options.disabled_filetypes.statusline", "extensions" },
    opts = {
      options = {
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          "mode",
        },
        lualine_c = {},
        lualine_x = {
          "encoding",
          "fileformat",
          "filetype",
        },
        lualine_y = {
          "progress",
        },
        lualine_z = {
          "location",
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.insert(
        opts.sections.lualine_c,
        -- stylua: ignore
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = function() return { fg = Snacks.util.color "Special" } end,
        }
      )
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      extensions = { "lazy" },
    },
  },
}
