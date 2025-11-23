vim.pack.add({
  "https://github.com/olimorris/codecompanion.nvim",
  "https://github.com/ravitemer/codecompanion-history.nvim",
  "https://github.com/ravitemer/mcphub.nvim",
  "https://github.com/Davidyz/VectorCode",
  { src = "https://github.com/HakonHarnes/img-clip.nvim", version = "feat/pbctl" },
})

require("img-clip").setup {
  default = {
    verbose = false,
  },
  filetypes = {
    codecompanion = {
      prompt_for_file_name = false,
      template = "[Image]($FILE_PATH)",
      use_absolute_path = true,
    },
  },
}

vim.cmd [[cab cc CodeCompanion]]
require("codecompanion").setup {
  adapters = {
    http = {
      azure_openai = function()
        return require("codecompanion.adapters").extend("azure_openai", {
          schema = {
            model = {
              default = "gpt-4.1",
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
  },
  display = {
    chat = {
      -- show_settings = true,
      start_in_insert_mode = false,
    },
    diff = {
      provider = "mini_diff",
    },
  },
  extensions = {
    history = {
      enabled = true,
      opts = {
        keymap = { n = { "gh", "<D-S-h>" } },
        save_chat_keymap = "sc",
        picker = "snacks",
      },
    },
    mcphub = {
      callback = "mcphub.extensions.codecompanion",
      opts = {
        show_result_in_chat = true, -- Show mcp tool results in chat
        make_vars = true, -- Convert resources to #variables
        make_slash_commands = true, -- Add prompts as /slash commands
      },
    },
    vectorcode = {
      opts = {
        tool_group = {
          -- this will register a tool group called `@vectorcode_toolbox` that contains all 3 tools
          enabled = true,
          -- a list of extra tools that you want to include in `@vectorcode_toolbox`.
          -- if you use @vectorcode_vectorise, it'll be very handy to include
          -- `file_search` here.
          extras = {},
          collapse = false, -- whether the individual tools should be shown in the chat
        },
        tool_opts = {
          ---@type VectorCode.CodeCompanion.LsToolOpts
          ls = {},
          ---@type VectorCode.CodeCompanion.VectoriseToolOpts
          vectorise = {},
          ---@type VectorCode.CodeCompanion.QueryToolOpts
          query = {
            max_num = { chunk = -1, document = -1 },
            default_num = { chunk = 50, document = 10 },
            include_stderr = false,
            use_lsp = false,
            no_duplicate = true,
            chunk_mode = false,
          },
        },
      },
    },
  },
  strategies = {
    chat = {
      adapter = "claude_code",
      -- adapter = {
      --   name = "copilot",
      --   model = "claude-sonnet-4",
      -- },
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
    inline = {
      keymaps = {
        accept_change = {
          modes = { n = "ga" },
          description = "Accept the suggested change",
        },
        reject_change = {
          modes = { n = "gz" },
          description = "Reject the suggested change",
        },
      },
    },
  },
}

vim.keymap.set({ "n", "v" }, "<leader>a", "<cmd>CodeCompanionChat Toggle<CR>", { desc = "Toggle Agent" })
vim.keymap.set({ "n", "v" }, "<LocalLeader>a", "<cmd>CodeCompanionActions<CR>", { desc = "Toggle Agent Actions" })
vim.keymap.set({ "v" }, "ga", "<cmd>CodeCompanionChat Add<CR>", { desc = "Add Code to Agent" })
vim.keymap.set({ "n", "i", "x" }, "<D-A-n>", "<cmd>CodeCompanionChat New<CR>", { desc = "New Chat" })
