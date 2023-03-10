-- nvim-cmp setup
local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

local cmp = require 'cmp'
local luasnip = require 'luasnip'
local lspkind = require 'lspkind'

require ('luasnip.loaders.from_vscode').lazy_load()

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({behavior = cmp.SelectBehavior.Select})
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  window = {
    completion = {
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      col_offset = -3,
      side_padding = 0,
    }, 
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    fields = {"kind","abbr","menu"},
    format = lspkind.cmp_format({
        mode = "symbol_text",
        maxwidth = 50,
        menu = ({
          copilot = "[Copilot]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[Lua]",
          luasnip = "[Luasnip]",
          buffer = "[Buffer]",
          path = "[Path]",
        })
      })
  },
  sources = {
		{ name = 'copilot', group_index = 2},
    { name = 'nvim_lsp', group_index = 2},
    { name = 'nvim_lua', group_index = 2},
    { name = 'luasnip', group_index = 2},
    { name = 'buffer', group_index = 2},
    { name = 'path', group_index = 2},
  },
}
