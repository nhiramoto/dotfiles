local wibox = require 'wibox'
local gears = require 'gears'
local awful = require 'awful'

local theme = require 'user.theme'

local M = {}

M.widget = wibox.container {
  widget = wibox.container.margin,
  margins = 2,
  {
    widget = wibox.container.background,
    bg = '#292b3d',
    shape = function (cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 10)
    end,
    {
      widget = wibox.container.margin,
      left = 10,
      right = 10,
      top = 2,
      bottom = 2,
      {
        layout = wibox.layout.fixed.horizontal,
        spacing = 6,
        {
          widget = wibox.widget.textclock,
          refresh = 60,
          format = "<span color='" .. theme.colors.color2 .. "'>%d/%m/%Y</span> "
        },
        {
          widget = wibox.widget.textbox,
          text = '󱑍',
          font = 'Material Design Icons'
        },
        {
          widget = wibox.widget.textclock,
          refresh = 60,
          format = "%H:%M"
        }
      }
    }
  }
}

M.tooltip = awful.tooltip {
  objects = { M.widget },
  text = "Date & Time",
  mode = "outside",
  preferred_alignments = { "middle", "front", "back" }
}
M.popup = awful.widget.calendar_popup.month()
M.popup:attach(M.widget, 'tc', { on_hover = false })

return M
