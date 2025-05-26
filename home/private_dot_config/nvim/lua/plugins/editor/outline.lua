return {
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {
      modes = {
        symbols = {
          win = { position = "left" },
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
    specs = {
      {
        "nvim-lualine/lualine.nvim",
        optional = true,
        opts = {
          extensions = { "trouble" },
        },
      },
      {
        "folke/edgy.nvim",
        optional = true,
        opts = function(_, opts)
          local tpos = "bottom"
          opts[tpos] = opts[tpos] or {}
          table.insert(opts[tpos], "Trouble")

          for _, pos in ipairs { "top", "bottom", "left", "right" } do
            opts[pos] = opts[pos] or {}
            table.insert(opts[pos], {
              ft = "trouble",
              filter = function(_buf, win)
                return vim.w[win].trouble
                  and vim.w[win].trouble.position == pos
                  and vim.w[win].trouble.type == "split"
                  and vim.w[win].trouble.relative == "editor"
                  and not vim.w[win].trouble_preview
              end,
            })
          end
        end,
      },
      {
        "nvim-neotest/neotest",
        optional = true,
        opts = {
          consumers = {
            trouble = function(client)
              client.listeners.results = function(adapter_id, results, partial)
                if partial then return end
                local tree = assert(client:get_position(nil, { adapter = adapter_id }))

                local failed = 0
                for pos_id, result in pairs(results) do
                  if result.status == "failed" and tree:get_key(pos_id) then failed = failed + 1 end
                end
                vim.schedule(function()
                  local trouble = require "trouble"
                  if trouble.is_open() then
                    trouble.refresh()
                    if failed == 0 then trouble.close() end
                  end
                end)
                return {}
              end
            end,
          },
          quickfix = {
            open = function() require("trouble").open { mode = "quickfix", focus = false } end,
          },
        },
      },
      {
        "folke/snacks.nvim",
        opts = {
          picker = {
            actions = {
              trouble_open = function(...) return require("trouble.sources.snacks").actions.trouble_open.action(...) end,
            },
            win = {
              input = {
                keys = {
                  ["<a-t>"] = {
                    "trouble_open",
                    mode = { "n", "i" },
                  },
                },
              },
            },
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
    },
  },
}
