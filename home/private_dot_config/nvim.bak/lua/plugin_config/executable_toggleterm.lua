require('toggleterm').setup {
	insert_mappings = true,
	direction = "float",
	float_opts = {
		border = "curved",
	},
}



local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new { cmd = "lazygit", hidden = true }

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end