local gears = require'gears'
local awful = require'awful'

local M = {}

M.buttons = gears.table.join(
  -- Scroll focus
  awful.button({ }, 4,
    function ()
      awful.client.focus.byidx(1)
    end),
  awful.button({ }, 5,
    function ()
      awful.client.focus.byidx(-1)
    end)
)

M.widget = function(screen)
  return awful.widget.tasklist(screen, awful.widget.tasklist.filter.focused, M.buttons)
end

return M
