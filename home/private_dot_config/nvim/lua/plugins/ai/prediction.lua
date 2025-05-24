return {
  -- {
  --   "milanglacier/minuet-ai.nvim",
  --   event = "InsertEnter",
  --   opts = {
  --     provider = "gemini",
  --     provider_options = {
  --       openai = {
  --         optional = {
  --           max_tokens = 256,
  --         },
  --       },
  --       codestral = {
  --         optional = {
  --           max_tokens = 256,
  --           stop = { "\n\n" },
  --         },
  --       },
  --       gemini = {
  --         generationConfig = {
  --           maxOutputTokens = 256,
  --         },
  --         safetySettings = {
  --           -- HARM_CATEGORY_HATE_SPEECH,
  --           -- HARM_CATEGORY_HARASSMENT
  --           -- HARM_CATEGORY_SEXUALLY_EXPLICIT
  --           category = "HARM_CATEGORY_DANGEROUS_CONTENT",
  --           -- BLOCK_NONE
  --           threshold = "BLOCK_ONLY_HIGH",
  --         },
  --       },
  --     },
  --   },
  -- },
  -- {
  --   "saghen/blink.cmp",
  --   optional = true,
  --   dependencies = { "milanglacier/minuet-ai.nvim" },
  --   opts = {
  --     keymap = {
  --       ["<A-y>"] = {
  --         function(cmp) cmp.show { providers = { "minuet" } } end,
  --       },
  --     },
  --     sources = {
  --       default = { "minuet" },
  --       providers = {
  --         minuet = {
  --           name = "minuet",
  --           module = "minuet.blink",
  --           async = true,
  --           -- Should match minuet.config.request_timeout * 1000,
  --           -- since minuet.config.request_timeout is in seconds
  --           timeout_ms = 3000,
  --           score_offset = 100, -- Gives minuet higher priority among suggestions
  --         },
  --       },
  --     },
  --     -- Recommended to avoid unnecessary request
  --     completion = { trigger = { prefetch_on_insert = false } },
  --   },
  -- },
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   optional = true,
  --   event = "VeryLazy",
  --   opts = function(_, opts) table.insert(opts.sections.lualine_x, require "minuet.lualine") end,
  -- },
  {
    "zbirenbaum/copilot.lua",
    dependencies = {
      "AndreM222/copilot-lualine",
    },
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
    -- config = function(_, opts)
    --   require("copilot").setup(opts)
    --   vim.api.nvim_create_autocmd("User", {
    --     pattern = "BlinkCmpMenuOpen",
    --     callback = function()
    --       require("copilot.suggestion").dismiss()
    --       vim.b.copilot_suggestion_hidden = true
    --     end,
    --   })
    --
    --   vim.api.nvim_create_autocmd("User", {
    --     pattern = "BlinkCmpMenuClose",
    --     callback = function() vim.b.copilot_suggestion_hidden = false end,
    --   })
    -- end,
  },
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "fang2hou/blink-copilot" },
    opts = {
      sources = {
        default = { "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts) table.insert(opts.sections.lualine_x, { "copilot" }) end,
  },
}
