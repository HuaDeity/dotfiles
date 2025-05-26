return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "ravitemer/codecompanion-history.nvim",
      {
        "HakonHarnes/img-clip.nvim",
        branch = "feat/pbctl",
        event = "VeryLazy",
        cmd = "PasteImage",
        opts = {
          filetypes = {
            codecompanion = {
              prompt_for_file_name = false,
              template = "[Image]($FILE_PATH)",
              use_absolute_path = true,
            },
          },
        },
        keys = {
          -- suggested keymap
          -- { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
        },
      },
    },
    cmd = { "CodeCompanion", "CodeCompanionChat" },
    init = function() vim.cmd [[cab cc CodeCompanion]] end,
    opts = {
      adapters = {
        azure_openai = function()
          return require("codecompanion.adapters").extend("azure_openai", {
            schema = {
              model = {
                default = "gpt-4.1",
              },
            },
          })
        end,
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "claude-sonnet-4",
              },
            },
          })
        end,
        openrouter = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "https://openrouter.ai/api",
              api_key = "OPENROUTER_API_KEY",
              chat_url = "/v1/chat/completions",
            },
            schema = {
              model = {
                default = "anthropic/claude-opus-4",
              },
            },
          })
        end,
      },
      display = {
        chat = {
          -- show_settings = true,
          start_in_insert_mode = false,
        },
      },
      extensions = {
        history = {
          enabled = true,
          opts = {
            keymap = { n = { "gh", "<D-S-h>" } },
            save_chat_keymap = "sc",
          },
        },
      },
      strategies = {
        chat = {
          keymaps = {
            send = {
              callback = function(chat)
                vim.cmd "stopinsert"
                chat:add_buf_message { role = "llm", content = "" }
                chat:submit()
              end,
              index = 1,
              description = "Send",
            },
            change_adapter = {
              modes = {
                n = { "ga", "<D-A-/>" },
              },
              index = 15,
              callback = "keymaps.change_adapter",
              description = "Change adapter",
            },
          },
          roles = {
            user = "HuaDeity",
          },
          tools = {
            opts = {
              auto_submit_success = false,
              auto_submit_errors = false,
            },
          },
        },
      },
    },
    keys = {
      {
        "<leader>a",
        "<cmd>CodeCompanionChat Toggle<CR>",
        desc = "Toggle Agent",
        mode = { "n", "v" },
      },
      {
        "<LocalLeader>a",
        "<cmd>CodeCompanionActions<CR>",
        desc = "Toggle Agent Actions",
        mode = { "n", "v" },
      },
      {
        "ga",
        "<cmd>CodeCompanionChat Add<CR>",
        desc = "Add Code to Agent",
        mode = { "v" },
      },
    },
    config = function(_, opts)
      ViM.spinner:init()
      -- Setup the entire opts table
      require("codecompanion").setup(opts)
      local groupKeymaps = vim.api.nvim_create_augroup("CodeCompanionUserKeymaps", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = groupKeymaps,
        pattern = "codecompanion", -- This matches the filetype set by the plugin
        callback = function(args)
          -- args.buf contains the buffer number of the matched buffer
          local bufnr = args.buf
          vim.keymap.set(
            { "n", "i", "x" },
            "<D-A-n>",
            "<cmd>CodeCompanionChat<CR>",
            { noremap = true, silent = true, buffer = bufnr, desc = "New Chat" }
          )
        end,
      })
    end,
  },
  -- Edgy integration
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        ft = "codecompanion",
        title = "CodeCompanion",
        size = { width = 30 },
        pinned = true,
        open = "CodeCompanionChat Toggle",
        filter = function(buf, win) return vim.api.nvim_win_get_config(win).relative == "" end,
      })
    end,
  },
}
