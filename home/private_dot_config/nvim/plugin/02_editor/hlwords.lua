vim.pack.add({
  "https://github.com/RRethy/vim-illuminate",
})

require("illuminate").configure {
  providers = {
    "lsp",
    "treesitter",
  },
  delay = 75,
  -- large_file_cutoff = 2000,
  -- large_file_overrides = {
  --   providers = { "lsp" },
  -- },
}
require("snacks")
  .toggle({
    name = "Illuminate",
    get = function() return not require("illuminate.engine").is_paused() end,
    set = function(enabled)
      local m = require "illuminate"
      if enabled then
        m.resume()
      else
        m.pause()
      end
    end,
  })
  :map "<leader>ux"
