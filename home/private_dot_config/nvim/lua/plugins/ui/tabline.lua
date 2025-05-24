return {
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "echasnovski/mini.icons",
    },
    event = "VeryLazy",
    keys = {
      { "<S-z>p", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<S-z>L", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
      { "<S-z>H", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
      { "<S-z>h", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "<S-z>l", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[B", function() require("bufferline").go_to(1, true) end, desc = "First Buffer" },
      { "]B", function() require("bufferline").go_to(-1, true) end, desc = "Last Buffer" },
    },
    opts = {
      options = {
        -- stylua: ignore
        right_mouse_command = "vertical sbuffer %d",
        always_show_bufferline = false,
        ---@param opts bufferline.IconFetcherOpts
        get_element_icon = function(element) return MiniIcons.get("filetype", element.filetype) end,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function() pcall(nvim_bufferline) end)
        end,
      })
    end,
  },
}
