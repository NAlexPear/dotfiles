-- set up Language Servers and their associated diagnostics
return {
  'neovim/nvim-lspconfig',
  dependencies = 'hrsh7th/cmp-nvim-lsp',
  config = function()
    local util = require('lspconfig.util')
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

    vim.lsp.config.yamlls = {
      capabilities = capabilities,
      filetypes = { 'yaml' },
    }
    vim.lsp.enable({ 'yamlls' })

    vim.lsp.config.tsgo = {
      settings = {
        diagnostics = {
          ignoredCodes = { 80005, 6385, 6387 },
        }
      }
    }
    vim.lsp.enable({ 'tsgo' })

    vim.lsp.config.oxlint = {
      cmd = { 'oxlint', '--lsp' },
      workspace_required = true,
      on_attach = function(client, bufnr)
        vim.api.nvim_buf_create_user_command(bufnr, 'LspOxlintFixAll', function()
          client:exec_cmd({
            title = 'Apply Oxlint automatic fixes',
            command = 'oxc.fixAll',
            arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
          })
        end, {
          desc = 'Apply Oxlint automatic fixes',
        })
      end,
      root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)

        -- Oxlint resolves configuration by walking upward and using the nearest config file
        -- to the file being processed. We therefore compute the root directory by locating
        -- the closest `.oxlintrc.json` (or `package.json` fallback) above the buffer.
        local root_markers = util.insert_package_json({ '.oxlintrc.json' }, 'oxlint', fname)[1]
        on_dir(vim.fs.dirname(vim.fs.find(root_markers, { path = fname, upward = true })[1]))
      end,
      init_options = {
        settings = {
          ['run'] = 'onType',
          -- ['configPath'] = nil,
          -- ['tsConfigPath'] = nil,
          -- ['unusedDisableDirectives'] = 'allow',
          -- ['typeAware'] = false,
          -- ['disableNestedConfig'] = false,
          ['fixKind'] = 'safe_fix',
        },
      },
    }
    vim.lsp.enable({ 'oxlint' })

    vim.lsp.config.oxfmt = {
      cmd = { 'oxfmt', '--lsp' },
      filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'toml',
        'json',
        'jsonc',
        'json5',
        'yaml',
        'html',
        'vue',
        'handlebars',
        'css',
        'scss',
        'less',
        'graphql',
        'markdown',
      },
      workspace_required = true,
      root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)

        -- Oxfmt resolves configuration by walking upward and using the nearest config file
        -- to the file being processed. We therefore compute the root directory by locating
        -- the closest `.oxfmtrc.json` (or `package.json` fallback) above the buffer.
        local root_markers = util.insert_package_json({ '.oxfmtrc.json' }, 'oxfmt', fname)[1]
        on_dir(vim.fs.dirname(vim.fs.find(root_markers, { path = fname, upward = true })[1]))
      end,
    }
    vim.lsp.enable({ 'oxfmt' })

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

    vim.lsp.config.html = {
      filetypes = { 'html', 'handlebars' },
      capabilities = capabilities,
      provideFormatter = true,
    }
    vim.lsp.enable({ 'html' })

    -- set diagnostic symbols
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = ' ●',
          [vim.diagnostic.severity.WARN]  = ' ●',
          [vim.diagnostic.severity.HINT]  = ' ●',
          [vim.diagnostic.severity.INFO]  = ' ●',
        },
        numhl = {
          [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
          [vim.diagnostic.severity.WARN]  = 'DiagnosticSignWarning',
          [vim.diagnostic.severity.HINT]  = 'DiagnosticSignHint',
          [vim.diagnostic.severity.INFO]  = 'DiagnosticSignInformation',
        },
      },
    })
  end
}
