return {
  {
    "folke/snacks.nvim",
    keys = function(_, keys)
      keys = keys or {}
      -- Base keymaps
      local git_keys = {
        { "<leader>gy", function() Snacks.gitbrowse() end, desc = "Git Browse (open)", mode = { "n", "x" } },
        {
          "<leader>gY",
          function()
            Snacks.gitbrowse { open = function(url) vim.fn.setreg("+", url) end, notify = false }
          end,
          desc = "Git Browse (copy)",
          mode = { "n", "x" },
        },
      }
      -- Conditionally add lazygit keymaps
      if vim.fn.executable "lazygit" == 1 then
        vim.list_extend(git_keys, {
          {
            "<leader>gg",
            function() Snacks.lazygit { cwd = ViM.root.git() } end,
            desc = "Lazygit (Root Dir)",
          },
          {
            "<leader>gG",
            function() Snacks.lazygit() end,
            desc = "Lazygit (cwd)",
          },
        })
      end
      -- Conditionally add gitui keymaps
      if vim.fn.executable "gitui" == 1 then
        vim.list_extend(git_keys, {
          {
            "<leader>gg",
            function()
              local colorscheme = vim.g.colors_name
              Snacks.terminal({ "gitui", "-t", colorscheme .. ".ron" }, { cwd = ViM.root.get() })
            end,
            desc = "GitUi (Root Dir)",
          },
          {
            "<leader>gG",
            function()
              local colorscheme = vim.g.colors_name
              Snacks.terminal { "gitui", "-t", colorscheme .. ".ron" }
            end,
            desc = "GitUi (cwd)",
          },
        })
      end
      -- Merge with existing keys
      vim.list_extend(keys, git_keys)
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      table.insert(opts.sections.lualine_b, "branch")
      local git_icons = {
        added = " ",
        modified = " ",
        removed = " ",
      }
      table.insert(opts.sections.lualine_b, {
        "diff",
        symbols = {
          added = git_icons.added,
          modified = git_icons.modified,
          removed = git_icons.removed,
        },
      })
    end,
  },
  -- {
  --   "lewis6991/gitsigns.nvim",
  --   event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  --   opts = {
  --     current_line_blame = true,
  --     -- signs = {
  --     --   add = { text = "▎" },
  --     --   change = { text = "▎" },
  --     --   delete = { text = "" },
  --     --   topdelete = { text = "" },
  --     --   changedelete = { text = "▎" },
  --     --   untracked = { text = "▎" },
  --     -- },
  --     -- signs_staged = {
  --     --   add = { text = "▎" },
  --     --   change = { text = "▎" },
  --     --   delete = { text = "" },
  --     --   topdelete = { text = "" },
  --     --   changedelete = { text = "▎" },
  --     -- },
  --     on_attach = function(buffer)
  --       local gs = package.loaded.gitsigns
  --
  --       local function map(mode, l, r, desc) vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc }) end
  --
  --       -- stylua: ignore start
  --       map("n", "]c", function()
  --         if vim.wo.diff then
  --           vim.cmd.normal({ "]c", bang = true })
  --         else
  --           gs.nav_hunk("next")
  --         end
  --       end, "Next Hunk")
  --       map("n", "[c", function()
  --         if vim.wo.diff then
  --           vim.cmd.normal({ "[c", bang = true })
  --         else
  --           gs.nav_hunk("prev")
  --         end
  --       end, "Prev Hunk")
  --       map("n", "<D-F8>", function()
  --         if vim.wo.diff then
  --           vim.cmd.normal({ "]c", bang = true })
  --         else
  --           gs.nav_hunk("next")
  --         end
  --       end, "Next Hunk")
  --       map("n", "<D-S-F8>", function()
  --         if vim.wo.diff then
  --           vim.cmd.normal({ "[c", bang = true })
  --         else
  --           gs.nav_hunk("prev")
  --         end
  --       end, "Prev Hunk")
  --       map("n", "]C", function() gs.nav_hunk("last") end, "Last Hunk")
  --       map("n", "[C", function() gs.nav_hunk("first") end, "First Hunk")
  --
  --       map("n", "do", gs.preview_hunk_inline, "Preview Hunk Inline")
  --       map("n", "<D-'>", gs.preview_hunk_inline, "Preview Hunk Inline")
  --
  --       -- Actions
  --       map('n', 'du', gs.stage_hunk, "Stage Hunk")
  --       map('n', 'dU', gs.reset_hunk, "Reset Hunk")
  --       map('n', '<D-y>', gs.stage_hunk, "Stage Hunk")
  --       map('n', '<D-Y>', gs.reset_hunk, "Reset Hunk")
  --
  --       map('v', '<D-y>', function()
  --         gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
  --       end, "Stage Hunk")
  --
  --       map('v', '<D-Y>', function()
  --         gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
  --       end, "Reset Hunk")
  --
  --       map({ "o", "x" }, "ih", "<Cmd>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
  --     end,
  --   },
  --   specs = {
  --     {
  --       "dstein64/nvim-scrollview",
  --       optional = true,
  --       opts = function() require("scrollview.contrib.gitsigns").setup() end,
  --     },
  --     {
  --       "echasnovski/mini.map",
  --       optional = true,
  --       opts = function(_, opts)
  --         opts.integrations = opts.integrations or {}
  --         local map = require "mini.map"
  --         table.insert(opts.integrations, map.gen_integration.gitsigns())
  --       end,
  --     },
  --     {
  --       "nvim-lualine/lualine.nvim",
  --       optional = true,
  --       opts = function(_, opts)
  --         local x = opts.sections.lualine_b
  --         for _, comp in ipairs(x) do
  --           if comp[1] == "diff" then
  --             comp.source = function()
  --               local gitsigns = vim.b.gitsigns_status_dict
  --               if gitsigns then
  --                 return {
  --                   added = gitsigns.added,
  --                   modified = gitsigns.changed,
  --                   removed = gitsigns.removed,
  --                 }
  --               end
  --             end
  --             break
  --           end
  --         end
  --       end,
  --     },
  --   },
  -- },
  -- {
  --   "gitsigns.nvim",
  --   opts = function()
  --     Snacks.toggle({
  --       name = "Git Signs",
  --       get = function() return require("gitsigns.config").config.signcolumn end,
  --       set = function(state) require("gitsigns").toggle_signs(state) end,
  --     }):map "<leader>uG"
  --   end,
  -- },

  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = {
      { "Kaiser-Yang/blink-cmp-git" },
    },
    opts = {
      sources = {
        default = { "git" },
        providers = {
          git = {
            module = "blink-cmp-git",
            name = "Git",
            -- only enable this source when filetype is gitcommit, markdown, or 'octo'
            enabled = function() return vim.tbl_contains({ "octo", "gitcommit", "markdown" }, vim.bo.filetype) end,
            opts = {
              -- options for the blink-cmp-git
            },
          },
        },
      },
    },
  },
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    event = { { event = "BufReadCmd", pattern = "octo://*" } },
    init = function()
      vim.treesitter.language.register("markdown", "octo")
      -- Keep some empty windows in sessions
      vim.api.nvim_create_autocmd("ExitPre", {
        group = vim.api.nvim_create_augroup("octo_exit_pre", { clear = true }),
        callback = function()
          local keep = { "octo" }
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.tbl_contains(keep, vim.bo[buf].filetype) then
              vim.bo[buf].buftype = "" -- set buftype to empty to keep the window
            end
          end
        end,
      })
    end,
    opts = {
      enable_builtin = true,
      default_to_projects_v2 = true,
      default_merge_method = "squash",
    },
    keys = {
      { "<leader>gi", "<cmd>Octo issue list<CR>", desc = "List Issues (Octo)" },
      { "<leader>gI", "<cmd>Octo issue search<CR>", desc = "Search Issues (Octo)" },
      { "<leader>gp", "<cmd>Octo pr list<CR>", desc = "List PRs (Octo)" },
      { "<leader>gP", "<cmd>Octo pr search<CR>", desc = "Search PRs (Octo)" },
      { "<leader>gr", "<cmd>Octo repo list<CR>", desc = "List Repos (Octo)" },
      { "<leader>gS", "<cmd>Octo search<CR>", desc = "Search (Octo)" },

      { "<localleader>a", "", desc = "+assignee (Octo)", ft = "octo" },
      { "<localleader>c", "", desc = "+comment/code (Octo)", ft = "octo" },
      { "<localleader>l", "", desc = "+label (Octo)", ft = "octo" },
      { "<localleader>i", "", desc = "+issue (Octo)", ft = "octo" },
      { "<localleader>r", "", desc = "+react (Octo)", ft = "octo" },
      { "<localleader>p", "", desc = "+pr (Octo)", ft = "octo" },
      { "<localleader>pr", "", desc = "+rebase (Octo)", ft = "octo" },
      { "<localleader>ps", "", desc = "+squash (Octo)", ft = "octo" },
      { "<localleader>v", "", desc = "+review (Octo)", ft = "octo" },
      { "<localleader>g", "", desc = "+goto_issue (Octo)", ft = "octo" },
      { "@", "@<C-x><C-o>", mode = "i", ft = "octo", silent = true },
      { "#", "#<C-x><C-o>", mode = "i", ft = "octo", silent = true },
    },
  },
  {
    "echasnovski/mini.diff",
    event = "VeryLazy",
    keys = {
      {
        "<leader>hi",
        function() require("mini.diff").toggle_overlay(0) end,
        desc = "Toggle mini.diff overlay",
      },
    },
    opts = function()
      local diff = require "mini.diff"
      Snacks.toggle({
        name = "Mini Diff Signs",
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
      }):map "<leader>uG"
      return {
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          apply = "<leader>hs",
          reset = "<leader>hr",
          textobject = "ih",
          goto_first = "[C",
          goto_prev = "[c",
          goto_next = "]c",
          goto_last = "]C",
        },
        view = {
          style = "sign",
          signs = {
            add = "▎",
            change = "▎",
            delete = "",
          },
        },
      }
    end,
    config = function(_, opts) require("mini.diff").setup(opts) end,
    specs = {
      {
        "f-person/git-blame.nvim",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
      },
      {
        "olimorris/codecompanion.nvim",
        optional = true,
        opts = {
          display = {
            diff = {
              provider = "mini_diff",
            },
          },
        },
      },
      {
        "Isrothy/neominimap.nvim",
        optional = true,
        opts = function()
          vim.g.neominimap = vim.tbl_deep_extend("force", vim.g.neominimap or {}, {
            git = {
              enabled = false,
            },
            mini_diff = {
              enabled = true,
            },
          })
        end,
      },
      {
        "echasnovski/mini.map",
        optional = true,
        opts = function(_, opts)
          opts.integrations = opts.integrations or {}
          local map = require "mini.map"
          table.insert(opts.integrations, map.gen_integration.diff())
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
                local summary = vim.b.minidiff_summary
                return summary
                  and {
                    added = summary.add,
                    modified = summary.change,
                    removed = summary.delete,
                  }
              end
              break
            end
          end
        end,
      },
    },
  },
}
