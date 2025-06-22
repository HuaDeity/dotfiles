return {
  { import = "plugins.ui.gitsigns.gitsigns" },
  -- { import = "plugins.ui.gitsigns.mini-diff" },
  {
    "folke/snacks.nvim",
    opts = {
      statuscolumn = { enabled = false },
    },
  },
  {
    "luukvbaal/statuscol.nvim",
    lazy = false,
    opts_extend = { "ft_ignore" },
    opts = {
      relculright = true,
      clickhandlers = {
        MiniDiffViz = function(args)
          if args.button == "l" then
            require("mini.diff").toggle_overlay(0)
          elseif args.button == "m" then
            require("mini.diff").operator "reset"
          elseif args.button == "r" then
            require("mini.diff").operator "apply"
          end
        end,
      },
    },
  },
}
