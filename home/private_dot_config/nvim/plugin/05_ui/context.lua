local tsc = require "treesitter-context"
require("snacks")
  .toggle({
    name = "Treesitter Context",
    get = tsc.enabled,
    set = function(state)
      if state then
        tsc.enable()
      else
        tsc.disable()
      end
    end,
  })
  :map "<leader>ut"
return { max_lines = 3 }
