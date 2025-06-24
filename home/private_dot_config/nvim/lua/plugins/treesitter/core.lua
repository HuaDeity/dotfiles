return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    opts_extend = { "ensure_installed", "disabled_filetypes" },
    lazy = false,
    cmd = { "TSUpdate", "TSInstall" },
    opts = {
      ensure_installed = { "dotenv", "log", "printf", "regex", "ssh_config" },
      disabled_filetypes = {},
    },
    ---@param opts TSConfig | {ensure_installed: string[], disabled_filetypes: string[]}
    config = function(_, opts)
      require("nvim-treesitter").install(opts.ensure_installed)

      -- highlight
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local ft = vim.fn.expand "<amatch>"
          local is_disabled = false
          for _, pattern in ipairs(opts.disabled_filetypes) do
            if string.find(ft, pattern) then
              is_disabled = true
              break
            end
          end
          if not is_disabled then pcall(vim.treesitter.start) end
        end,
      })
    end,
  },
}
