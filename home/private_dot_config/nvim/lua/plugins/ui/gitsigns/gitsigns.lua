return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      signs = {
        add = { text = ViM.config.icons.git.add },
        change = { text = ViM.config.icons.git.add },
        delete = { text = ViM.config.icons.git.delete },
        topdelete = { text = ViM.config.icons.git.delete },
        changedelete = { text = ViM.config.icons.git.add },
        untracked = { text = ViM.config.icons.git.add },
      },
      signs_staged = {
        add = { text = ViM.config.icons.git.add },
        change = { text = ViM.config.icons.git.add },
        delete = { text = ViM.config.icons.git.delete },
        topdelete = { text = ViM.config.icons.git.delete },
        changedelete = { text = ViM.config.icons.git.add },
        untracked = { text = ViM.config.icons.git.add },
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
    },
    specs = {
      {
        "dstein64/nvim-scrollview",
        optional = true,
        opts = function() require("scrollview.contrib.gitsigns").setup() end,
      },
      {
        "echasnovski/mini.map",
        optional = true,
        opts = function(_, opts)
          opts.integrations = opts.integrations or {}
          local map = require "mini.map"
          table.insert(opts.integrations, map.gen_integration.gitsigns())
        end,
      },
      {
        "nvim-lualine/lualine.nvim",
        optional = true,
        opts = function(_, opts)
          local x = opts.sections.lualine_b
          for _, comp in ipairs(x) do
            if comp[1] == "diff" then
              comp.source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end
              break
            end
          end
        end,
      },
      {
        "echasnovski/mini.diff",
        optional = true,
        opts = {
          mappings = {
            apply = "",
            reset = "",
            textobject = "",
            goto_first = "",
            goto_prev = "",
            goto_next = "",
            goto_last = "",
          },
        },
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = function()
      Snacks.toggle({
        name = "Git Signs",
        get = function() return require("gitsigns.config").config.signcolumn end,
        set = function(state) require("gitsigns").toggle_signs(state) end,
      }):map "<leader>uG"
    end,
  },
}
