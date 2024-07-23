return {
  'stevearc/stickybuf.nvim',
  opts = {},
  config = function()
    local stickybuf = require('stickybuf')
    stickybuf.setup()
  end
}
