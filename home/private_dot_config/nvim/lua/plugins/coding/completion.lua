local extra_kind_icons = {
  Copilot = { glyph = "", hl = "MiniIconsGrey" },
  claude = { glyph = "󰋦", hl = "MiniIconsBlue" },
  openai = { glyph = "󱢆", hl = "MiniIconsBlue" },
  codestral = { glyph = "󱎥", hl = "MiniIconsBlue" },
  gemini = { glyph = "", hl = "MiniIconsBlue" },
  Groq = { glyph = "", hl = "MiniIconsBlue" },
  Openrouter = { glyph = "󱂇", hl = "MiniIconsBlue" },
  Ollama = { glyph = "󰳆", hl = "MiniIconsBlue" },
  ["Llama.cpp"] = { glyph = "󰳆", hl = "MiniIconsBlue" },
  Deepseek = { glyph = "", hl = "MiniIconsBlue" },
}

return {
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    version = "1.*",
    opts_extend = {
      "sources.default",
    },
    dependencies = {
      "rafamadriz/friendly-snippets",
      "xzbdmw/colorful-menu.nvim",
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      cmdline = {
        keymap = {
          -- recommended, as the default keymap will only show and select the next item
          ["<Tab>"] = { "show", "accept" },
          ["<CR>"] = { "accept_and_enter", "fallback" },
        },
        completion = {
          menu = {
            auto_show = function(ctx)
              return vim.fn.getcmdtype() == ":"
              -- enable for inputs as well, with:
              -- or vim.fn.getcmdtype() == '@'
            end,
          },
        },
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },

        ghost_text = {
          enabled = true,
          show_with_menu = false,
        },

        list = {
          selection = {
            preselect = function(ctx) return not require("blink.cmp").snippet_active { direction = 1 } end,
            auto_insert = function(ctx) return vim.bo.filetype ~= "markdown" end,
          },
        },

        menu = {
          draw = {
            -- We don't need label_description now because label and label_description are already
            -- combined together in label by colorful-menu.nvim.
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              kind_icon = {
                text = function(ctx)
                  if extra_kind_icons[ctx.kind] then return extra_kind_icons[ctx.kind].glyph end
                  local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                  return kind_icon .. ctx.icon_gap
                end,
                -- (optional) use highlights from mini.icons
                highlight = function(ctx)
                  if extra_kind_icons[ctx.kind] then return extra_kind_icons[ctx.kind].hl end
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return { { group = hl, priority = 20000 } }
                end,
              },
              kind = {
                -- (optional) use highlights from mini.icons
                highlight = function(ctx)
                  if extra_kind_icons[ctx.kind] then return extra_kind_icons[ctx.kind].hl end
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },
              label = {
                width = { fill = true, max = 60 },
                text = function(ctx)
                  local highlights_info = require("colorful-menu").blink_highlights(ctx)
                  if highlights_info ~= nil then
                    -- Or you want to add more item to label
                    return highlights_info.label
                  else
                    return ctx.label
                  end
                end,
                highlight = function(ctx)
                  local highlights = {}
                  local highlights_info = require("colorful-menu").blink_highlights(ctx)
                  if highlights_info ~= nil then highlights = highlights_info.highlights end
                  for _, idx in ipairs(ctx.label_matched_indices) do
                    table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                  end
                  -- Do something else
                  return highlights
                end,
              },
            },
            treesitter = { "lsp" },
          },
        },

        trigger = {
          -- show_in_snippet = false,
        },
      },

      keymap = {
        preset = "super-tab",
        ["<CR>"] = { "accept", "fallback" },
      },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          cmdline = {
            min_keyword_length = function(ctx)
              -- when typing a command, only show when the keyword is 3 characters or longer
              if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then return 3 end
              return 0
            end,
          },
          path = {
            opts = {
              get_cwd = function(_) return vim.fn.getcwd() end,
              show_hidden_files_by_default = true,
            },
          },
        },
      },
    },
  },
}
