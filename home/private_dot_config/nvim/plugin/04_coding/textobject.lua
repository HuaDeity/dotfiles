vim.pack.add {
  "https://github.com/echasnovski/mini.ai",
  "https://github.com/echasnovski/mini.extra",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
}

require("mini.extra").setup()
local ai = require "mini.ai"
local gen_ai_spec = require("mini.extra").gen_ai_spec
local ai_mappings = {
  around = "a",
  inside = "i",
  around_next = "",
  inside_next = "",
  around_last = "",
  inside_last = "",

  goto_left = "",
  goto_right = "",
}

require("mini.ai").setup {
  mappings = ai_mappings,
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
local mappings = vim.tbl_extend("force", {}, ai_mappings or {})
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

local move_mode = { "n", "x", "o" }
local next_opts = { search_method = "next" }
local prev_opts = { search_method = "prev" }
local cov_prev_opts = { search_method = "cover_or_prev" }

-- stylua: ignore start
vim.keymap.set(move_mode, "]m", function() ai.move_cursor("left", "a", "f", next_opts) end, { desc = "Next Function" })
vim.keymap.set(move_mode, "[m", function() ai.move_cursor("left", "a", "f", prev_opts) end, { desc = "Prev Function" })
vim.keymap.set(move_mode, "]M", function() ai.move_cursor("right", "a", "f", next_opts) end, { desc = "Next Function End" })
vim.keymap.set(move_mode, "[M", function() ai.move_cursor("right", "a", "f", prev_opts) end, { desc = "Prev Function End" })
vim.keymap.set(move_mode, "]]", function() ai.move_cursor("left", "a", "c", next_opts) end, { desc = "Next Class" })
vim.keymap.set(move_mode, "[[", function() ai.move_cursor("left", "a", "c", prev_opts) end, { desc = "Prev Class" })
vim.keymap.set(move_mode, "][", function() ai.move_cursor("right", "a", "c", next_opts) end, { desc = "Next Class End" })
vim.keymap.set(move_mode, "[]", function() ai.move_cursor("right", "a", "c", prev_opts) end, { desc = "Prev Class End" })
vim.keymap.set(move_mode, "]/", function() ai.move_cursor("right", "a", "g") end, { desc = "Next Comment" })
vim.keymap.set(move_mode, "[/", function() ai.move_cursor("left", "a", "g", cov_prev_opts) end, { desc = "Prev Comment" })
vim.keymap.set(move_mode, "]*", function() ai.move_cursor("right", "a", "g") end, { desc = "Next Comment" })
vim.keymap.set(move_mode, "[*", function() ai.move_cursor("left", "a", "g", cov_prev_opts) end, { desc = "Prev Comment" })
-- stylua: ignore end
