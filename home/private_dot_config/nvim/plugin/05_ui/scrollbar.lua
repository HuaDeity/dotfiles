vim.pack.add({
  "https://github.com/nvim-mini/mini.map",
})

local map = require "mini.map"
map.setup {
  integrations = {
    map.gen_integration.builtin_search(),
    map.gen_integration.diff(),
    map.gen_integration.diagnostic(),
  },
  symbols = {
    encode = map.gen_encode_symbols.dot "3x2",
  },
  window = {
    focusable = true,
    show_integration_count = false,
  },
}

vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("MapAutoOpen", { clear = true }),
  callback = function()
    if vim.tbl_contains(vim.g.minimap_excluded_filetypes, vim.bo.filetype) then
      vim.g.minimap_disable = true
      map.close()
    else
      vim.g.minimap_disable = false
      map.open()
    end
  end,
  desc = "MiniMap: Auto open on VimEnter",
})
