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
    { "A", desc = "argument(treesitter)" },
    { "b", desc = "mini parentheses" },
    { "c", desc = "class" },
    { "e", desc = "entire file" },
    { "f", desc = "function" },
    { "F", desc = "function(treesitter)" },
    { "g", desc = "comment" },
    { "i", desc = "indent" },
    { "N", desc = "number" },
    { "o", desc = "block, conditional, loop" },
    { "q", desc = "mini quotes" },
    { "r", desc = "squarebrackets" },
    { "t", desc = "tag" },
    { "u", desc = "subword" },
  }

  ---@type wk.Spec[]
  local ret = { mode = { "o", "x" } }
  ---@type table<string, string>
  local mappings = vim.tbl_extend("force", {}, opts.mappings or {})
  mappings.goto_left = nil
  mappings.goto_right = nil

  for name, prefix in pairs(mappings) do
    name = name:gsub("^around_", ""):gsub("^inside_", "")
    if prefix ~= "" then
      ret[#ret + 1] = { prefix, group = name }
      for _, obj in ipairs(objects) do
        local desc = obj.desc
        if prefix:sub(1, 1) == "i" then desc = desc:gsub(" with ws", "") end
        ret[#ret + 1] = { prefix .. obj[1], desc = obj.desc }
      end
    end
  end
  require("which-key").add(ret, { notify = false })
end

return {
  {
    "echasnovski/mini.ai",
    dependencies = {
      { "echasnovski/mini.extra", opts = {} },
    },
    event = "VeryLazy",
    opts = function()
      local ai = require "mini.ai"
      local gen_ai_spec = require("mini.extra").gen_ai_spec
      return {
        mappings = {
          around = "a",
          inside = "i",
          around_next = "",
          inside_next = "",
          around_last = "",
          inside_last = "",

          goto_left = "",
          goto_right = "",
        },
        n_lines = 500,
        custom_textobjects = {
          ["|"] = ai.gen_spec.pair("|", "|", { type = "non-balanced" }),
          A = ai.gen_spec.treesitter { a = "@parameter.outer", i = "@parameter.inner" }, --arguments
          c = ai.gen_spec.treesitter { a = "@class.outer", i = "@class.inner" }, -- class
          e = gen_ai_spec.buffer(), -- buffer
          f = ai.gen_spec.treesitter { a = "@function.outer", i = "@function.inner" }, -- function
          F = ai.gen_spec.function_call(), -- function
          g = ai.gen_spec.treesitter { a = "@comment.outer", i = "@comment.inner" }, -- comment
          N = gen_ai_spec.number(),
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
