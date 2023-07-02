-- eagerly load the colorscheme
return {
  'NAlexPear/Spacegray.nvim',
  lazy = false,
  config = function()
    vim.cmd([[colorscheme spacegray]])
  end
}
