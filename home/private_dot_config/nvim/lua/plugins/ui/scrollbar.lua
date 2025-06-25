return {
  ---@module "neominimap.config.meta"
  {
    "Isrothy/neominimap.nvim",
    lazy = false, -- NOTE: NO NEED to Lazy load
    init = function()
      vim.o.sidescrolloff = 36

      ---@type Neominimap.Map.Handler
      local extmark_handler = {
        name = "Todo Comment",
        mode = "icon",
        namespace = vim.api.nvim_create_namespace "neominimap_todo_comment",
        init = function() end,
        autocmds = {
          {
            event = { "TextChanged", "TextChangedI" },
            opts = {
              get_buffers = function(args) return tonumber(args.buf) end,
            },
          },
          {
            event = "WinScrolled",
            opts = {
              get_buffers = function()
                local winid = vim.api.nvim_get_current_win()
                local bufnr = vim.api.nvim_win_get_buf(winid)
                return bufnr
              end,
            },
          },
        },
        get_annotations = function(bufnr)
          local plugin = ViM.get_plugin "todo-comments.nvim"
          if not plugin then return {} end
          local ns_id = vim.api.nvim_get_namespaces()["todo-comments"]
          if not ns_id or type(ns_id) ~= "number" then return {} end
          local extmarks = vim.api.nvim_buf_get_extmarks(bufnr, ns_id, 0, -1, {
            details = true,
          })
          local icons = {
            FIX = " ",
            TODO = " ",
            HACK = " ",
            WARN = " ",
            PERF = " ",
            NOTE = " ",
            TEST = "⏲ ",
          }
          local id = { FIX = 1, TODO = 2, HACK = 3, WARN = 4, PERF = 5, NOTE = 6, TEST = 7 }
          return vim.tbl_map(function(extmark) ---@param extmark vim.api.keyset.get_extmark_item
            local detail = extmark[4] ---@type vim.api.keyset.extmark_details
            local group = detail.hl_group ---@type string
            local kind = string.sub(group, 7)
            local icon = icons[kind]
            ---@type Neominimap.Map.Handler.Annotation
            return {
              lnum = extmark[2],
              end_lnum = extmark[2],
              id = id[kind],
              highlight = "TodoFg" .. kind, --- You can customize the highlight here.
              icon = icon,
              priority = detail.priority,
            }
          end, extmarks)
        end,
      }

      local word_highlights = {}
      ---@type Neominimap.Map.Handler
      local word_handler = {
        name = "Word Highlights",
        mode = "line",
        namespace = vim.api.nvim_create_namespace "neominimap_word",

        init = function()
          -- Set up highlight groups
          local base_color = "#404040" -- Default fallback color
          local current_color = "#906060" -- Brighter color for current word

          local hl = vim.api.nvim_get_hl(0, { name = "CursorLine", link = false })
          if hl.bg then
            base_color = string.format("#%06x", hl.bg)
            -- Make current highlight 30% brighter
            local r = bit.rshift(bit.band(hl.bg, 0xFF0000), 16)
            local g = bit.rshift(bit.band(hl.bg, 0xFF00), 8)
            local b = bit.band(hl.bg, 0xFF)
            r = math.min(255, r + math.floor(r * 0.3))
            g = math.min(255, g + math.floor(g * 0.3))
            b = math.min(255, b + math.floor(b * 0.3))
            current_color = string.format("#%02x%02x%02x", r, g, b)
          end

          -- Regular word highlights
          vim.api.nvim_set_hl(0, "NeominimapWordLine", { bg = base_color, default = true })
          vim.api.nvim_set_hl(0, "NeominimapWordSign", { fg = base_color, default = true })
          vim.api.nvim_set_hl(0, "NeominimapWordIcon", { fg = base_color, default = true })

          -- Current word highlights
          vim.api.nvim_set_hl(0, "NeominimapCurrentWordLine", { bg = current_color, default = true })
          vim.api.nvim_set_hl(0, "NeominimapCurrentWordSign", { fg = current_color, default = true })
          vim.api.nvim_set_hl(0, "NeominimapCurrentWordIcon", { fg = current_color, default = true })
        end,

        autocmds = {
          {
            event = { "CursorHold", "CursorHoldI" },
            opts = {
              desc = "Update word highlights when cursor moves",
              callback = function(apply)
                local winid = vim.api.nvim_get_current_win()
                if not winid or not vim.api.nvim_win_is_valid(winid) then return end

                local bufnr = vim.api.nvim_win_get_buf(winid)
                vim.schedule(function()
                  if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
                    -- Cache current word and its positions
                    local word = vim.fn.expand "<cword>"
                    if word and word ~= "" then
                      local key = bufnr .. word
                      if not word_highlights[key] or word_highlights[key].tick ~= vim.b[bufnr].changedtick then
                        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)
                        local positions = {}
                        for lnum, line in ipairs(lines) do
                          if line:find(word, 1, true) then table.insert(positions, lnum) end
                        end
                        word_highlights[key] = {
                          positions = positions,
                          tick = vim.b[bufnr].changedtick,
                        }
                      end
                    end
                    apply(bufnr)
                  end
                end)
              end,
            },
          },
        },

        get_annotations = function(bufnr)
          local word = vim.fn.expand "<cword>"
          if not word or word == "" then return {} end

          local key = bufnr .. word
          local cached = word_highlights[key]
          if not cached then return {} end

          -- Get current cursor position
          local current_line = vim.api.nvim_win_get_cursor(0)[1]

          local annotations = {}
          for _, lnum in ipairs(cached.positions) do
            table.insert(annotations, {
              lnum = lnum,
              end_lnum = lnum,
              priority = 25, -- Between search (20) and diagnostics (70-100)
              id = 1,
              highlight = (lnum == current_line) and "NeominimapCurrentWordLine" or "NeominimapWordLine",
            })
          end

          return annotations
        end,
      }

      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        group = vim.api.nvim_create_augroup("setup_neominimap", { clear = true }),
        callback = function()
          Snacks.toggle({
            name = "minimap",
            get = function() return require("neominimap.api").enabled() end,
            set = function(state)
              if state then
                require("neominimap.api").enable()
              else
                require("neominimap.api").disable()
              end
            end,
          }):map "<leader>umm"
          Snacks.toggle({
            name = "minimap for buffer",
            get = function() return require("neominimap.api").buf.enabled() end,
            set = function(state)
              if state then
                require("neominimap.api").buf.enable()
              else
                require("neominimap.api").buf.disable()
              end
            end,
          }):map "<leader>umb"
          Snacks.toggle({
            name = "minimap for window",
            get = function() return require("neominimap.api").win.enabled() end,
            set = function(state)
              if state then
                require("neominimap.api").win.enable()
              else
                require("neominimap.api").win.disable()
              end
            end,
          }):map "<leader>umw"
          Snacks.toggle({
            name = "minimap for tabpage",
            get = function() return require("neominimap.api").tab.enabled() end,
            set = function(state)
              if state then
                require("neominimap.api").tab.enable()
              else
                require("neominimap.api").tab.disable()
              end
            end,
          }):map "<leader>umt"
          Snacks.toggle({
            name = "focus",
            get = function() return vim.bo.ft == "neominimap" end,
            set = function(state)
              if state then
                require("neominimap.api").focus.enable()
              else
                require("neominimap.api").focus.disable()
              end
            end,
          }):map "<leader>umf"
        end,
      })

      vim.api.nvim_create_autocmd("WinEnter", {
        group = vim.api.nvim_create_augroup("minimap", { clear = true }),
        pattern = "*",
        callback = function()
          if vim.bo.buftype ~= "nofile" then require("neominimap.api").tab.refresh() end
        end,
      })

      --- Put your configuration here
      ---@type Neominimap.UserConfig
      vim.g.neominimap = {
        click = {
          enabled = true,
        },

        buffer = {
          persist = false,
        },

        split = {
          close_if_last_window = true,
          persist = false,
        },

        float = {
          margin = {
            right = 2,
          },
          minimap_width = 13, ---@type integer
          persist = false,
        },

        mark = {
          enabled = true,
          show_builtins = true,
        },

        search = {
          enabled = true,
          mode = "sign",
        },

        -- How many columns a dot should span
        x_multiplier = 3, ---@type integer
        -- How many rows a dot should span
        y_multiplier = 2, ---@type integer

        win_filter = function(winid) return winid == vim.api.nvim_get_current_win() end,
        buf_filter = function(bufnr) return vim.api.nvim_buf_line_count(bufnr) < 4096 end,

        ---@type Neominimap.Map.Handler[]
        handlers = {
          extmark_handler,
          word_handler,
        },
      }
    end,
    keys = {
      { "<leader>umrr", "<cmd>Neominimap Refresh<cr>", desc = "Refresh global minimap" },
      { "<leader>umrw", "<cmd>Neominimap WinRefresh<cr>", desc = "Refresh minimap for current window" },
      { "<leader>umrt", "<cmd>Neominimap TabRefresh<cr>", desc = "Refresh minimap for current tab" },
      { "<leader>umrb", "<cmd>Neominimap BufRefresh<cr>", desc = "Refresh minimap for current buffer" },
    },
    specs = {
      {
        "nvim-lualine/lualine.nvim",
        optional = true,
        opts = function(_, opts)
          local minimap_extension = require("neominimap.statusline").lualine_default
          opts = opts or {}
          opts.extensions = opts.extensions or {}
          vim.list_extend(opts.extensions, { minimap_extension })
          return opts
        end,
      },
      {

        "luukvbaal/statuscol.nvim",
        optional = true,
        opts = {
          ft_ignore = { "neominimap" },
        },
      },
    },
  },
  {
    "dstein64/nvim-scrollview",
    event = "VeryLazy",
    opts_extend = { "excluded_filetypes" },
    opts = {
      signs_on_startup = {
        "cursor",
        "search",
        "diagnostics",
        "marks",
        "quickfix",
      },
    },
    config = function(_, opts) require("scrollview").setup(opts) end,
  },
  -- {
  --   "lewis6991/satellite.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  -- },
  --   {
  --   "echasnovski/mini.map",
  --   dependencies = { "lewis6991/gitsigns.nvim" },
  --   event = "VeryLazy",
  --   opts = function()
  --     local map = require "mini.map"
  --     return {
  --       integrations = {
  --         map.gen_integration.builtin_search(),
  --       },
  --       symbols = {
  --         encode = map.gen_encode_symbols.dot "3x2",
  --       },
  --       window = {
  --         focusable = true,
  --         show_integration_count = false,
  --       },
  --     }
  --   end,
  --   config = function(_, opts)
  --     require("mini.map").setup(opts)
  --     MiniMap.open()
  --   end,
  --   keys = {
  --     { "<leader>um", function() require("mini.map").toggle() end, desc = "Toggle minimap" },
  --   },
  -- },
}
