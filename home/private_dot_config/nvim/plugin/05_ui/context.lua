vim.pack.add { "https://github.com/nvim-treesitter/nvim-treesitter-context" }

local tsc = require "treesitter-context"
Snacks.toggle({
  name = "Treesitter Context",
  get = tsc.enabled,
  set = function(state)
    if state then
      tsc.enable()
    else
      tsc.disable()
    end
  end,
}):map "<leader>ut"
return { max_lines = 3 }
