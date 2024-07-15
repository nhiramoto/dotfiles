return {
  { 'vim-airline/vim-airline' },
  {
    'vim-airline/vim-airline-themes',
    config = function()
      vim.cmd('let g:airline_theme="minimalist"')
    end
  }
}
