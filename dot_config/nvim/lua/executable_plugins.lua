-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

-- stylua: ignore start
require('packer').startup({function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  -- Git related plugins
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'TimUntersberger/neogit', requires = {'nvim-lua/plenary.nvim'} }

  -- Comment
  -- "gc" to comment visual regions/lines
  use 'numToStr/Comment.nvim'
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }
  use { --  Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects', 
    after = 'nvim-treesitter',
  }
  use 'p00f/nvim-ts-rainbow'

  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim 
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim', 
      
      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim', 
    }
  }
  use 'WhoIsSethDaniel/mason-tool-installer.nvim'
  -- For formatters and linters
  use 'jose-elias-alvarez/null-ls.nvim'
  use {'zbirenbaum/copilot.lua', event = {"VimEnter"}}

  use { --  Autocompletion
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip',  'saadparwaiz1/cmp_luasnip' },
  }
  use {'zbirenbaum/copilot-cmp', module = "copilot_cmp"}
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lua'
  use 'onsails/lspkind.nvim'

  -- Snippet
  -- Snippet Engine and Snippet Expansion
  use 'rafamadriz/friendly-snippets'

  -- Colerschemes
  -- Theme inspired by Atom
  use {'catppuccin/nvim', as = 'catppuccin'}
  use 'f-person/auto-dark-mode.nvim'

  -- Statusline
  -- Fancier statusline
  use {'nvim-lualine/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true}}

  -- Indent
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'

  -- Telescope
  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }
  use 'nvim-telescope/telescope-file-browser.nvim'
  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable "make" == 1 }
  use 'stevearc/dressing.nvim'

  -- Dashboard
  use 'glepnir/dashboard-nvim'

  -- Nvim-tree
  use {'kyazdani42/nvim-tree.lua', requires = {'kyazdani42/nvim-web-devicons'}}

  -- Bufferline
  use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}

  -- Autopairs
  use 'windwp/nvim-autopairs'

  -- Terminal
  use 'akinsho/toggleterm.nvim'

  -- Project
  use 'ahmedkhalf/project.nvim'
  
  -- Impatient
  use 'lewis6991/impatient.nvim'
  
  -- Debug
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  
  -- Whichkey
  use 'folke/which-key.nvim'

  -- Easymotion
  use 'phaazon/hop.nvim'

  -- Trouble
  use 'folke/trouble.nvim'

  -- Session
  use 'shatur/neovim-session-manager'
  
  -- Detect tabstop and shiftwidth Automatically
  use { 'nmac427/guess-indent.nvim', config = function() require('guess-indent').setup {} end,}

  if is_bootstrap then
    require('packer').sync()
  end
end,

config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'rounded'})
      end
    }
  }
})
-- stylua: ignore end

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return false
end

-- Automatically source and re-compile packer whenever you save this plugins.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
