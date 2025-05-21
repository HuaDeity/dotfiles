return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "ravitemer/codecompanion-history.nvim",
    },
    cmd = { "CodeCompanion" },
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
      },
      display = {
        chat = {
          start_in_insert_mode = true,
        },
      },
      extensions = {
        history = {
          enabled = true,
          opts = {
            -- Keymap to open history from chat buffer (default: gh)
            keymap = "gh",
            -- Automatically generate titles for new chats
            auto_generate_title = true,
            ---On exiting and entering neovim, loads the last chat on opening chat
            continue_last_chat = false,
            ---When chat is cleared with `gx` delete the chat from history
            delete_on_clearing_chat = false,
            -- Picker interface ("telescope" or "snacks" or "default")
            picker = "snacks",
            ---Enable detailed logging for history extension
            enable_logging = false,
            ---Directory path to save the chats
            dir_to_save = vim.fn.stdpath "data" .. "/codecompanion-history",
            -- Save all chats by default
            auto_save = true,
            -- Keymap to save the current chat manually
            save_chat_keymap = "sc",
            -- Number of days after which chats are automatically deleted (0 to disable)
            expiration_days = 0,
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
          },
        },
      },
    },
    keys = {
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<leader>aa",
        function() return require("codecompanion").toggle() end,
        desc = "Toggle Agent",
        mode = { "n", "v" },
      },
      {
        "<leader>ac",
        function() return require("codecompanion").actions {} end,
        desc = "Toggle Agent",
        mode = { "n", "v" },
      },
      {
        "ga",
        function() require("codecompanion").add {} end,
        desc = "Add Code to Agent",
        mode = { "v" },
      },
    },
    config = function(_, opts)
      ViM.spinner:init()

      -- Setup the entire opts table
      require("codecompanion").setup(opts)
    end,
  },
}
