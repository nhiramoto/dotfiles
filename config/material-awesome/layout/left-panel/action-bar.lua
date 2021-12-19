local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local gears = require('gears')
local mat_icon = require('widget.material.icon')
local dpi = require('beautiful').xresources.apply_dpi
local icons = require('theme.icons')
local TagList = require('widget.tag-list')
local clickable_container = require('widget.material.clickable-container')

return function(screen, panel, action_bar_width, home_button_visible)
  -- Clock / Calendar 24h format
  local textclock = wibox.widget.textclock('<span font="Roboto Mono bold 11">%H\n%M</span>')

  -- Clock / Calendar 12AM/PM fornat
  -- local textclock = wibox.widget.textclock('<span font="Roboto Mono bold 11">%I\n%M</span>\n<span font="Roboto Mono bold 9">%p</span>')
  -- textclock.forced_height = 56

  -- Add a calendar (credits to kylekewley for the original code)
  local month_calendar = awful.widget.calendar_popup.month({
    screen = s,
    start_sunday = false,
    week_numbers = true
  })
  month_calendar:attach(textclock)

  local clock_widget = wibox.container.margin(textclock, dpi(13), dpi(13), dpi(8), dpi(8))

  local menu_icon = wibox.widget {
    icon = icons.menu,
    size = dpi(24),
    widget = mat_icon
  }

  local home_button = wibox.widget {
    wibox.widget {
        wibox.widget {
          menu_icon,
          widget = clickable_container
        },
        bg = beautiful.primary.hue_500,
        shape = function (cr, w, h)
          gears.shape.rounded_rect(cr, w, h, 10)
        end,
        widget = wibox.container.background
      },
    margins = dpi(5),
    widget = wibox.container.margin
  }

  home_button:buttons(
    gears.table.join(
      awful.button(
        {},
        1,
        nil,
        function()
          panel:toggle()
        end
      )
    )
  )

  panel:connect_signal(
    'opened',
    function()
      menu_icon.icon = icons.close
    end
  )

  panel:connect_signal(
    'closed',
    function()
      menu_icon.icon = icons.menu
    end
  )

  local top_buttons = nil

  if (home_button_visible) then
    top_buttons = {
        -- Left widgets
        layout = wibox.layout.fixed.vertical,
        home_button,
        -- Create a taglist widget
        TagList(screen)
    }
  else
    top_buttons = {
        -- Left widgets
        layout = wibox.layout.fixed.vertical,
        -- Create a taglist widget
        TagList(screen)
    }
  end

  local bottom_buttons = {
      -- Right widgets
      layout = wibox.layout.fixed.vertical,
      --require('widget.package-updater'),
      --require('widget.wifi'),
      -- require('widget.battery'),
      -- Clock
      --clock_widget
  }

  return wibox.widget {
    id = 'action_bar',
    layout = wibox.layout.align.vertical,
    forced_width = action_bar_width,
    top_buttons,
    --s.mytasklist, -- Middle widget
    nil,
    bottom_buttons
  }
end
