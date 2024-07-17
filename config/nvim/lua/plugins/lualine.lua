return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
      },
      sections = {
        lualine_a = { {'mode', fmt = function(str) return str:sub(1,1) end} },
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'g:coc_status', 'filename'},
        lualine_x = {'encoding', 'fileformat'},
        lualine_y = {'filetype'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
    }
  end
}
