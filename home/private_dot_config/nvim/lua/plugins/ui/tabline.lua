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
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          if context.buffer:current() then return "" end
          local ret = (
            diagnostics_dict.error
              and vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.ERROR] .. diagnostics_dict.error .. " "
            or ""
          )
            .. (
              diagnostics_dict.warning
                and vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.WARN] .. diagnostics_dict.warning
              or ""
            )
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
