-- handle Treesitter-based text objects and contextual syntax highlighting
return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup({
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
    })
  end
}
