-- set up Language Servers and their associated diagnostics
return {
  'neovim/nvim-lspconfig',
  dependencies = 'hrsh7th/cmp-nvim-lsp',
  config = function()
    -- initialize language server capabilities
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
    vim.lsp.config.rust_analyzer = {
      capabilities = capabilities,
      settings = {
        ['rust-analyzer'] = {
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
    vim.lsp.enable({ 'rust_analyzer' })

    vim.lsp.config.eslint = {
      capabilities = capabilities,
      on_attach = function(_, buffer)
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = buffer,
          command = 'EslintFixAll',
        })
      end
    }
    vim.lsp.enable({ 'eslint' })

    vim.lsp.config.yamlls = {
      capabilities = capabilities,
    }
    vim.lsp.enable({ 'yamlls' })

    vim.lsp.config.ts_ls = {
      settings = {
        diagnostics = {
          ignoredCodes = { 80005, 6385, 6387 },
        }
      },
      capabilities = capabilities,
    }
    vim.lsp.enable({ 'ts_ls' })

    vim.lsp.config.bashls = {
      capabilities = capabilities,
    }
    vim.lsp.enable({ 'bashls' })

    vim.lsp.config.lua_ls = {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' }
          }
        }
      }
    }
    vim.lsp.enable({ 'lua_ls' })

    vim.lsp.config.ccls = {
      capabilities = capabilities,
    }
    vim.lsp.enable({ 'ccls' })

    vim.lsp.config.html = {
      filetypes = { 'html', 'handlebars', 'html.handlebars' },
      capabilities = capabilities,
      provideFormatter = true,
    }
    vim.lsp.enable({ 'html' })

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
