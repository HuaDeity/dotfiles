if vim.env.PROF then
  local snacks = vim.fn.stdpath "data" .. "/site/pack/core/opt/snacks.nvim"
  vim.opt.rtp:append(snacks)
  require("snacks.profiler").startup {
    startup = {
      event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
      -- event = "UIEnter",
      -- event = "VeryLazy",
    },
  }
end

vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("TreesitterUpdate", { clear = true }),
  callback = function(args)
    if args.data.kind == "update" and args.data.spec.name == "nvim-treesitter" then vim.cmd "TSUpdate" end
  end,
  desc = "Treesitter: update parser automatically",
})
