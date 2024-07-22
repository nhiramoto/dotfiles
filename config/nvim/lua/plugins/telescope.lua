return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    local telescope = require('telescope')
    telescope.load_extension('flutter')
    telescope.setup({
      pickers = {
        find_files = {
          hidden = true
        }
      }
    })
  end
}
