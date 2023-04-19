return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = "catppuccin",
    opts = {
      highlights = require("catppuccin.groups.integrations.bufferline").get(),
      options = {
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },
}
