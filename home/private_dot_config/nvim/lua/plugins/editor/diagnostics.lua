return {
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {
      modes = {
        lsp = {
          win = { position = "right" },
        },
      },
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
      { "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then vim.notify(err, vim.log.levels.ERROR) end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then vim.notify(err, vim.log.levels.ERROR) end
          end
        end,
        desc = "Next Trouble/Quickfix Item",
      },
    },
  },
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     local trouble = require "trouble"
  --     local symbols = trouble.statusline {
  --       mode = "symbols",
  --       groups = {},
  --       title = false,
  --       filter = { range = true },
  --       format = "{kind_icon}{symbol.name:Normal}",
  --       hl_group = "lualine_c_normal",
  --     }
  --     table.insert(opts.winbar.lualine_c, {
  --       symbols and symbols.get,
  --       cond = function() return vim.b.trouble_lualine ~= false and symbols.has() end,
  --     })
  --   end,
  -- },
}
