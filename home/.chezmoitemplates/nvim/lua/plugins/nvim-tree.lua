return {
  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      { "<leader>e", ":NvimTreeToggle<CR>", { silent = true } },
    },
    opts = {
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      renderer = {
        group_empty = true,
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
      },
      filters = {
        dotfiles = true,
      },
    },
  },
}
