-- https://github.com/prettier-solidity/prettier-plugin-solidity
require('null-ls').setup {
  debug = false,
  sources = {
    require('null-ls').builtins.code_actions.gitsigns,
    require('null-ls').builtins.formatting.prettier.with {
      extra_filetypes = { "toml" },
      extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
    },
    require('null-ls').builtins.formatting.black.with { extra_args = { "--fast" } },
    require('null-ls').builtins.formatting.stylua,
    require('null-ls').builtins.diagnostics.flake8,
  },
}
