return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<S-z>Z", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<S-z>Q", function() Snacks.bufdelete { force = true } end, desc = "Delete Buffer(Force)" },
      { "<S-z>A", function() Snacks.bufdelete.other() end, desc = "Delete Other Buffers" },
    },
  },
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = {
      options = {
        close_command = function(n) Snacks.bufdelete(n) end,
      },
    },
  },
}
