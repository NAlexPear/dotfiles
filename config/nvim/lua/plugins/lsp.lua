-- set up Language Servers and their associated diagnostics
return {
  'neovim/nvim-lspconfig',
  dependencies = 'hrsh7th/cmp-nvim-lsp',
  config = function()
    -- initialize language server capabilities
    local lsp = require('lspconfig')
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- enable auto-imports
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = {
        'documentation',
        'detail',
        'additionalTextEdits'
      }
    }

    -- enable snippets
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- enable rust-analyzer goodies
    capabilities.experimental = {
      hoverActions = true,
      hoverRange = true
    }

    capabilities.experimental.commands = {
      commands = {
        'rust-analyzer.runSingle',
        'rust-analyzer.debugSingle',
        'rust-analyzer.showReferences',
        'rust-analyzer.gotoLocation',
        'editor.action.triggerParameterHints'
      }
    }

    -- enable individual languages
    lsp.rust_analyzer.setup {
      capabilities = capabilities,
      settings = {
        ['rust-analyzer'] = {
          extraEnv = {
            RUSTFLAGS = '--cfg=web_sys_unstable_apis',
          },
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
          },
          completion = {
            privateEditable = {
              enable = true,
            },
          },
          diagnostics = {
            disabled = { 'inactive-code' },
          },
          experimental = {
            procAttrMacros = true,
          },
          hoverActions = {
            references = true,
          },
          procMacro = {
            enable = true,
          },
          rustfmt = {
            enableRangeFormatting = true,
          },
          checkOnSave = {
            command = 'clippy',
            extraArgs = { '--target-dir', 'target/rust-analyzer' },
          }
        }
      }
    }

    lsp.eslint.setup {
      capabilities = capabilities,
      on_attach = function(_, buffer)
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = buffer,
          command = 'EslintFixAll',
        })
      end
    }

    lsp.yamlls.setup {
      capabilities = capabilities,
    }

    lsp.ts_ls.setup {
      capabilities = capabilities,
    }

    lsp.bashls.setup {
      capabilities = capabilities,
    }

    lsp.lua_ls.setup {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' }
          }
        }
      }
    }

    lsp.ccls.setup {
      capabilities = capabilities,
    }

    lsp.html.setup {
      filetypes = { 'html', 'handlebars', 'html.handlebars' },
      capabilities = capabilities,
      provideFormatter = true,
    }

    -- set diagnostic symbols
    vim.fn.sign_define(
      'DiagnosticSignError',
      { texthl = 'DiagnosticSignError', text = ' ●', numhl = 'DiagnosticSignError' }
    )
    vim.fn.sign_define(
      'DiagnosticSignWarning',
      { texthl = 'DiagnosticSignWarning', text = ' ●', numhl = 'DiagnosticSignWarning' }
    )
    vim.fn.sign_define(
      'DiagnosticSignHint',
      { texthl = 'DiagnosticSignHint', text = ' ●', numhl = 'DiagnosticSignHint' }
    )
    vim.fn.sign_define(
      'DiagnosticSignInformation',
      { texthl = 'DiagnosticSignInformation', text = ' ●', numhl = 'DiagnosticSignInformation' }
    )
  end
}
