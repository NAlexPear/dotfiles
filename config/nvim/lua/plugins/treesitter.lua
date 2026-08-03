-- handle Treesitter-based text objects and contextual syntax highlighting
--
-- both plugins track their `main` branches, which dropped the old
-- `nvim-treesitter.configs` module: parsers are installed explicitly, and
-- highlighting is started per-buffer by Neovim rather than by a module

-- parsers to keep installed, beyond the ones Neovim ships with
local PARSERS = {
  'bash',
  'css',
  'glimmer',
  'html',
  'javascript',
  'json',
  'lua',
  'markdown',
  'markdown_inline',
  'python',
  'ruby',
  'rust',
  'sql',
  'toml',
  'tsx',
  'typescript',
  'yaml',
}

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    config = function()
      local treesitter = require('nvim-treesitter')

      treesitter.setup()

      -- no-op for parsers that are already present
      treesitter.install(PARSERS)

      -- enable highlighting for any filetype whose parser is installed
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local language = vim.treesitter.language.get_lang(args.match)

          if language and vim.treesitter.language.add(language) then
            vim.treesitter.start(args.buf, language)
          end
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter-textobjects').setup({
        select = {
          lookahead = true,
        },
        move = {
          set_jumps = true,
        },
      })

      local select = require('nvim-treesitter-textobjects.select')
      local move = require('nvim-treesitter-textobjects.move')

      for keys, query in pairs({
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      }) do
        vim.keymap.set({ 'x', 'o' }, keys, function()
          select.select_textobject(query, 'textobjects')
        end, { silent = true })
      end

      vim.keymap.set('n', '<Leader>j', function()
        move.goto_next_start('@function.outer', 'textobjects')
      end, { silent = true })
      vim.keymap.set('n', '<Leader>k', function()
        move.goto_previous_start('@function.outer', 'textobjects')
      end, { silent = true })
    end,
  },
}
