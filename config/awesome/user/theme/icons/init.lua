local os = require 'os'
local paths = require 'user.paths'

local path = function (file_name)
  return paths.icons .. '/' .. file_name
end

return {
  layoutbox = {
    tile = path('layout-tile.png'),
    tileleft = path('layout-tileleft.png'),
    tilebottom = path('layout-tilebottom.png'),
    tiletop = path('layout-tiletop.png'),
    fairv = path('layout-fairv.png'),
    fairh = path('layout-fairh.png'),
    spiral = path('layout-spiral.png'),
    dwindle = path('layout-dwindle.png'),
    max = path('layout-max.png'),
    fullscreen = path('layout-fullscreen.png'),
    magnifier = path('layout-magnifier.png'),
    floating = path('layout-floating.png'),
    cornernw = path('layout-cornernw.png'),
    cornerne = path('layout-cornerne.png'),
    cornersw = path('layout-cornersw.png'),
    cornerse = path('layout-cornerse.png'),
  },
  panel = {
    audio_on = path( 'audio-on.png'),
    audio_off = path('audio-off.png'),
    battery = path('battery.png')
  },
  audio_on = path('audio-on-huge.png'),
  audio_off = path('audio-off-huge.png')
}
