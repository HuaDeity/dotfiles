if vim.env.PROF then
  local snacks = vim.fn.stdpath "data" .. "/site/pack/core/opt/snacks.nvim"
  vim.opt.rtp:append(snacks)
  ---@diagnostic disable-next-line: missing-fields
  require("snacks.profiler").startup {
    startup = {
      event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
      -- event = "UIEnter",
      -- event = "VeryLazy",
    },
  }
end

vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/folke/noice.nvim",
  "https://github.com/folke/trouble.nvim",
  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/kkharji/sqlite.lua",

  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },

  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range "1.*" },
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/xzbdmw/colorful-menu.nvim",
  "https://github.com/moyiz/blink-emoji.nvim",
  "https://github.com/Kaiser-Yang/blink-cmp-git",
  "https://github.com/fang2hou/blink-copilot",
  "https://github.com/folke/lazydev.nvim",

  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/igorlfs/nvim-dap-view",
  "https://github.com/theHamsta/nvim-dap-virtual-text",

  "https://github.com/stevearc/conform.nvim",

  "https://github.com/folke/which-key.nvim",

  "https://github.com/mfussenegger/nvim-lint",

  "https://github.com/neovim/nvim-lspconfig",

  "https://github.com/stevearc/overseer.nvim",

  "https://github.com/nvim-neotest/neotest",
  "https://github.com/nvim-neotest/nvim-nio",

  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },

  "https://github.com/folke/ts-comments.nvim",
  "https://github.com/folke/todo-comments.nvim",

  "https://github.com/nvim-mini/mini.diff",
  "https://github.com/sindrets/diffview.nvim",
  "https://github.com/f-person/git-blame.nvim",

  "https://github.com/folke/flash.nvim",

  "https://github.com/brenoprata10/nvim-highlight-colors",

  "https://github.com/RRethy/vim-illuminate",

  "https://github.com/monaqa/dial.nvim",

  "https://github.com/NMAC427/guess-indent.nvim",

  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
  "https://github.com/smjonas/inc-rename.nvim",

  "https://github.com/nvim-mini/mini.move",

  "https://github.com/nvim-mini/mini.pairs",
  "https://github.com/HiPhish/rainbow-delimiters.nvim",
  "https://github.com/windwp/nvim-ts-autotag",

  "https://github.com/nvim-mini/mini.splitjoin",
  "https://github.com/Wansmer/treesj",

  "https://github.com/gbprod/yanky.nvim",

  "https://github.com/olimorris/codecompanion.nvim",
  "https://github.com/ravitemer/codecompanion-history.nvim",
  "https://github.com/ravitemer/mcphub.nvim",
  "https://github.com/Davidyz/VectorCode",
  { src = "https://github.com/HakonHarnes/img-clip.nvim", version = "feat/pbctl" },

  "https://github.com/folke/edgy.nvim",

  "https://github.com/nvim-mini/mini-git",
  "https://github.com/NeogitOrg/neogit",
  "https://github.com/pwntester/octo.nvim",

  "https://github.com/stevearc/aerial.nvim",

  "https://github.com/MagicDuck/grug-far.nvim",

  "https://github.com/mrjones2014/smart-splits.nvim",

  "https://github.com/danymat/neogen",

  "https://github.com/zbirenbaum/copilot.lua",
  "https://github.com/AndreM222/copilot-lualine",
  -- "https://github.com/milanglacier/minuet-ai.nvim",

  "https://github.com/nvim-mini/mini.surround",

  "https://github.com/nvim-mini/mini.ai",
  "https://github.com/nvim-mini/mini.extra",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },

  "https://github.com/nvim-treesitter/nvim-treesitter-context",

  "https://github.com/nvim-mini/mini.map",

  "https://github.com/luukvbaal/statuscol.nvim",

  "https://github.com/nvim-lualine/lualine.nvim",

  "https://github.com/akinsho/bufferline.nvim",

  "https://github.com/Bekaboo/dropbar.nvim",

  "https://github.com/okuuva/auto-save.nvim",

  "https://github.com/xvzc/chezmoi.nvim",

  "https://github.com/willothy/flatten.nvim",

  "https://github.com/m4xshen/hardtime.nvim",

  "https://github.com/lewis6991/hover.nvim",

  "https://github.com/keaising/im-select.nvim",

  "https://github.com/dstein64/vim-startuptime",

  "https://github.com/nvim-mini/mini.misc",

  "https://github.com/folke/persistence.nvim",

  "https://github.com/wakatime/vim-wakatime",

  "https://github.com/stevearc/stickybuf.nvim",
}, { confirm = false })

vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("TreesitterUpdate", { clear = true }),
  callback = function(args)
    if args.data.kind == "update" and args.data.spec.name == "nvim-treesitter" then vim.cmd "TSUpdate" end
  end,
  desc = "Treesitter: update parser automatically",
})

vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("MCPHubInstall", { clear = true }),
  callback = function(args)
    if args.data.kind == "update" and args.data.spec.name == "mcphub.nvim" then
      vim.notify("Installing MCPHub CLI...", vim.log.levels.INFO)
      vim.system({ "npm", "i", "-g", "mcp-hub@latest" }, {
        text = true,
      }, function(result)
        if result.code == 0 then
          vim.schedule(function() vim.notify("MCPHub CLI installed successfully!", vim.log.levels.INFO) end)
        else
          vim.schedule(
            function() vim.notify("Failed to install MCPHub CLI: " .. (result.stderr or ""), vim.log.levels.ERROR) end
          )
        end
      end)
    end
  end,
  desc = "MCPHub: Install MCPHub CLI",
})

vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("VectorCodeInstall", { clear = true }),
  callback = function(args)
    if args.data.kind == "update" and args.data.spec.name == "VectorCode" then
      vim.notify("Installing VectorCode CLI...", vim.log.levels.INFO)
      vim.system({ "uv", "tool", "install", "vectorcode", "-U" }, {
        text = true,
      }, function(result)
        if result.code == 0 then
          vim.schedule(function() vim.notify("VectorCode CLI installed successfully!", vim.log.levels.INFO) end)
          -- VectorCode setup is handled in codecompanion extensions
        else
          vim.schedule(
            function() vim.notify("Failed to install VectorCode CLI: " .. (result.stderr or ""), vim.log.levels.ERROR) end
          )
        end
      end)
    end
  end,
  desc = "VectorCode: Install VectorCode CLI",
})

-- Variable to track if auth is needed
local needs_auth = false

-- Setup Copilot on BufReadPost
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("CopilotSetup", { clear = true }),
  callback = function()
    require("copilot").setup {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    }
    if needs_auth then vim.cmd "Copilot auth" end
  end,
  desc = "Copilot: Setup on buffer read",
})

vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("CopilotAuth", { clear = true }),
  callback = function(args)
    if args.data.kind == "update" and args.data.spec.name == "copilot.lua" then
      needs_auth = true -- Set flag to include auth in next setup
    end
  end,
  desc = "Copilot: Schedule auth on package update",
})
