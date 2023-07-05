-- load auto-completions and their related sources
return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'onsails/lspkind-nvim',
    'hrsh7th/vim-vsnip',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-vsnip',
  },
  event = 'InsertEnter',
  config = function()
    local cmp = require('cmp')
    local lspkind = require('lspkind')

    cmp.setup {
      enabled = true,
      formatting = {
        format = lspkind.cmp_format()
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-y>'] = cmp.config.disable,
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }),
      snippet = {
        expand = function(args)
          vim.fn['vsnip#anonymous'](args.body)
        end
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
      }, {
        { name = 'buffer' },
      }),
    }

    cmp.setup.cmdline(':', {
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      })
    })
  end
}
