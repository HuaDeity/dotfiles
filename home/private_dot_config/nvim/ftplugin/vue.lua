-- lsp
vim.lsp.enable { "vue_ls", "vtsls" }

vim.lsp.config("vtsls", {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = "@vue/typescript-plugin",
            location = "/path/to/@vue/language-server",
            languages = { "vue" },
            configNamespace = "typescript",
          },
        },
      },
    },
  },
})

-- treesitter
require("nvim-treesitter").install "vue"
