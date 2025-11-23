vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range "1.*" },
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/xzbdmw/colorful-menu.nvim",
  "https://github.com/moyiz/blink-emoji.nvim",
  "https://github.com/Kaiser-Yang/blink-cmp-git",
  "https://github.com/fang2hou/blink-copilot",
  "https://github.com/folke/lazydev.nvim",
})

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

require("blink.cmp").setup {
  cmdline = {
    keymap = {
      -- recommended, as the default keymap will only show and select the next item
      ["<Tab>"] = { "show", "accept" },
    },
    completion = {
      menu = {
        auto_show = function(_)
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
        preselect = function(_) return not require("blink.cmp").snippet_active { direction = 1 } end,
        auto_insert = function(_) return vim.bo.filetype ~= "markdown" end,
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
              local kind_icon = nil
              if kind_icon == nil and extra_kind_icons[ctx.kind] then kind_icon = extra_kind_icons[ctx.kind].glyph end
              -- if LSP source, check for color derived from documentation
              if kind_icon == nil and ctx.item.source_name == "LSP" then
                local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                if color_item and color_item.abbr ~= "" then kind_icon = color_item.abbr end
              end
              if kind_icon == nil then
                kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
              end
              return kind_icon .. ctx.icon_gap
            end,
            -- (optional) use highlights from mini.icons
            highlight = function(ctx)
              local hl = nil
              if hl == nil and extra_kind_icons[ctx.kind] then hl = extra_kind_icons[ctx.kind].hl end
              -- if LSP source, check for color derived from documentation
              if hl == nil and ctx.item.source_name == "LSP" then
                local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                if color_item and color_item.abbr_hl_group then hl = color_item.abbr_hl_group end
              end
              if hl == nil then
                _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
              end
              return { { group = hl, priority = 20000 } }
            end,
          },
          kind = {
            -- (optional) use highlights from mini.icons
            highlight = function(ctx)
              local hl = nil
              if hl == nil and extra_kind_icons[ctx.kind] then hl = extra_kind_icons[ctx.kind].hl end
              if hl == nil then
                _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
              end
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
      -- prefetch_on_insert = false
    },
  },
  keymap = {
    preset = "super-tab",
    ["<Tab>"] = {
      function(cmp)
        if cmp.snippet_active() then
          return cmp.accept()
        else
          return cmp.select_and_accept()
        end
      end,
      "snippet_forward",
      function() -- sidekick next edit suggestion
        return require("sidekick").nes_jump_or_apply()
      end,
      function() -- if you are using Neovim's native inline completions
        return vim.lsp.inline_completion.get()
      end,
      "fallback",
    },
    ["<CR>"] = { "accept", "fallback" },
  },

  -- Shows a signature help window while you type arguments for a function
  signature = { enabled = true },

  sources = {
    default = {
      "lsp",
      "copilot",
      -- "minuet",
      "omni",
      "path",
      "snippets",
      "buffer",
      "emoji",
      "git",
    },
    per_filetype = {
      lua = { inherit_defaults = true, "lazydev" },
    },
    providers = {
      copilot = {
        name = "copilot",
        module = "blink-copilot",
        score_offset = 100,
        async = true,
        opts = {
          kind_icon = "󰙲",
        },
      },
      -- minuet = {
      --   name = "minuet",
      --   module = "minuet.blink",
      --   async = true,
      --   -- Should match minuet.config.request_timeout * 1000,
      --   -- since minuet.config.request_timeout is in seconds
      --   timeout_ms = 3000,
      --   score_offset = 100, -- Gives minuet higher priority among suggestions
      -- },
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100, -- show at a higher priority than lsp
      },
      cmdline = {
        min_keyword_length = function(ctx)
          -- when typing a command, only show when the keyword is 3 characters or longer
          if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then return 2 end
          return 0
        end,
      },
      path = {
        opts = {
          get_cwd = function(_) return vim.fn.getcwd() end,
          show_hidden_files_by_default = true,
        },
      },
      emoji = {
        module = "blink-emoji",
        name = "Emoji",
        score_offset = 15, -- Tune by preference
        opts = {
          insert = true,
          pre_trigger = function() return { "", " ", "\t" } end,
          trigger = function() return { ":" } end,
        },
        should_show_items = function()
          return vim.tbl_contains(
            -- Enable emoji completion only for git commits and markdown.
            -- By default, enabled for all file-types.
            { "octo", "gitcommit", "markdown" },
            vim.o.filetype
          )
        end,
      },
      git = {
        module = "blink-cmp-git",
        name = "Git",
        -- only enable this source when filetype is gitcommit, markdown, or 'octo'
        enabled = function() return vim.tbl_contains({ "octo", "gitcommit", "markdown" }, vim.bo.filetype) end,
        opts = {
          -- options for the blink-cmp-git
        },
      },
    },
  },
}
