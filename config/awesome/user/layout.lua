local awful = require 'awful'
local wibox = require 'wibox'
local beautiful = require 'beautiful'
local widgets = require 'user.widgets'

local M = {}

M.setup = function (screen)

  local left_layout = {
      layout = wibox.layout.fixed.horizontal,
      widgets.launcher.widget(screen),
      widgets.tasklist.widget(screen),
      awful.widget.prompt()
  }
  local middle_layout = {
      layout = wibox.layout.fixed.horizontal,
      widgets.clock.widget
  }
  local right_layout = {
      layout = wibox.layout.fixed.horizontal,
      widgets.audio.widget,
      wibox.widget.systray(),
  }

  screen.top_panel = awful.wibar({
    screen = screen,
    position = 'top',
    height = 30,
    bg = beautiful.panel
  })
  screen.top_panel:setup {
    layout = wibox.layout.stack,
    {
      layout = wibox.layout.align.horizontal,
      left_layout,
      nil,
      right_layout
    },
    {
      middle_layout,
      valign = "center",
      halign = "center",
      layout = wibox.container.place
    }
  }

  screen.left_panel = awful.wibar({
    screen = screen,
    position = 'left',
    width = 38,
    bg = beautiful.panel
  })
  screen.left_panel:setup {
    layout = wibox.layout.align.vertical,
    widgets.taglist.widget(screen),
    nil,
    widgets.layoutbox.widget(screen)
  }

end

return M
