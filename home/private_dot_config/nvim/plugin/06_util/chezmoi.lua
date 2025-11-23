vim.pack.add({
  "https://github.com/xvzc/chezmoi.nvim",
})

require("chezmoi").setup {
  extra_args = {
    "--no-tty",
  },
  edit = {
    watch = false,
    force = false,
  },
  events = {
    on_open = {
      notification = {
        enable = false,
      },
    },
    on_watch = {
      notification = {
        enable = true,
      },
    },
    on_apply = {
      notification = {
        enable = true,
      },
    },
  },
}

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { os.getenv "HOME" .. "/.local/share/chezmoi/*" },
  callback = function() vim.schedule(require("chezmoi.commands.__edit").watch) end,
})
