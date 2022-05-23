local wibox = require 'wibox'
local awful = require 'awful'
local vicious = require 'vicious'

local theme = require 'user.theme'
local icons = require 'user.theme.icons'

local M = {}

M.widget = wibox.widget {
  layout = wibox.layout.fixed.horizontal,
  spacing = 2,
  {
    widget = wibox.container.margin,
    margins = 2,
    {
      widget = wibox.widget.imagebox,
      id = "status",
      image = icons.panel.audio_on
    }
  },
  {
    {
      widget = wibox.widget.progressbar,
      id = 'progress',
      margins = 4,
      width = 70,
      ticks = false,
      border_width = 0
    },
    {
      widget = wibox.widget.textbox,
      id = "percent",
      align = "center",
      valign = "center",
      font = theme.font_small,
    },
    widget = wibox.layout.stack,
  }
}
M.tooltip = awful.tooltip {
  objects = { M.wiget },
  text = "Volume Level",
  mode = "outside",
  preferred_alignments = { "middle", "front", "back" }
}
vicious.register(M.widget, vicious.widgets.volume, function (widget, args)
  -- $1: Volume level, $2: Mute state
  local ismuted = {["♫"] = false, ["♩"] = true}
  -- local status_icon = {["♫"] = "", ["♩"] = "ﱝ"}
  local status_icon = {["♫"] = icons.panel.audio_on, ["♩"] = icons.panel.audio_off}
  widget:get_children_by_id("status")[1].image = status_icon[args[2]]
  widget:get_children_by_id("progress")[1]:set_value(ismuted[args[2]] and 0 or args[1] / 100)
  -- widget:get_children_by_id("progress")[1].color = color[args[2]]
  widget:get_children_by_id("percent")[1].text = ismuted[args[2]] and "0%" or args[1] .. "%"
  M.tooltip:set_text("Volume Level: " .. (ismuted[args[2]] and "0%" or args[1] .. "%"))
end, 0.2, "Master")

local volume_menu = awful.menu({
  items = {
    { 'Mute', function() awful.spawn.with_shell('amixer set Master toggle') end },
  }
})
M.widget:connect_signal('button::press', function() volume_menu:toggle() end)

return M
