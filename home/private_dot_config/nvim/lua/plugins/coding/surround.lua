return {
  {
    "echasnovski/mini.surround",
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local opts = ViM.opts "mini.surround"
      local mappings = {
        { opts.mappings.add, desc = "Add Surrounding", mode = { "n" } },
        { opts.mappings.delete, desc = "Delete Surrounding" },
        { opts.mappings.find, desc = "Find Right Surrounding" },
        { opts.mappings.find_left, desc = "Find Left Surrounding" },
        { opts.mappings.highlight, desc = "Highlight Surrounding" },
        { opts.mappings.replace, desc = "Replace Surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
        {
          "S",
          [[:<C-u>lua MiniSurround.add('visual')<CR>]],
          desc = "Add Surrounding",
          mode = { "x" },
          { silent = true },
        },
        { "yss", desc = "Add Surrounding(Line)" },
      }
      mappings = vim.tbl_filter(function(m) return m[1] and #m[1] > 0 end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = function()
      local surround = require "mini.surround"
      return {
        custom_surroundings = {
          -- Use tree-sitter to search for function call
          f = {
            input = surround.gen_spec.input.treesitter { outer = "@call.outer", inner = "@call.inner" },
          },
        },
        mappings = {
          add = "ys", -- Add surrounding in Normal and Visual modes
          delete = "ds", -- Delete surrounding
          find = "", -- Find surrounding (to the right)
          find_left = "", -- Find surrounding (to the left)
          highlight = "", -- Highlight surrounding
          replace = "cs", -- Replace surrounding
          update_n_lines = "", -- Update `n_lines`

          -- Add this only if you don't want to use extended mappings
          -- suffix_last = "",
          -- suffix_next = "",
        },
        search_method = "cover_or_next",
      }
    end,
    config = function(_, opts)
      require("mini.surround").setup(opts)
      -- Remap adding surrounding to Visual mode selection
      vim.keymap.del("x", "ys")
      -- Make special mapping for "add surrounding for line"
      vim.keymap.set("n", "yss", "ys_", { remap = true })
    end,
  },
}
