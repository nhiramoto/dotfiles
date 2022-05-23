local os = require 'os'

local config_root = function(path)
  return os.getenv('HOME') .. '/.config/awesome/' .. path
end

return {
  theme = config_root('user/theme'),
  icons = config_root('user/theme/icons'),
  widgets = config_root('user/wigets')
}
