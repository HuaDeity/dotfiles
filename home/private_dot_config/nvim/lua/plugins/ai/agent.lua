return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "ravitemer/codecompanion-history.nvim",
      "ravitemer/mcphub.nvim",
    },
    cmd = { "CodeCompanion" },
    opts = {
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
            add_tool = true,
            add_slash_commands = true,
            tool_opts = {},
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
  },
}
