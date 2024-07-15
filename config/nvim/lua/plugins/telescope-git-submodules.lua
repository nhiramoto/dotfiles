return {
  'agoodshort/telescope-git-submodules.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'akinsho/toggleterm.nvim'
  },
  config = function()
    require('telescope').load_extension('git_submodules')
  end
}
