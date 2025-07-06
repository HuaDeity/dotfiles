vim.pack.add {
  "https://github.com/echasnovski/mini.diff",
  "https://github.com/sindrets/diffview.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
  -- "https://github.com/f-person/git-blame.nvim",
}

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

require("gitsigns").setup {
  signs = {
    add = { text = icons.git.add },
    change = { text = icons.git.add },
    delete = { text = icons.git.delete },
    topdelete = { text = icons.git.delete },
    changedelete = { text = icons.git.add },
    untracked = { text = icons.git.add },
  },
  signs_staged = {
    add = { text = icons.git.add },
    change = { text = icons.git.add },
    delete = { text = icons.git.delete },
    topdelete = { text = icons.git.delete },
    changedelete = { text = icons.git.add },
    untracked = { text = icons.git.add },
  },
  attach_to_untracked = false,
  current_line_blame = true,
  on_attach = function(buffer)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, desc) vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc }) end

		-- stylua: ignore start
		map("n", "]c", function() if vim.wo.diff then vim.cmd.normal({ "]c", bang = true }) else gs.nav_hunk("next") end end, "Next hunk")
		map("n", "[c", function() if vim.wo.diff then vim.cmd.normal({ "[c", bang = true }) else gs.nav_hunk("prev") end end, "Prev hunk")
		map("n", "<D-F8>", function() if vim.wo.diff then vim.cmd.normal({ "]c", bang = true }) else gs.nav_hunk("next") end end, "Next hunk")
		map("n", "<D-S-F8>", function() if vim.wo.diff then vim.cmd.normal({ "[c", bang = true }) else gs.nav_hunk("prev") end end, "Prev hunk")
		map("n", "]C", function() gs.nav_hunk("last") end, "Last hunk")
		map("n", "[C", function() gs.nav_hunk("first") end, "First hunk")

		map("n", "do", gs.preview_hunk_inline, "Preview hunk")
		map("n", "<D-'>", gs.preview_hunk_inline, "Preview hunk")

		-- Actions
		map('n', 'du', gs.stage_hunk, "Apply hunks")
		map('n', 'dU', gs.reset_hunk, "Reset Hunks")
		map('v', 'du', function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, "Apply hunks")
		map('v', 'dU', function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, "Reset Hunks")
		map('n', '<D-y>', gs.stage_hunk, "Apply hunks")
		map('n', '<D-Y>', gs.reset_hunk, "Reset Hunks")
		map('v', '<D-y>', function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, "Apply hunks")
		map('v', '<D-Y>', function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, "Reset Hunks")

		map({ "o", "x" }, "ih", "<Cmd>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
    -- stylua: ignore end
  end,
}
Snacks.toggle({
  name = "Git Signs",
  get = function() return require("gitsigns.config").config.signcolumn end,
  set = function(state) require("gitsigns").toggle_signs(state) end,
}):map "<leader>uG"

require("mini.diff").setup {
  mappings = {
    apply = "",
    reset = "",
    textobject = "",
    goto_first = "",
    goto_prev = "",
    goto_next = "",
    goto_last = "",
    -- apply = "du",
    -- reset = "dU",
    -- textobject = "ih",
    -- goto_first = "[C",
    -- goto_prev = "[c",
    -- goto_next = "]c",
    -- goto_last = "]C",
  },
  -- view = {
  --   style = "sign",
  --   signs = {
  --     add = icons.git.add,
  --     delete = icons.git.delete,
  --   },
  -- },
}
-- Snacks.toggle({
--   name = "Git Signs",
--   get = function() return vim.g.minidiff_disable ~= true end,
--   set = function(state)
--     vim.g.minidiff_disable = not state
--     if state then
--       require("mini.diff").enable(0)
--     else
--       require("mini.diff").disable(0)
--     end
--     -- HACK: redraw to update the signs
--     vim.defer_fn(function() vim.cmd [[redraw!]] end, 200)
--   end,
-- }):map "<leader>uG"
-- require("gitblame").setup()
-- stylua: ignore start
-- vim.keymap.set({ "n", "x" }, "<D-F8>", "<Cmd>lua MiniDiff.goto_hunk('next')<CR>", { desc = "Next hunk" })
-- vim.keymap.set("o", "<D-F8>", "V<Cmd>lua MiniDiff.goto_hunk('next')<CR>", { desc = "Next hunk" })
-- vim.keymap.set({ "n", "x" }, "<D-S-F8>", "<Cmd>lua MiniDiff.goto_hunk('prev')<CR>", { desc = "Prev hunk" })
-- vim.keymap.set("o", "<D-S-F8>", "V<Cmd>lua MiniDiff.goto_hunk('prev')<CR>", { desc = "Prev hunk" })
--
-- vim.keymap.set("n", "do", function() require("mini.diff").toggle_overlay(0) end, { desc = "Preview hunk" })
-- vim.keymap.set("n", "<D-'>", function() require("mini.diff").toggle_overlay(0) end, { desc = "Preview hunk" })
--
-- vim.keymap.set({ "n", "x" }, "<D-y>", function() return require("mini.diff").operator "apply" end, { expr = true, desc = "Apply hunks" })
-- vim.keymap.set({ "n", "x" }, "<D-Y>", function() return require("mini.diff").operator "reset" end, { expr = true, desc = "Reset hunks" })
-- stylua: ignore end
