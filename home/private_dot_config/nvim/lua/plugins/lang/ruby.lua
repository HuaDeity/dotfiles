-- lsp
vim.lsp.enable "ruby_lsp"

return {
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = {
      ensure_installed = { "ruby" },
    },
  },

  -- lint
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        ruby = { "robocop" },
      },
    },
  },

  -- format
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ruby = { "rubocop" },
      },
    },
  },

  -- -- debug
  -- {
  --   "mfussenegger/nvim-dap",
  --   optional = true,
  --   dependencies = {
  --     "suketa/nvim-dap-ruby",
  --     config = function()
  --       require("dap-ruby").setup()
  --     end,
  --   },
  -- },

  -- -- test
  -- {
  --   "nvim-neotest/neotest",
  --   optional = true,
  --   dependencies = {
  --     "olimorris/neotest-rspec",
  --   },
  --   opts = {
  --     adapters = {
  --       ["neotest-rspec"] = {
  --         -- NOTE: By default neotest-rspec uses the system wide rspec gem instead of the one through bundler
  --         -- rspec_cmd = function()
  --         --   return vim.tbl_flatten({
  --         --     "bundle",
  --         --     "exec",
  --         --     "rspec",
  --         --   })
  --         -- end,
  --       },
  --     },
  --   },
  -- },
}
