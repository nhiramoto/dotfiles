return {
  'lukas-reineke/indent-blankline.nvim',
  main = "ibl",
  opts = {},
  config = function()
    local ibl = require('ibl')
    local hooks = require('ibl.hooks')
    local scope = 'scope'
    local indent = 'indent'

    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, indent, { fg = '#181d29' })
      vim.api.nvim_set_hl(0, scope, { fg = '#47547a' })
    end)

    ibl.setup({
      indent = {
        char = '┆',
        highlight = indent,
      },
      scope = {
        highlight = scope,
      }
    })
  end
}
