return {
  'lewis6991/hover.nvim',
  config = function()
    local hover = require('hover')
    hover.setup({
      init = function()
        require('hover.providers.lsp')
        require('hover.providers.diagnostic')
        require('hover.providers.dictionary')
        require('hover.providers.jira')
        require('hover.providers.gh')
        require('hover.providers.gh_user')
      end,
    })
  end
}
