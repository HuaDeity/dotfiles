return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    opts_extend = { "ensure_installed" },
    lazy = false,
    cmd = { "TSUpdate", "TSInstall" },
    opts = {},
    ---@param opts TSConfig | {ensure_installed: string[]}
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)
      -- install
      if type(opts.ensure_installed) == "table" then opts.ensure_installed = ViM.dedup(opts.ensure_installed) end
      local done = nil
      require("nvim-treesitter").install(opts.ensure_installed, {}, function(success) done = success end)
      vim.wait(3000000, function() return done ~= nil end)

      -- highlighting
      vim.api.nvim_create_autocmd("FileType", {
        pattern = opts.ensure_installed,
        callback = function() vim.treesitter.start() end,
      })

      -- fold
      vim.wo.foldexpr = "v:lua.require'util'.ui.foldexpr()"
      vim.o.foldmethod = "expr"
      vim.o.foldtext = ""
      vim.o.foldlevel = 99

      -- indentation
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  },
}
