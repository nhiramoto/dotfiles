local awful = require 'awful'
local gears = require 'gears'
local wibox = require 'wibox'

local keys = require 'user.keys'

local M = {}

M.buttons = gears.table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  awful.button({ keys.super }, 1,
    function(t)
      if client.focus then
        client.focus:move_to_tag(t)
      end
    end),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ keys.super }, 3,
    function(t)
      if client.focus then
        client.focus:toggle_tag(t)
      end
    end),
  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

M.widget = function (screen)
  return awful.widget.taglist {
    screen  = screen,
    filter  = awful.widget.taglist.filter.all,
    buttons = M.buttons,
    style = {
      shape = function (cr, w, h)
        gears.shape.rounded_rect(cr, w, h)
      end
    },
    layout  = {
      spacing = 5,
      layout  = wibox.layout.fixed.vertical
    },
    widget_template = {
      {
        {
          {
            align = 'center',
            valign = 'center',
            widget = wibox.widget.textbox,
            id = 'text_role'
          },
          margins = 2,
          widget = wibox.container.margin
        },
        id = 'background_role',
        widget = wibox.container.background
      },
      margins = 2,
      widget = wibox.container.margin
    }
  }
end

return M
