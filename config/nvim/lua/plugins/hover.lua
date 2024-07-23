return {
  'lewis6991/hover.nvim',
  config = function()
    local hover = require('hover')
    hover.setup({
      init = function()
        require('hover.providers.lsp')
      end,
    })
  end
}
