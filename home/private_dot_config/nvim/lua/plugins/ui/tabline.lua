return {
  {
    "akinsho/bufferline.nvim",
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
      highlights = require("catppuccin.groups.integrations.bufferline").get(),
      options = {
        -- stylua: ignore
        close_command = function(n) Snacks.bufdelete(n) end,
        -- stylua: ignore
        right_mouse_command = "vertical sbuffer %d",
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diag)
          local icons = ViM.config.icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "snacks_layout_box",
          },
        },
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
