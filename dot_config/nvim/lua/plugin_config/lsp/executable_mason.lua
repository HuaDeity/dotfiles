--  Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = { 
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  sumneko_lua = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    }
  }
}

--  Setup neovim lua configuration
require('neodev').setup()

-- Setup mason so it can manage external tooling
require('mason').setup()

require('mason-lspconfig').setup({
    ensure_installed = vim.tbl_keys(servers),
})

require('mason-tool-installer').setup{
  ensure_installed = {
    'black',
    'flake8',
    'prettier',
    'stylua',
  },
  auto_update = true,
  run_on_start = true,
}

for _, lsp in ipairs(servers) do
  local on_attach , capabilities = require 'plugin_config.lsp.settings.common'
  opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  require('mason-lspconfig').setup_handlers {
    function(server_name)
      require('lspconfig')[server_name].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = servers[server_name],
      }
    end,
  }
end
