-- set up a useful status line for all modes
return {
  'hoob3rt/lualine.nvim',
  config = function()
    require('lualine').setup({
      options = {
        theme = 'codedark',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'filename' },
        lualine_x = {
          { 'diagnostics', sources = { 'nvim_diagnostic' } },
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      }
    })
  end
}
