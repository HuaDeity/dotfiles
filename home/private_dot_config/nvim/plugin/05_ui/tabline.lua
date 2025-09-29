require("bufferline").setup {
  highlights = require("catppuccin.special.bufferline").get_theme(),
  options = {
    close_command = function(n) require("snacks").bufdelete(n) end,
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(_, _, diagnostics_dict, context)
      if context.buffer:current() then return "" end
      local ret = (
        diagnostics_dict.error
          and vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.ERROR] .. diagnostics_dict.error .. " "
        or ""
      )
        .. (
          diagnostics_dict.warning
            and vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.WARN] .. diagnostics_dict.warning
          or ""
        )
      return vim.trim(ret)
    end,
    right_mouse_command = "vertical sbuffer %d",
    always_show_bufferline = false,
    get_element_icon = function(element) return require("mini.icons").get("filetype", element.filetype) end,
    hover = {
      enabled = true,
      reveal = { "close" },
    },
    offsets = {
      {
        filetype = "snacks_layout_box",
      },
    },
  },
}

local Offset = require "bufferline.offset"
if not Offset.edgy then
  local get = Offset.get
  ---@diagnostic disable-next-line: duplicate-set-field
  Offset.get = function()
    if package.loaded.edgy then
      local old_offset = get()
      local layout = require("edgy.config").layout
      local ret = { left = "", left_size = 0, right = "", right_size = 0 }
      for _, pos in ipairs { "left", "right" } do
        local sb = layout[pos]
        local title = " Sidebar" .. string.rep(" ", sb.bounds.width - 8)
        if sb and #sb.wins > 0 then
          ret[pos] = old_offset[pos .. "_size"] > 0 and old_offset[pos]
            or pos == "left" and ("%#Bold#" .. title .. "%*" .. "%#BufferLineOffsetSeparator#│%*")
            or pos == "right" and ("%#BufferLineOffsetSeparator#│%*" .. "%#Bold#" .. title .. "%*")
            or 0
          ret[pos .. "_size"] = old_offset[pos .. "_size"] > 0 and old_offset[pos .. "_size"] or sb.bounds.width
        end
      end
      ret.total_size = ret.left_size + ret.right_size
      if ret.total_size > 0 then return ret end
    end
    return get()
  end
  Offset.edgy = true
end

vim.keymap.set("n", "<S-z>p", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin" })
vim.keymap.set("n", "<S-z>L", "<Cmd>BufferLineCloseRight<CR>", { desc = "Delete Buffers to the Right" })
vim.keymap.set("n", "<S-z>H", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Delete Buffers to the Left" })
vim.keymap.set("n", "<S-z>h", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer prev" })
vim.keymap.set("n", "<S-z>l", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer next" })
vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "[B", function() require("bufferline").go_to(1, true) end, { desc = "First Buffer" })
vim.keymap.set("n", "]B", function() require("bufferline").go_to(-1, true) end, { desc = "Last Buffer" })
vim.keymap.set("n", "<C-6>", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<C-^>", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<S-z>D", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
  callback = function()
    -- selene: allow(undefined_variable)
    vim.schedule(function() pcall(nvim_bufferline) end)
  end,
})
