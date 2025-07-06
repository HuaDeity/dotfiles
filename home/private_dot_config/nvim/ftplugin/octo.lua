-- treesitter
vim.treesitter.language.register("markdown", "octo")

vim.keymap.set("i", "@", "@<C-x><C-o>", { silent = true, buffer = true })
vim.keymap.set("i", "#", "#<C-x><C-o>", { silent = true, buffer = true })

require("which-key").add {
  {
    { "<localleader>a", desc = "+assignee (Octo)", buffer = true },
    { "<localleader>c", desc = "+comment/code (Octo)", buffer = true },
    { "<localleader>l", desc = "+label (Octo)", buffer = true },
    { "<localleader>i", desc = "+issue (Octo)", buffer = true },
    { "<localleader>r", desc = "+react (Octo)", buffer = true },
    { "<localleader>p", desc = "+pr (Octo)", buffer = true },
    { "<localleader>pr", desc = "+rebase (Octo)", buffer = true },
    { "<localleader>ps", desc = "+squash (Octo)", buffer = true },
    { "<localleader>v", desc = "+review (Octo)", buffer = true },
    { "<localleader>g", desc = "+goto_issue (Octo)", buffer = true },
  },
  { notify = false },
}
