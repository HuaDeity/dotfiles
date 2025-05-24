return {
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "folke/snacks.nvim",
    opts = {
      bigfile = { enabled = true },
      image = { enabled = true },
      quickfile = { enabled = true },
    },
    -- stylua: ignore
    keys = {
      { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
      { "<leader>dps", function() Snacks.profiler.scratch() end, desc = "Profiler Scratch Buffer" },
      { "<S-z>Z", function() Snacks.bufdelete() end, desc = "Delete Buffer"},
      { "<S-z>Q", function() Snacks.bufdelete { force = true } end, desc = "Delete Buffer(Force)" },
      { "<S-z>A", function() Snacks.bufdelete.other() end, desc = "Delete Other Buffers" },
    },
    specs = {
      {
        "akinsho/bufferline.nvim",
        optional = true,
        opts = {
          options = {
            close_command = function(n) Snacks.bufdelete(n) end,
          },
        },
      },
      {
        "nvim-lualine/lualine.nvim",
        optional = true,
        opts = function(_, opts) table.insert(opts.sections.lualine_c, Snacks.profiler.status()) end,
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
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
    optional = true,
    opts = {
      extensions = { "lazy" },
    },
  },
}
