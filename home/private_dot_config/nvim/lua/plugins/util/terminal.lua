-- Terminal Mappings
local function term_nav(dir)
  ---@param self snacks.terminal
  return function(self)
    return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function() vim.cmd.wincmd(dir) end)
  end
end

return {
  {
    "folke/snacks.nvim",
    opts = {
      terminal = {
        win = {
          keys = {
            nav_h = { "<C-h>", term_nav "h", desc = "Go to Left Window", expr = true, mode = "t" },
            nav_j = { "<C-j>", term_nav "j", desc = "Go to Lower Window", expr = true, mode = "t" },
            nav_k = { "<C-k>", term_nav "k", desc = "Go to Upper Window", expr = true, mode = "t" },
            nav_l = { "<C-l>", term_nav "l", desc = "Go to Right Window", expr = true, mode = "t" },
          },
        },
      },
    },
    keys = {
      { "<leader>fT", function() Snacks.terminal() end, desc = "Terminal" },
      { "<C-`>", function() Snacks.terminal() end, desc = "Terminal" },
      { "<C-S-`>", function() Snacks.terminal.open() end, desc = "New Terminal" },
    },
  },
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      for _, pos in ipairs { "top", "bottom", "left", "right" } do
        opts[pos] = opts[pos] or {}
        table.insert(opts[pos], {
          ft = "snacks_terminal",
          size = { height = 0.4 },
          title = "%{b:snacks_terminal.id}: %{b:term_title}",
          filter = function(_buf, win)
            return vim.w[win].snacks_win
              and vim.w[win].snacks_win.position == pos
              and vim.w[win].snacks_win.relative == "editor"
              and not vim.w[win].trouble_preview
          end,
        })
      end
    end,
  },
}
