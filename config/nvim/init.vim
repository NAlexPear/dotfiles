" INIT
" ====================

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

call plug#begin('~/.config/nvim/plugged')
  Plug 'AckslD/nvim-neoclip.lua'
  Plug 'NAlexPear/Spacegray.nvim'
  Plug 'cespare/vim-toml'
  Plug 'hoob3rt/lualine.nvim'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'jxnblk/vim-mdx-js'
  Plug 'lifepillar/pgsql.vim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  Plug 'onsails/lspkind-nvim'
  Plug 'rust-lang/rust.vim'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-markdown'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
call plug#end()

" CORE 
" =====================
set completeopt=menu,menuone,noselect
set expandtab
set fillchars+=vert:\|
set hidden
set nobackup
set nowrap
set nowritebackup
set number
set relativenumber
set scrolloff=3
set shortmess+=c
set shell=zsh
set shiftwidth=2
set signcolumn=yes
set showmatch
set smartcase
set smartindent
set softtabstop=2
set splitbelow
set splitright
set termguicolors
set ttimeoutlen=50
set wildignorecase

" KEYMAPS
" ===============
map ; :
noremap ;; ;
map <C-h> :e #<CR>
map <C-l> :nohl<CR>
map <Space> <leader>
map <leader>r :%s/
map <leader>s :source ~/.config/nvim/init.vim<CR>
map <leader>ss :source ~/.config/nvim/sessions/Session.vim<CR>
map <leader>x :x<CR>
map <leader>q :q<CR>
map <leader>w :w<CR>
map <leader>d :!<Space>
map <leader>e :e<Space>
map <leader>c :cd<Space>
map <silent> <leader>t <cmd>Telescope find_files<CR>
map <silent> <leader>f <cmd>Telescope treesitter<CR>
map <silent> <leader>g <cmd>Telescope live_grep<CR>
map <silent> <leader>b <cmd>Telescope buffers<CR>
map <silent> <leader>h <cmd>Telescope command_history<CR>
map <silent> <leader>y <cmd>:lua require('telescope').extensions.neoclip.default()<CR>
nmap <silent> <leader>a <cmd>lua vim.lsp.buf.code_action()<CR>
nmap <silent> <leader>af <cmd>Telescope lsp_references<CR>
nmap <silent> <leader>ai <cmd>Telescope lsp_implementations<CR>
nmap <silent> <leader>ad <cmd>Telescope lsp_definitions<CR>
nmap <silent> <leader>aj <cmd>lua vim.diagnostic.goto_next()<CR>
nmap <silent> <leader>ak <cmd>lua vim.diagnostic.goto_prev()<CR>
nmap <silent> H <cmd>lua vim.diagnostic.open_float(0, {scope="line"})<CR>
nmap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>= :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <leader>- :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
nmap <C-s> :mks! ~/.config/nvim/sessions/Session.vim<CR>

" LUA CONFIGURATIONS
" ================
lua << EOF
-- Completion
local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup{
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

-- Tree-Sitter
require('nvim-treesitter.configs').setup{
  ensure_installed = 'all',
  highlight = {
    enable = true
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.outer',
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ['<leader>j'] = '@function.outer'
      },
      goto_previous_start = {
        ['<leader>k'] = '@function.outer'
      }
    }
  }
}

-- LSP
local lsp = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

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
lsp.rust_analyzer.setup{
  capabilities = capabilities,
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
      },
      checkOnSave = {
        command = 'clippy'
      },
      completion = {
        privateEditable = {
          enable = true
        }
      },
      diagnostics = {
        disabled = {'inactive-code'}
      },
      experimental = {
        procAttrMacros = true
      },
      hoverActions = {
        references = true
      },
      procMacro = {
        enable = true
      },
      rustfmt = {
        enableRangeFormatting = true
      }
    }
  }
}

lsp.tsserver.setup{}
lsp.bashls.setup{}
lsp.sumneko_lua.setup{}

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

-- Telescope
local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ['<ESC>'] = actions.close
      }
    }
  }
}

-- Neoclip
require('neoclip').setup()

-- Lualine
require('lualine').setup{
  options = {
    theme = 'codedark',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {
      {'diagnostics', sources={'nvim_diagnostic'}},
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  }
}

-- Colorscheme
vim.cmd[[colorscheme spacegray]]
EOF

" THEME
" =====================
filetype plugin indent on

" LANGUAGES 
" ==================
" JS/TS
autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.tsx lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.ts lua vim.lsp.buf.formatting_sync(nil, 100)

" Rust
autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 100)

" Elm
let g:elm_setup_keybindings = 0

" SQL
let g:sql_type_default = 'pgsql'

" Markdown
let g:markdown_fenced_languages = ['python', 'ruby', 'javascript', 'typescript', 'bash=sh']
let g:markdown_syntax_conceal = 0

" Skylark
au FileType markdown setl wrap linebreak
au BufReadPost Tiltfile set filetype=python.skylark
