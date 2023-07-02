-- set up fuzzy finders for searching through files, buffers, history, etc
return {
  'ibhagwan/fzf-lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'AckslD/nvim-neoclip.lua',
  },
  keys = {
    { '<leader>t', '<CMD>FzfLua files<CR>' },
    { '<leader>g', '<CMD>FzfLua live_grep_native<CR>' },
    { '<leader>b', '<CMD>FzfLua buffers<CR>' },
    { '<leader>h', '<CMD>FzfLua command_history<CR>' },
    {
      '<leader>y',
      function()
        require('neoclip.fzf')()
      end
    },
    { '<leader>af', '<CMD>FzfLua lsp_references<CR>' },
    { '<leader>ai', '<CMD>FzfLua lsp_implementations<CR>' },
    { '<leader>wd', '<CMD>FzfLua lsp_workspace_diagnostics<CR>' },
  },
  config = function()
    require('neoclip').setup()
    require('fzf-lua').setup()
  end
}
