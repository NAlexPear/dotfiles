-- load language-specific plugins
return {
  {
    'tpope/vim-markdown',
    event = 'BufEnter *.md',
  },
  {
    'cespare/vim-toml',
    event = 'BufEnter *.toml',
  },
  {
    'lifepillar/pgsql.vim',
    event = 'BufEnter *.sql',
  },
  {
    'rust-lang/rust.vim',
    event = 'BufEnter *.rs',
  },
}
