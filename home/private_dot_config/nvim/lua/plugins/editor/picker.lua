return {
  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require "grug-far"
          local ext = vim.bo.buftype == "" and vim.fn.expand "%:e"
          grug.open {
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          }
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
          },
        },
      },
    },
    keys = {
      {
        "g/",
        function() Snacks.picker.grep { cmd = ViM.root() } end,
        desc = "Grep (Root Dir)",
      },
      -- find
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>fB", function() Snacks.picker.buffers { hidden = true, nofile = true } end, desc = "Buffers (all)" },
      { "<leader>fc", function() Snacks.picker.files { cwd = vim.fn.stdpath "config" } end, desc = "Find Config File" },
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files (Root Dir)" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
      { "<leader>fR", function() Snacks.picker.recent { filter = { cwd = true } } end, desc = "Recent (cwd)" },
      -- Grep
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
      { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      {
        "<leader>sg",
        function() Snacks.picker.grep { cmd = ViM.root() } end,
        desc = "Grep (Root Dir)",
      },
      {
        "<leader>sG",
        function() Snacks.picker.grep() end,
        desc = "Grep (cwd)",
      },
      { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
      { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
      -- { "<leader>ss", function() Snacks.picker.pickers() end, desc = "Search Select Snacks" },
      {
        "<leader>sw",
        function() Snacks.picker.grep_word() end,
        desc = "Visual selection or word (Root Dir)",
        mode = { "n", "x" },
      },
      -- ui
      { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local Keys = require("plugins.lsp.attach").get()
      -- stylua: ignore
      vim.list_extend(Keys, {
        { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition", has = "definition" },
        { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration", has = "declaration" },
        { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition", has = "typeDefinition" },
        { "grr", function() Snacks.picker.lsp_references() end, desc = "References", nowait = true, has = "references" },
        { "gri", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation", has = "implementation" },
        { "gO", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols", has = "documentSymbol" },
        { "gS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols", has = "workspace/symbols" },

        { "<leader>cl", function() Snacks.picker.lsp_config() end, desc = "Lsp Info" },
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    optional = true,
    -- stylua: ignore
    keys = {
      { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
      { "<leader>sT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
    },
  },
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      local icons = require "mini.icons"
      table.insert(opts.dashboard.preset.keys, 3, {
        icon = icons.get("directory", "Projects"),
        key = "p",
        desc = "Projects",
        action = ":lua Snacks.picker.projects()",
      })
    end,
  },
  {
    "folke/flash.nvim",
    optional = true,
    specs = {
      {
        "folke/snacks.nvim",
        opts = {
          picker = {
            win = {
              input = {
                keys = {
                  ["<a-s>"] = { "flash", mode = { "n", "i" } },
                  ["s"] = { "flash" },
                },
              },
            },
            actions = {
              flash = function(picker)
                require("flash").jump {
                  pattern = "^",
                  label = { after = { 0, 0 } },
                  search = {
                    mode = "search",
                    exclude = {
                      function(win) return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list" end,
                    },
                  },
                  action = function(match)
                    local idx = picker.list:row2idx(match.pos[1])
                    picker.list:_move(idx, true, true)
                  end,
                }
              end,
            },
          },
        },
      },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "ravitemer/codecompanion-history.nvim",
    },
    optional = true,
    opts = {
      extensions = {
        history = {
          opts = {
            picker = "snacks",
          },
        },
      },
    },
  },
}
