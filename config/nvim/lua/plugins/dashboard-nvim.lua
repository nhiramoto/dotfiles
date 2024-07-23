--[[return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { {'nvim-tree/nvim-web-devicons'}, {'MaximilianLloyd/ascii.nvim', dependencies = {'MunifTanjim/nui.nvim'} } },
  config = function()
    require('dashboard').setup {
      theme = 'hyper',
      config = {
        header = require('ascii').art.text.neovim.sharp,
        week_header = { enable = false }
      }
    }
  end,
}--]]
return {}
