return {
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {},
      picker = {
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
          },
        },
      },
    },
    keys = {
      {
        "<leader>fe",
        function() Snacks.explorer() end,
        desc = "Explorer Snacks",
      },
      { "<leader>e", "<leader>fe", desc = "Explorer Snacks", remap = true },
    },
  },
  -- -- Edgy integration
  -- {
  --   "folke/edgy.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     opts.left = opts.left or {}
  --     table.insert(opts.left, {
  --       -- ft = "snacks_layout_box",
  --       ft = "snacks_picker_input",
  --       title = "Explorer",
  --       size = { width = 30 },
  --       pinned = true,
  --       open = function() Snacks.explorer()  end,
  --       filter = function(buf, win) return vim.api.nvim_win_get_config(win).relative == "" end,
  --     })
  --   end,
  -- },
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts or {}, {
        options = {
          offsets = {
            {
              filetype = "snacks_layout_box",
            },
          },
        },
      })
    end,
  },
  {
    "dstein64/nvim-scrollview",
    optional = true,
    opts = {
      excluded_filetypes = { "snacks_layout_box" },
    },
  },
}
