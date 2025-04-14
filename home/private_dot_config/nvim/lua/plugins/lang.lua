return {
  { import = "lazyvim.plugins.extras.lang.git" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
  { import = "lazyvim.plugins.extras.lang.toml" },
  {
    "linux-cultist/venv-selector.nvim",
    enabled = function()
      return LazyVim.has_extra("lang.python")
    end,
  },
}
