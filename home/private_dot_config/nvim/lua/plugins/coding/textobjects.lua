local function ai_buffer(ai_type)
  local start_line, end_line = 1, vim.fn.line "$"
  if ai_type == "i" then
    -- Skip first and last blank lines for `i` textobject
    local first_nonblank, last_nonblank = vim.fn.nextnonblank(start_line), vim.fn.prevnonblank(end_line)
    -- Do nothing for buffer with all blanks
    if first_nonblank == 0 or last_nonblank == 0 then return { from = { line = start_line, col = 1 } } end
    start_line, end_line = first_nonblank, last_nonblank
  end

  local to_col = math.max(vim.fn.getline(end_line):len(), 1)
  return { from = { line = start_line, col = 1 }, to = { line = end_line, col = to_col } }
end

--register all text objects with which-key
---@param opts table
local function ai_whichkey(opts)
  local objects = {
    { " ", desc = "whitespace" },
    { '"', desc = "double quotes" },
    { "'", desc = "quotes" },
    { "`", desc = "back quotes" },
    { "(", desc = "parentheses" },
    { ")", desc = "parentheses with ws" },
    { "<", desc = "angle brackets" },
    { ">", desc = "angle brackets with ws" },
    { "[", desc = "squarebrackets" },
    { "]", desc = "squarebrackets with ws" },
    { "{", desc = "curly brackets" },
    { "}", desc = "curly brackets with ws" },
    { "?", desc = "user prompt" },
    { "_", desc = "underscore" },
    { "|", desc = "vertical bars" },
    { "a", desc = "argument" },
    { "b", desc = "mini parentheses" },
    { "c", desc = "class" },
    { "e", desc = "entire file" },
    { "f", desc = "function" },
    { "g", desc = "comment" },
    { "i", desc = "indent" },
    { "n", desc = "number" },
    { "o", desc = "block, conditional, loop" },
    { "q", desc = "mini quotes" },
    { "r", desc = "squarebrackets" },
    { "t", desc = "tag" },
    { "u", desc = "subword" },
    { "A", desc = "argument(treesitter)" },
    { "F", desc = "function(treesitter)" },
  }

  ---@type wk.Spec[]
  local ret = { mode = { "o", "x" } }
  ---@type table<string, string>
  local mappings = vim.tbl_extend("force", {}, {
    around = "a",
    inside = "i",
    around_next = "an",
    inside_next = "in",
    around_last = "al",
    inside_last = "il",
  }, opts.mappings or {})
  mappings.goto_left = nil
  mappings.goto_right = nil

  for name, prefix in pairs(mappings) do
    name = name:gsub("^around_", ""):gsub("^inside_", "")
    ret[#ret + 1] = { prefix, group = name }
    for _, obj in ipairs(objects) do
      local desc = obj.desc
      if prefix:sub(1, 1) == "i" then desc = desc:gsub(" with ws", "") end
      ret[#ret + 1] = { prefix .. obj[1], desc = obj.desc }
    end
  end
  require("which-key").add(ret, { notify = false })
end

return {
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = function()
      local ai = require "mini.ai"
      return {
        mappings = {
          goto_left = "",
          goto_right = "",
        },
        n_lines = 500,
        custom_textobjects = {
          ["|"] = ai.gen_spec.pair("|", "|", { type = "non-balanced" }),
          c = ai.gen_spec.treesitter { a = "@class.outer", i = "@class.inner" }, -- class
          e = ai_buffer, -- buffer
          f = ai.gen_spec.treesitter { a = "@function.outer", i = "@function.inner" }, -- function
          g = ai.gen_spec.treesitter { a = "@comment.outer", i = "@comment.inner" }, -- comment
          n = { "%f[%d]%d+" }, -- number
          o = ai.gen_spec.treesitter { -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          },
          r = { "%b[]", "^.%s*().-()%s*.$" },
          -- t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          u = { -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },

          A = ai.gen_spec.treesitter { a = "@parameter.outer", i = "@parameter.inner" }, --arguments
          F = ai.gen_spec.function_call(), -- function
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
      ViM.on_load("which-key.nvim", function()
        vim.schedule(function() ai_whichkey(opts) end)
      end)
    end,
    keys = function()
      local ai = require "mini.ai"
      local move_mode = { "n", "x", "o" }
      local next_opts = { search_method = "next" }
      local prev_opts = { search_method = "prev" }
      local cov_prev_opts = { search_method = "cover_or_prev" }
      local move_mappings = {
        { "]m", function() ai.move_cursor("left", "a", "f", next_opts) end, desc = "Next Function" },
        { "[m", function() ai.move_cursor("left", "a", "f", prev_opts) end, desc = "Previous Function" },
        { "]M", function() ai.move_cursor("right", "a", "f", next_opts) end, desc = "Next Function End" },
        { "[M", function() ai.move_cursor("right", "a", "f", prev_opts) end, desc = "Previous Function End" },
        { "]]", function() ai.move_cursor("left", "a", "c", next_opts) end, desc = "Next Class" },
        { "[[", function() ai.move_cursor("left", "a", "c", prev_opts) end, desc = "Previous Class" },
        { "][", function() ai.move_cursor("right", "a", "c", next_opts) end, desc = "Next Class End" },
        { "[]", function() ai.move_cursor("right", "a", "c", prev_opts) end, desc = "Previous Class End" },
        { "]/", function() ai.move_cursor("right", "a", "g") end, desc = "Next Comment" },
        { "[/", function() ai.move_cursor("left", "a", "g", cov_prev_opts) end, desc = "Previous Comment" },
        { "]*", function() ai.move_cursor("right", "a", "g") end, desc = "Next Comment" },
        { "[*", function() ai.move_cursor("left", "a", "g", cov_prev_opts) end, desc = "Previous Comment" },
      }
      for _, move_mapping in ipairs(move_mappings) do
        move_mapping.mode = move_mapping.mode or move_mode
      end
      return move_mappings
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    opts = {
      -- move = {
      --   set_jumps = true,
      -- },
    },
  },
}
