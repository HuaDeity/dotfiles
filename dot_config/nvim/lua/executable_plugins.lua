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

  -- Basic lua function
  use 'nvim-lua/plenary.nvim'

  -- Git related plugins
  use 'lewis6991/gitsigns.nvim'
  use 'TimUntersberger/neogit'

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
  use 'nvim-treesitter/nvim-treesitter-context'

  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim 
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'jay-babu/mason-null-ls.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim', 
      
      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim', 

      -- Automatically highlighting the word under the cursor
      'RRethy/vim-illuminate',

      -- For formatters and linters
      'jose-elias-alvarez/null-ls.nvim',
    }
  }

  -- Github Copilot
  use {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "VimEnter",
    config = function()
      vim.defer_fn(function()
        require("copilot").setup{
          suggestion = { enabled = false },
          panel = { enabled = false },
      }
      end, 100)
    end,
  }
  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end
  }
  
  use { --  Autocompletion
    'hrsh7th/nvim-cmp',
    requires = {
      -- Sources
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      -- Snip Sources
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      -- Other Sources
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      -- Formating
      'onsails/lspkind.nvim'
    },
  }

  -- Snippet
  -- Snippet Engine and Snippet Expansion
  use 'rafamadriz/friendly-snippets'

  -- Colerschemes
  -- Theme inspired by Atom
  use {'catppuccin/nvim', as = 'catppuccin', requires= {'f-person/auto-dark-mode.nvim'}}

  -- Statusline
  -- Fancier statusline
  use 'nvim-lualine/lualine.nvim'

  -- Web-devicons
  use 'nvim-tree/nvim-web-devicons'

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
  use 'nvim-tree/nvim-tree.lua'

  -- Bufferline
  use {'akinsho/bufferline.nvim', 
        tag = "v3.*", 
        after = 'catppuccin',
        config = function()
          require("bufferline").setup {
            highlights = require("catppuccin.groups.integrations.bufferline").get(),
            options = {
              close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
              right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
              offsets = { { filetype = "NvimTree", text = "File Tree", padding = 1} },
              separator_style = "thin", -- | "thick" | "slant" | { 'any', 'any' },
            },
          }
        end
  }

  -- Autopairs
  use 'windwp/nvim-autopairs'

  -- Terminal
  use 'akinsho/toggleterm.nvim'

  -- Project
  use 'ahmedkhalf/project.nvim'
  
  -- Impatient
  use 'lewis6991/impatient.nvim'
  
  use { -- Debug
    'mfussenegger/nvim-dap',
    requires = {
      'rcarriga/nvim-dap-ui',
    }
  }
  
  -- Whichkey
  use 'folke/which-key.nvim'

  -- Motion
  use 'phaazon/hop.nvim'

  -- Trouble
  use 'folke/trouble.nvim'
  
  -- Noise
  use({
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
          -- add any options here
      })
    end,
    requires = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
      }
  })

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
