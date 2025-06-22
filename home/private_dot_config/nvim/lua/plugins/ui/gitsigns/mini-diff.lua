return {
  {
    "echasnovski/mini.diff",
    keys = {
      -- stylua: ignore start
      { "<D-F8>", "<Cmd>lua MiniDiff.goto_hunk('next')<CR>", mode = { "n", "x" }, desc = "Next hunk" },
      { "<D-F8>", "V<Cmd>lua MiniDiff.goto_hunk('next')<CR>", mode = "o", desc = "Next hunk" },
      { "<D-S-F8>", "<Cmd>lua MiniDiff.goto_hunk('prev')<CR>", mode = { "n", "x" }, desc = "Prev hunk" },
      { "<D-S-F8>", "V<Cmd>lua MiniDiff.goto_hunk('prev')<CR>", mode = "o", desc = "Prev hunk" },

      { "do", function() require("mini.diff").toggle_overlay(0) end, desc = "Preview hunk" },
      { "<D-'>", function() require("mini.diff").toggle_overlay(0) end, desc = "Preview hunk" },

      { "<D-y>", function() return require("mini.diff").operator "apply" end, mode = { "n", "x" }, expr=true, desc = "Apply hunks" },
      { "<D-Y>", function() return require("mini.diff").operator "reset" end, mode = { "n", "x" }, expr=true, desc = "Reset hunks" },
      -- stylua: ignore end
    },
    opts = {
      -- Module mappings. Use `''` (empty string) to disable one.
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
          add = ViM.config.icons.git.add,
          delete = ViM.config.icons.git.delete,
        },
      },
    },
    specs = {
      {
        "f-person/git-blame.nvim",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        -- specs = {
        --   {
        --     "nvim-lualine/lualine.nvim",
        --     optional = true,
        --     opts = function(_, opts)
        --       local git_blame = require "gitblame"
        --       table.insert(
        --         opts.sections.lualine_b,
        --         { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available }
        --       )
        --     end,
        --   },
        -- },
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
        config = function() end,
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
  {
    "echasnovski/mini.diff",
    opts = function()
      Snacks.toggle({
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
      }):map "<leader>uG"
    end,
  },
}
