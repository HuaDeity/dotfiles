if not require 'plugins' then
  return
end

if vim.g.vscode then
else 
  require 'options'
  require 'globals'
  require 'keymaps'
  require 'autocommands'
  require 'colorscheme'
  require 'plugin_config.lualine'
  require 'plugin_config.comment'
  require 'plugin_config.indentline'
  require 'plugin_config.gitsigns'
  require 'plugin_config.telescope'
  require 'plugin_config.treesitter'
  require 'plugin_config.lsp'
  require 'plugin_config.cmp'
  require 'plugin_config.copilot'
  require 'plugin_config.dashboard'
  require 'plugin_config.nvim-tree'
  require 'plugin_config.bufferline'
  require 'plugin_config.autopairs'
  require 'plugin_config.toggleterm'
  require 'plugin_config.project'
  require 'plugin_config.impatient'
  require 'plugin_config.dap'
  require 'plugin_config.whichkey'
  require 'plugin_config.hop'
  require 'plugin_config.trouble'
  require 'plugin_config.dressing'
end

require 'plugin_config.session'

