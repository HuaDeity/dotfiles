return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "ravitemer/codecompanion-history.nvim",
    },
    cmd = { "CodeCompanion" },
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
            keymap = { n = { "gh", "<D-S-h>" } },
            -- keymap = "gh",
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
      {
        "<leader>a",
        "<cmd>CodeCompanionChat Toggle<CR>",
        desc = "Toggle Agent",
        mode = { "n", "v" },
      },
      {
        "<C-a>",
        "<cmd>CodeCompanionActions<CR>",
        desc = "Toggle Agent Actions",
        mode = { "n", "v" },
      },
      {
        "<LocalLeader>a",
        "<cmd>CodeCompanionChat Add<CR>",
        desc = "Add Code to Agent",
        mode = { "v" },
      },
    },
    config = function(_, opts)
      ViM.spinner:init()
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

      -- Setup the entire opts table
      require("codecompanion").setup(opts)
    end,
  },
}
