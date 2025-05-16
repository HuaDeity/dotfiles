-- lsp
vim.lsp.config("jsonls", {
  -- lazy-load schemastore when needed
  before_init = function(_, config)
    config.settings.json.schemas = config.settings.json.schemas or {}
    vim.list_extend(config.settings.json.schemas, require("schemastore").json.schemas())
  end,
  settings = {
    json = {
      validate = { enable = true },
    },
  },
})
vim.lsp.enable "jsonls"

return {
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = { ensure_installed = { "json", "jsonc", "json5" } },
  },

  -- lint
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        json = { "biomejs" },
        jsonc = { "biomejs" },
      },
    },
  },

  -- format
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        json = {
          "biome-check",
          "biome",
          "biome-organize-imports",
        },
        jsonc = {
          "biome-check",
          "biome",
          "biome-organize-imports",
        },
      },
      -- formatters = {
      --   biome = {
      --     require_cwd = true,
      --   },
      -- },
    },
  },

  -- json schema support
  {
    "b0o/SchemaStore.nvim",
  },
}
