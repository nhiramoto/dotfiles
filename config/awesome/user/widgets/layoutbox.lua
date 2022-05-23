local awful = require'awful'
local gears = require'gears'

local M = {}

M.widget = function(screen)
  local widget = awful.widget.layoutbox(screen)
  widget:buttons(gears.table.join(
    awful.button({}, 1, function() awful.layout.inc(1) end),
    awful.button({}, 3, function() awful.layout.inc(-1) end),
    awful.button({}, 4, function() awful.layout.inc(1) end),
    awful.button({}, 5, function() awful.layout.inc(-1) end)
  ))
  return widget
end

return M
