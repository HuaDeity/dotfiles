return {
  {
    "folke/snacks.nvim",
    opts = { explorer = {} },
    keys = {
      {
        "<leader>fe",
        function() Snacks.explorer { cwd = ViM.root() } end,
        desc = "Explorer Snacks (root dir)",
      },
      {
        "<leader>fE",
        function() Snacks.explorer() end,
        desc = "Explorer Snacks (cwd)",
      },
      { "<leader>e", "<leader>fe", desc = "Explorer Snacks (root dir)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Explorer Snacks (cwd)", remap = true },
    },
  },
  -- Edgy integration
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      opts.left = opts.left or {}
      table.insert(opts.left, {
        -- ft = "snacks_layout_box",
        ft = "snacks_picker_input",
        title = "Explorer",
        size = { width = 30 },
        pinned = true,
        open = function() Snacks.explorer { cwd = ViM.root() } end,
        filter = function(buf, win) return vim.api.nvim_win_get_config(win).relative == "" end,
      })
    end,
  },
}
