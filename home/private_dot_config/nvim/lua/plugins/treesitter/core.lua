return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    opts_extend = { "ensure_installed", "disabled_filetypes" },
    lazy = false,
    cmd = { "TSUpdate", "TSInstall" },
    opts = {
      ensure_installed = { "printf", "query", "regex", "ssh_config", "vim", "vimdoc" },
      disabled_filetypes = { "conf", "lazy", "properties", "template", "zsh" },
    },
    ---@param opts TSConfig | {ensure_installed: string[], disabled_filetypes: string[]}
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)
      -- install
      -- if type(opts.ensure_installed) == "table" then opts.ensure_installed = ViM.dedup(opts.ensure_installed) end
      -- local done = nil
      -- require("nvim-treesitter").install(opts.ensure_installed, {}, function(success) done = success end)
      -- vim.wait(3000000, function() return done ~= nil end)

      require("nvim-treesitter").install(opts.ensure_installed)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("ViM_treesitter_highlight", { clear = true }),
        pattern = { "*" },
        callback = function()
          local ft = vim.fn.expand "<amatch>"
          local is_disabled = false
          for _, pattern in ipairs(opts.disabled_filetypes) do
            if string.find(ft, pattern) then
              is_disabled = true
              break
            end
          end
          if not is_disabled then vim.treesitter.start() end
        end,
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
