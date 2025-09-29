vim.lsp.enable "copilot"
vim.lsp.inline_completion.enable()
vim.keymap.set("n", "<tab>", function()
  -- if there is a next edit, jump to it, otherwise apply it if any
  if require("sidekick").nes_jump_or_apply() then
    return -- jumped or applied
  end
  -- if you are using Neovim's native inline completions
  if vim.lsp.inline_completion.get() then return end
  -- any other things (like snippets) you want to do on <tab> go here.

  -- fall back to normal tab
  return "<tab>"
end, { desc = "Goto/Apply Next Edit Suggestion", expr = true })
-- vim.keymap.set(
--   { "i", "n" },
--   "<M-]>",
--   function() vim.lsp.inline_completion.select { count = 1 } end,
--   { desc = "Next Copilot Suggestion" }
-- )
-- vim.keymap.set(
--   { "i", "n" },
--   "<M-[>",
--   function() vim.lsp.inline_completion.select { count = -1 } end,
--   { desc = "Previous Copilot Suggestion" }
-- )

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
