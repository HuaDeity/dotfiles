vim.pack.add { "https://github.com/luukvbaal/statuscol.nvim" }

require("statuscol").setup {
  relculright = true,
  clickhandlers = {
    MiniDiffViz = function(args)
      if args.button == "l" then
        require("mini.diff").toggle_overlay(0)
        -- elseif args.button == "m" then
        --   require("mini.diff").textobject()
        --   vim.schedule(vim.cmd ":'<,'>lua require('mini.diff').do_hunks(0, 'reset')")
        -- elseif args.button == "r" then
        --   require("mini.diff").textobject()
        --   vim.schedule(vim.cmd ":'<,'>lua require('mini.diff').do_hunks(0, 'apply')")
      end
    end,
  },
}

Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map "<leader>uL"
Snacks.toggle.line_number():map "<leader>ul"
