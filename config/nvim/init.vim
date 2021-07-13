" INIT
" ====================

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

call plug#begin('~/.config/nvim/plugged')
  Plug 'ajh17/Spacegray.vim'
  Plug 'cespare/vim-toml'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'hoob3rt/lualine.nvim'
  Plug 'jxnblk/vim-mdx-js'
  Plug 'jiangmiao/auto-pairs'
  Plug 'lifepillar/pgsql.vim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'mxw/vim-jsx'
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/completion-nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'pangloss/vim-javascript'
  Plug 'rust-lang/rust.vim'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-markdown'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
call plug#end()

" THEME
" =====================
filetype plugin indent on
syntax on

colorscheme spacegray

hi SignColumn guibg=Background
hi VertSplit guibg=Background
hi NonText guifg=Background

hi LspDiagnosticsVirtualTextError guifg=Red ctermfg=Red
hi LspDiagnosticsVirtualTextWarning guifg=Yellow ctermfg=Yellow
hi LspDiagnosticsVirtualTextInformation guifg=White ctermfg=Grey
hi LspDiagnosticsVirtualTextHint guifg=White ctermfg=Grey
hi LspDiagnosticsUnderlineError guifg=NONE ctermfg=NONE cterm=underline gui=underline
hi LspDiagnosticsUnderlineWarning guifg=NONE ctermfg=NONE cterm=underline gui=underline
hi LspDiagnosticsUnderlineInformation guifg=NONE ctermfg=NONE cterm=underline gui=underline
hi LspDiagnosticsUnderlineHint guifg=NONE ctermfg=NONE cterm=underline gui=underline

" CORE 
" =====================
set completeopt=menuone,noinsert,noselect
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
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

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
nmap <silent> <leader>a <cmd>Telescope lsp_code_actions<CR>
nmap <silent> <leader>af <cmd>Telescope lsp_references<CR>
nmap <silent> <leader>ai <cmd>Telescope lsp_implementations<CR>
nmap <silent> <leader>ad <cmd>Telescope lsp_definitions<CR>
nmap <silent> <leader>aj <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nmap <silent> <leader>ak <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nmap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>= :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <leader>- :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
nmap <C-s> :mks! ~/.config/nvim/sessions/Session.vim<CR>


" PLUGINS
" ================
lua << EOF
-- LSP
local lsp = require('lspconfig')
local completion = require('completion')

local on_attach = function(client)
  completion.on_attach(client)
end

-- enable individual languages
lsp.rust_analyzer.setup{
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importGranularity = "module"
      },
      diagnostics = {
        disabled = { "inactive-code" }
      },
      inlayHints = {
        chainingHints = false
      },
      cargo = {
        loadOutDirsFromCheck = true,
      },
      procMacro = {
        enable = true
      }
    }
  }
}

lsp.tsserver.setup{
  on_attach = on_attach
}

-- enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    underline = true,
    virtual_text = true,
  }
)

-- Telescope
local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<ESC>"] = actions.close
      }
    }
  }
}

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
      {'diagnostics', sources={'nvim_lsp'}},
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  }
}
EOF

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

" PREVIEWS
" =================
let g:instant_markdown_autostart = 0
let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
