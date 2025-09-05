require("diffview").setup {
  enhanced_diff_hl = true,
  view = {
    default = { winbar_info = true },
    file_history = { winbar_info = true },
  },
  hooks = { diff_buf_read = function(bufnr) vim.b[bufnr].view_activated = false end },
}

local icons = {
  git = {
    add = "▊",
    delete = "",
  },
}

require("mini.diff").setup {
  mappings = {
    apply = "du",
    reset = "dU",
    textobject = "ih",
    goto_first = "[C",
    goto_prev = "[c",
    goto_next = "]c",
    goto_last = "]C",
  },
  view = {
    style = "sign",
    signs = {
      add = icons.git.add,
      change = icons.git.add,
      delete = icons.git.delete,
    },
  },
}
require("snacks")
  .toggle({
    name = "Git Signs",
    get = function() return vim.g.minidiff_disable ~= true end,
    set = function(state)
      vim.g.minidiff_disable = not state
      if state then
        require("mini.diff").enable(0)
      else
        require("mini.diff").disable(0)
      end
      -- HACK: redraw to update the signs
      vim.defer_fn(function() vim.cmd [[redraw!]] end, 200)
    end,
  })
  :map "<leader>uG"
-- stylua: ignore start
vim.keymap.set({ "n", "x" }, "<D-F8>", "<Cmd>lua MiniDiff.goto_hunk('next')<CR>", { desc = "Next hunk" })
vim.keymap.set("o", "<D-F8>", "V<Cmd>lua MiniDiff.goto_hunk('next')<CR>", { desc = "Next hunk" })
vim.keymap.set({ "n", "x" }, "<D-S-F8>", "<Cmd>lua MiniDiff.goto_hunk('prev')<CR>", { desc = "Prev hunk" })
vim.keymap.set("o", "<D-S-F8>", "V<Cmd>lua MiniDiff.goto_hunk('prev')<CR>", { desc = "Prev hunk" })

vim.keymap.set("n", "do", function() require("mini.diff").toggle_overlay(0) end, { desc = "Preview hunk" })
vim.keymap.set("n", "<D-'>", function() require("mini.diff").toggle_overlay(0) end, { desc = "Preview hunk" })

vim.keymap.set({ "n", "x" }, "<D-y>", function() return require("mini.diff").operator "apply" end, { expr = true, desc = "Apply hunks" })
vim.keymap.set({ "n", "x" }, "<D-Y>", function() return require("mini.diff").operator "reset" end, { expr = true, desc = "Reset hunks" })
-- stylua: ignore end

require("gitblame").setup()
