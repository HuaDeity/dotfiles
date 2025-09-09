require("hover").setup {
  init = function()
    -- Require providers
    require "hover.providers.lsp"
    -- require('hover.providers.gh')
    -- require('hover.providers.gh_user')
    -- require('hover.providers.jira')
    require "hover.providers.dap"
    -- require('hover.providers.fold_preview')
    require "hover.providers.diagnostic"
    require "hover.providers.man"
    -- require('hover.providers.dictionary')
    -- require('hover.providers.highlight')
  end,
  preview_opts = {
    border = vim.o.winborder,
  },
  -- mouse_providers = {
  --   "LSP",
  --   "Diagnostics",
  -- },
  -- mouse_delay = 300,
}

-- local timer = nil
-- local delay = 300
-- local previous_pos = nil
--
-- local function on_hover(current)
--   if vim.o.showtabline == 0 then return end
--   if current.screenrow == 1 then
--     vim.api.nvim_exec_autocmds("User", {
--       pattern = "BufferLineHoverOver",
--       data = { cursor_pos = current.screencol },
--     })
--   elseif current.screenrow ~= 1 then
--     if previous_pos and previous_pos.screenrow == 1 then
--       vim.api.nvim_exec_autocmds("User", {
--         pattern = "BufferLineHoverOut",
--         data = {},
--       })
--     end
--     require("hover").mouse()
--   end
--   previous_pos = current
-- end

-- vim.api.nvim_create_autocmd("VimLeavePre", {
--   group = vim.api.nvim_create_augroup("BufferLineHover", { clear = true }),
--   callback = function()
--     if timer then
--       timer:close()
--       timer = nil
--     end
--   end,
-- })

---@diagnostic disable:missing-parameter
vim.keymap.set("n", "K", function() require("hover").open() end, { desc = "hover open" })
vim.keymap.set("n", "gh", function() require("hover").enter() end, { desc = "hover enter" })
vim.keymap.set("n", "gk", function() require("hover").select() end, { desc = "hover selection" })
vim.keymap.set("n", "]h", function() require("hover").switch "next" end, { desc = "hover next source" })
vim.keymap.set("n", "[h", function() require("hover").switch "previous" end, { desc = "hover previous source" })
-- vim.keymap.set("n", "<MouseMove>", function()
--   if timer then timer:close() end
--   timer = vim.defer_fn(function()
--     timer = nil
--     local ok, pos = pcall(vim.fn.getmousepos)
--     if not ok then return end
--     on_hover(pos)
--   end, delay)
--   return "<MouseMove>"
-- end, { expr = true, desc = "hover mouse" })
