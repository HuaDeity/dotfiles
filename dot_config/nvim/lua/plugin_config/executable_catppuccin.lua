require('catppuccin').setup{
  background = { -- :h background
      light = "latte",
      dark = "mocha",
  },
  transparent_background = false,
  term_colors = false,
  integration = {
    treesitter = true,
    native_lsp = {
		  enabled = true,
		  virtual_text = {
			  errors = "italic",
			  hints = "italic",
			  warnings = "italic",
			  information = "italic",
		  },
		  underlines = {
			  errors = "underline",
			  hints = "underline",
			  warnings = "underline",
			  information = "underline",
		  },
	  },
    nvimtree = {
      enabled = true,
      show_root = true, -- makes the root folder not transparent
	    transparent_panel = false, -- make the panel transparent
    },
    lsp_trouble = true,
    cmp = true,
    gitsigns = true,
    telescope = true,
    which_key = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = true,
    },
    dashboard = true,
    bufferline = true,
    ts_rainbow = true,
    hop = true,
  }
}

