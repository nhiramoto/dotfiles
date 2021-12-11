local filesystem = require('gears.filesystem')
local mat_colors = require('theme.mat-colors')
local theme_dir = filesystem.get_configuration_dir() .. '/theme'
local dpi = require('beautiful').xresources.apply_dpi

local theme = {}
theme.icons = theme_dir .. '/icons/'
theme.font = 'Roboto medium 10'

-- Colors Pallets

-- Primary
theme.primary = mat_colors.indigo
theme.primary.hue_500 = '#003f6b'
-- Accent
theme.accent = mat_colors.pink

-- Background
theme.background = mat_colors.grey

theme.background.hue_800 = '#242424'
theme.primary.hue_500 = '#3F51B5'

local awesome_overrides = function(theme)

  theme.wallpaper = os.getenv('HOME') .. '/Pictures/default.jpg'

end
return {
  theme = theme,
  awesome_overrides = awesome_overrides
}
