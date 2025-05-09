return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup {
        integrations = {
          dap = true,
          dap_ui = true,
          octo = true,
          rainbow_delimiters = true,
          render_markdown = true,
        },
      }
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  {
    "f-person/auto-dark-mode.nvim",
    opts = {},
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
      icons = {
        kinds = {
          -- LLM Provider icons
          claude = "󰋦",
          openai = "󱢆",
          codestral = "󱎥",
          gemini = "",
          Groq = "",
          Openrouter = "󱂇",
          Ollama = "󰳆",
          ["Llama.cpp"] = "󰳆",
          Deepseek = "",
        },
      },
    },
  },
}
