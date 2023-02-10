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
  automatic_installation = true
})

require('mason-null-ls').setup({
  --[[ ensure_installed = nil, ]]
  automatic_installation = true,
  --[[ automatic_setup = false, ]]
})

require('mason-nvim-dap').setup({
  ensure_installed = {
    'python',
  },
  automatic_installation = true,
  automatic_setup = true,
})

require 'mason-nvim-dap'.setup_handlers()

for _, lsp in ipairs(servers) do
  local on_attach , capabilities = require 'plugin_config.lsp.settings.common'
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
