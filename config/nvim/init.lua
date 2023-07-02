----------------------
-- Options
----------------------
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.expandtab = true
vim.opt.fillchars = {
  vert = '|',
}
vim.opt.hidden = true
vim.opt.backup = false
vim.opt.wrap = false
vim.opt.writebackup = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 3
vim.opt.shortmess:append { c = true }
vim.opt.shell = 'zsh'
vim.opt.shiftwidth = 2
vim.opt.signcolumn = 'yes'
vim.opt.showmatch = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.ttimeoutlen = 50
vim.opt.wildignorecase = true

----------------------
-- Keymaps
----------------------
vim.g.mapleader = ' '
vim.keymap.set('n', ';;', ';')
vim.keymap.set('', ';', ':')
vim.keymap.set('', '<C-h>', ':e #<CR>')
vim.keymap.set('', '<C-l>', ':nohl<CR>')
vim.keymap.set('', '<Leader>r', ':%s/')
vim.keymap.set('', '<Leader>x', ':x<CR>')
vim.keymap.set('', '<Leader>q', ':q<CR>')
vim.keymap.set('', '<Leader>w', ':w<CR>')
vim.keymap.set('', '<Leader>d', ':!<Space>')
vim.keymap.set('', '<Leader>e', ':e<Space>')
vim.keymap.set('', '<Leader>c', ':cd<Space>')
vim.keymap.set('n', '<Leader>a', vim.lsp.buf.code_action, { silent = true })
vim.keymap.set('n', '<Leader>ad', vim.lsp.buf.definition, { silent = true })
vim.keymap.set('n', '<Leader>aj', vim.diagnostic.goto_next, { silent = true })
vim.keymap.set('n', '<Leader>ak', vim.diagnostic.goto_prev, { silent = true })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { silent = true })
vim.keymap.set('n', 'H', function()
  return vim.diagnostic.open_float(0, { scope = 'line' })
end, { silent = true })

----------------------
-- Plugins
----------------------

-- bootstrap lazy.nvim for loading plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- load up all plugins from the ./plugins directory
require('lazy').setup('plugins')

----------------------
-- AutoCmds
----------------------

-- format buffers on save where possible (depending on the language server)
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function() vim.lsp.buf.format() end,
})

----------------------
-- Globals
----------------------
vim.g.sql_type_default = 'pgsql'
vim.g.markdown_fenced_languages = { 'python', 'ruby', 'javascript', 'typescript', 'bash=sh', 'rust' }
vim.g.markdown_syntax_conceal = 0
