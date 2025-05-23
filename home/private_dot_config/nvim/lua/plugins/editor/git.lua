return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      current_line_blame = true,
      -- signs = {
      --   add = { text = "▎" },
      --   change = { text = "▎" },
      --   delete = { text = "" },
      --   topdelete = { text = "" },
      --   changedelete = { text = "▎" },
      --   untracked = { text = "▎" },
      -- },
      -- signs_staged = {
      --   add = { text = "▎" },
      --   change = { text = "▎" },
      --   delete = { text = "" },
      --   topdelete = { text = "" },
      --   changedelete = { text = "▎" },
      -- },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc) vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc }) end

        -- stylua: ignore start
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")
        map("n", "<D-F8>", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "<D-S-F8>", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")
        map("n", "]C", function() gs.nav_hunk("last") end, "Last Hunk")
        map("n", "[C", function() gs.nav_hunk("first") end, "First Hunk")

        map("n", "do", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<D-'>", gs.preview_hunk_inline, "Preview Hunk Inline")

        -- Actions
        map('n', 'du', gs.stage_hunk, "Stage Hunk")
        map('n', 'dU', gs.reset_hunk, "Reset Hunk")
        map('n', '<D-y>', gs.stage_hunk, "Stage Hunk")
        map('n', '<D-Y>', gs.reset_hunk, "Reset Hunk")

        map('v', '<D-y>', function()
          gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, "Stage Hunk")

        map('v', '<D-Y>', function()
          gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, "Reset Hunk")

        -- map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },
  {
    "gitsigns.nvim",
    opts = function()
      Snacks.toggle({
        name = "Git Signs",
        get = function() return require("gitsigns.config").config.signcolumn end,
        set = function(state) require("gitsigns").toggle_signs(state) end,
      }):map "<leader>uG"
    end,
  },
  -- {
  --   "echasnovski/mini.diff",
  --   event = "VeryLazy",
  --   keys = {
  --     {
  --       "<leader>go",
  --       function() require("mini.diff").toggle_overlay(0) end,
  --       desc = "Toggle mini.diff overlay",
  --     },
  --   },
  --   opts = {
  --     -- view = {
  --     --   style = "sign",
  --     --   signs = {
  --     --     add = "▎",
  --     --     change = "▎",
  --     --     delete = "",
  --     --   },
  --     -- },
  --   },
  --   config = function(_, opts)
  --     local diff = require "mini.diff"
  --     opts.source = diff.gen_source.none()
  --     require("mini.diff").setup(opts)
  --   end,
  -- },
  -- {
  --   "mini.diff",
  --   opts = function()
  --     Snacks.toggle({
  --       name = "Mini Diff Signs",
  --       get = function() return vim.g.minidiff_disable ~= true end,
  --       set = function(state)
  --         vim.g.minidiff_disable = not state
  --         if state then
  --           require("mini.diff").enable(0)
  --         else
  --           require("mini.diff").disable(0)
  --         end
  --         -- HACK: redraw to update the signs
  --         vim.defer_fn(function() vim.cmd [[redraw!]] end, 200)
  --       end,
  --     }):map "<leader>uG"
  --   end,
  -- },
  -- -- lualine integration
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   opts = function(_, opts)
  --     local x = opts.sections.lualine_x
  --     for _, comp in ipairs(x) do
  --       if comp[1] == "diff" then
  --         comp.source = function()
  --           local summary = vim.b.minidiff_summary
  --           return summary
  --             and {
  --               added = summary.add,
  --               modified = summary.change,
  --               removed = summary.delete,
  --             }
  --         end
  --         break
  --       end
  --     end
  --   end,
  -- },
}
