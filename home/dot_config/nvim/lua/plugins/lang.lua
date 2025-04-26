return {
  {
    "linux-cultist/venv-selector.nvim",
    enabled = function()
      return LazyVim.has_extra("lang.python")
    end,
  },
}
