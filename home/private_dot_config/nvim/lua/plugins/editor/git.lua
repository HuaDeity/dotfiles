-- if ViM.get_plugin "neogit" then
--   require("neogit").open()
-- elseif vim.fn.executable "gitui" == 1 then
--   local colorscheme = vim.g.colors_name
--   Snacks.terminal { "gitui", "-t", colorscheme .. ".ron" }
-- elseif vim.fn.executable "lazygit" == 1 then
--   Snacks.lazygit()
-- end
return {
  {
    "folke/snacks.nvim",
    keys = function(_, keys)
      local mappings = {
        { "<leader>gy", function() Snacks.gitbrowse() end, desc = "Git Browse (open)", mode = { "n", "x" } },
        {
          "<leader>gY",
          function()
            Snacks.gitbrowse { open = function(url) vim.fn.setreg("+", url) end, notify = false }
          end,
          desc = "Git Browse (copy)",
          mode = { "n", "x" },
        },
        {
          "<leader>gg",
          function()
            require("neogit").open()
            -- Snacks.lazygit()
          end,
          desc = "Git Panel",
        },
      }
      mappings = vim.tbl_filter(function(m) return m[1] and #m[1] > 0 end, mappings)
      return vim.list_extend(mappings, keys)
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
    opts = {
      mappings = {
        apply = "<leader>hs",
        reset = "<leader>hr",
        textobject = "ih",
        goto_first = "[C",
        goto_prev = "[c",
        goto_next = "]c",
        goto_last = "]C",
      },
    },
    specs = {
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
    },
  },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    opts = {
      disable_signs = true,
      graph_style = "kitty",
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen" },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = { winbar_info = true },
        file_history = { winbar_info = true },
      },
      hooks = { diff_buf_read = function(bufnr) vim.b[bufnr].view_activated = false end },
    },
    specs = {
      {
        "NeogitOrg/neogit",
        optional = true,
        opts = { integrations = { diffview = true } },
      },
    },
  },
  {
    "echasnovski/mini-git",
    cmd = "Git",
    opts = {},
    config = function(_, opts)
      require("mini.git").setup(opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "git", "diff" },
        callback = function() vim.wo.foldexpr = "v:lua.MiniGit.diff_foldexpr()" end,
        desc = "Setup git folding with mini.git",
      })
    end,
  },
}
