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
  Plug 'itchyny/lightline.vim'
  Plug 'junegunn/fzf.vim'
  Plug 'jxnblk/vim-mdx-js'
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'
  Plug 'neoclide/coc.nvim', {
  \  'branch': 'release'
  \}
  Plug 'lifepillar/pgsql.vim'
  Plug 'rust-lang/rust.vim'
  Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-markdown'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'voldikss/vim-floaterm'
call plug#end()

" THEME
" =====================
filetype plugin indent on
syntax on

colorscheme spacegray

hi SignColumn guibg=Background
hi VertSplit guibg=Background
hi NonText guifg=Background

" black
let g:terminal_color_0='#2C2F33'
let g:terminal_color_8='#4B5056'

" red
let g:terminal_color_1='#B04C50'
let g:terminal_color_9='#B04C50'

" green
let g:terminal_color_2='#919652'
let g:terminal_color_10='#94985B'

" yellow
let g:terminal_color_3='#E2995C'
let g:terminal_color_11='#E2995C'

" blue
let g:terminal_color_4='#66899D'
let g:terminal_color_12='#66899D'

" magenta
let g:terminal_color_5='#8D6494'
let g:terminal_color_13='#8D6494'

" cyan
let g:terminal_color_6='#527C77'
let g:terminal_color_14='#527C77'


" CORE 
" =====================

set cmdheight=2
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

" FUNCTIONS
" ===============

function! s:check_back_space() abort
  let col = col('.') - 1

  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! LightLineFilename() 
  let parent = split(expand('%:p:h'), '/')[-1]
  let child = expand('%:t')

  return child ==# '' ? '[No Name]' : join([parent, child], '/')
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction


" COMMANDS
" ===============

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')


" KEYMAPS
" ===============

inoremap <silent><expr> <TAB>
     \ pumvisible() ? "\<C-n>" :
     \ <SID>check_back_space() ? "\<TAB>" :
     \ coc#refresh()
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
map <silent> <leader>ff :Rg<Space>
map <silent> <leader>f :Lines<CR>
map <silent> <leader>t :Files<CR>
map <silent> <leader>b :Buffers<CR>
map <silent> <leader>h :History:<CR>
nmap <silent> <leader>aj <Plug>(coc-diagnostic-next)
nmap <silent> <leader>ak <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>at <Plug>(coc-type-definition)
nmap <silent> <leader>ai <Plug>(coc-implementation)
nmap <silent> <leader>ad <Plug>(coc-definition)
nmap <silent> <leader>af <Plug>(coc-references)
nnoremap <silent> <leader>= :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <leader>- :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
nmap <C-s> :mks! ~/.config/nvim/sessions/Session.vim<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
noremap <C-t> :FloatermToggle<CR>
noremap! <C-t> <Esc>:FloatermToggle<CR>
tnoremap <C-t> <C-\><C-n>:FloatermToggle<CR>


" PLUGINS
" ================

" CoC
augroup mygroup
  autocmd!
  " Wrap lines automatically for markdown files
  autocmd FileType markdown setl wrap linebreak
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

hi! CocErrorSign guifg=#C5735E
hi! CocWarningSign guifg=#FFAF00
hi! CocHintSign guifg=#353534
hi! CocError guisp=#C5735E gui=undercurl
hi! CocWarn guisp=#FFAF00 gui=undercurl
hi! CocInfo guibg=#353534

" Emmet
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\}

" Lightline
function! CocCurrentFunction()
  return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
\   'active': {
\     'left': [ [ 'mode', 'paste' ],
\               [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
\   },
\   'component_function': {
\     'cocstatus': 'coc#status',
\     'currentfunction': 'CocCurrentFunction'
\   },
\ }

" FZF
let $FZF_DEFAULT_COMMAND = 'fd --type f'

" Floaterm
let g:floaterm_borderchars='       '
let g:floaterm_title = ''

" LANGUAGES 
" ==================

" Elm
let g:elm_setup_keybindings = 0

" SQL
let g:sql_type_default = 'pgsql'

" Markdown
let g:markdown_fenced_languages = ['python', 'ruby', 'javascript', 'typescript', 'bash=sh']
let g:markdown_syntax_conceal = 0

" Starlark
au BufReadPost Tiltfile set filetype=python.skylark

" TESTING
" ==================

let test#strategy = 'neovim'

" PREVIEWS
" =================
let g:instant_markdown_autostart = 0
let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
