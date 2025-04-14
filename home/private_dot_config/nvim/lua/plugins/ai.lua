return {
  { import = "lazyvim.plugins.extras.ai.copilot" },
  {
    "milanglacier/minuet-ai.nvim",
    config = function()
      require("minuet").setup({
        provider = "gemini",
        provider_options = {
          openai = {
            optional = {
              max_tokens = 256,
            },
          },
          codestral = {
            optional = {
              max_tokens = 256,
              stop = { "\n\n" },
            },
          },
          gemini = {
            generationConfig = {
              maxOutputTokens = 256,
            },
            safetySettings = {
              -- HARM_CATEGORY_HATE_SPEECH,
              -- HARM_CATEGORY_HARASSMENT
              -- HARM_CATEGORY_SEXUALLY_EXPLICIT
              category = "HARM_CATEGORY_DANGEROUS_CONTENT",
              -- BLOCK_NONE
              threshold = "BLOCK_ONLY_HIGH",
            },
          },
        },
      })
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    opts = {
      strategies = {
        chat = {
          tools = {
            ["mcp"] = {
              -- calling it in a function would prevent mcphub from being loaded before it's needed
              callback = function()
                return require("mcphub.extensions.codecompanion")
              end,
              description = "Call tools and resources from the MCP Servers",
            },
          },
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
    },
    -- comment the following line to ensure hub will be ready at the earliest
    cmd = "MCPHub", -- lazy load by default
    build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
    -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
    -- build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
    config = function()
      require("mcphub").setup({
        extensions = {
          -- avante = {
          --   make_slash_commands = true, -- make /slash commands from MCP server prompts
          -- },
          codecompanion = {
            -- Show the mcp tool result in the chat buffer
            -- NOTE:if the result is markdown with headers, content after the headers wont be sent by codecompanion
            show_result_in_chat = false,
            make_vars = true, -- make chat #variables from MCP server resources
            make_slash_commands = true, -- make /slash commands from MCP server prompts
          },
        },
      })
    end,
  },
}
