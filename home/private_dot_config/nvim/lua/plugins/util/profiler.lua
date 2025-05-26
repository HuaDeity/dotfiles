return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>dps", function() Snacks.profiler.scratch() end, desc = "Profiler Scratch Buffer" },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts) table.insert(opts.sections.lualine_c, Snacks.profiler.status()) end,
  },
}
