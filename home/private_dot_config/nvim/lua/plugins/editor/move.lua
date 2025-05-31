return {
  {
    "echasnovski/mini.move",
    opts = {
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = "<S-h>",
        right = "<S-l>",
        down = "<S-j>",
        up = "<S-k>",

        -- Move current line in Normal mode
        line_left = "<S-h>",
        line_right = "<S-l>",
        line_down = "<S-j>",
        line_up = "<S-k>",
      },
    },
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local opts = ViM.opts "mini.move"
      local mappings = {
        { opts.mappings.line_left, desc = "Move line left" },
        { opts.mappings.line_right, desc = "Move line right" },
        { opts.mappings.line_down, desc = "Move line down" },
        { opts.mappings.line_up, desc = "Move line up" },
        { opts.mappings.left, desc = "Move left", mode = "x" },
        { opts.mappings.right, desc = "Move right", mode = "x" },
        { opts.mappings.down, desc = "Move down", mode = "x" },
        { opts.mappings.up, desc = "Move up", mode = "x" },
      }
      mappings = vim.tbl_filter(function(m) return m[1] and #m[1] > 0 end, mappings)
      return vim.list_extend(mappings, keys)
    end,
  },
}
