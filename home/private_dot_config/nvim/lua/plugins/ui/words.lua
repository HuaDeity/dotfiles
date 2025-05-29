return {
  -- {
  --   "folke/snacks.nvim",
  --   opts = {
  --     words = { enabled = true },
  --   },
  --   specs = {
  --     {
  --       "neovim/nvim-lspconfig",
  --       optional = true,
  --       opts = function()
  --         local keys = require("plugins.lsp.attach").get()
  --         -- stylua: ignore
  --         vim.list_extend(keys, {
  --           { "<a-n>", function() Snacks.words.jump(vim.v.count1, true) end, has = "documentHighlight",
  --             desc = "Next Reference", cond = function() return Snacks.words.is_enabled() end },
  --           { "<a-p>", function() Snacks.words.jump(-vim.v.count1, true) end, has = "documentHighlight",
  --             desc = "Prev Reference", cond = function() return Snacks.words.is_enabled() end },
  --         })
  --       end,
  --     },
  --   },
  -- },

  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      providers = {
        "lsp",
        "treesitter",
      },
      -- delay = 200,
      -- large_file_cutoff = 2000,
      -- large_file_overrides = {
      --   providers = { "lsp" },
      -- },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      Snacks.toggle({
        name = "Illuminate",
        get = function() return not require("illuminate.engine").is_paused() end,
        set = function(enabled)
          local m = require "illuminate"
          if enabled then
            m.resume()
          else
            m.pause()
          end
        end,
      }):map "<leader>ux"
    end,
  },
}
