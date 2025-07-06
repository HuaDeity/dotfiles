-- Variable to track if auth is needed
local needs_auth = false

-- Setup Copilot on BufReadPost
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("CopilotSetup", { clear = true }),
  callback = function()
    require("copilot").setup {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    }
    if needs_auth then vim.cmd "Copilot auth" end
  end,
  desc = "Copilot: Setup on buffer read",
})

vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("CopilotAuth", { clear = true }),
  callback = function(args)
    if args.data.kind == "update" and args.data.spec.name == "copilot.lua" then
      needs_auth = true -- Set flag to include auth in next setup
    end
  end,
  desc = "Copilot: Schedule auth on package update",
})

vim.pack.add {
  "https://github.com/zbirenbaum/copilot.lua",
  "https://github.com/AndreM222/copilot-lualine",
  -- "https://github.com/milanglacier/minuet-ai.nvim",
}

-- require("minuet").setup {
--   provider = "gemini",
--   provider_options = {
--     openai = {
--       optional = {
--         max_tokens = 256,
--       },
--     },
--     codestral = {
--       optional = {
--         max_tokens = 256,
--         stop = { "\n\n" },
--       },
--     },
--     gemini = {
--       generationConfig = {
--         maxOutputTokens = 256,
--       },
--       safetySettings = {
--         -- HARM_CATEGORY_HATE_SPEECH,
--         -- HARM_CATEGORY_HARASSMENT
--         -- HARM_CATEGORY_SEXUALLY_EXPLICIT
--         category = "HARM_CATEGORY_DANGEROUS_CONTENT",
--         -- BLOCK_NONE
--         threshold = "BLOCK_ONLY_HIGH",
--       },
--     },
--   },
-- }
