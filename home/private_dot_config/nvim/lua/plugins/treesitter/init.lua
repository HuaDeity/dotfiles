return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    cmd = { "TSUpdate", "TSInstall" },
    config = function(_, opts)
      -- install
      if type(opts.ensure_installed) == "table" then opts.ensure_installed = ViM.dedup(opts.ensure_installed) end
      local done = nil
      require("nvim-treesitter").install(opts.ensure_installed, {}, function(success) done = success end)
      vim.wait(3000000, function() return done ~= nil end)

      -- highlighting
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "<filetype>" },
        callback = function() vim.treesitter.start() end,
      })

      -- folds
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

      -- indentation
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  },
}
