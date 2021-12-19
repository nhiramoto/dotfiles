local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local TaskList = require('widget.task-list')
local gears = require('gears')
local clickable_container = require('widget.material.clickable-container')
local mat_icon_button = require('widget.material.icon-button')
local mat_icon = require('widget.material.icon')
local awwidgets_volume = require('awesome-wm-widgets.volume-widget.volume')
local awwidgets_spotify = require('awesome-wm-widgets.spotify-widget.spotify')
local awwidgets_calendar = require('awesome-wm-widgets.calendar-widget.calendar')
local awwidgets_cpu = require('awesome-wm-widgets.cpu-widget.cpu-widget')
local awwidgets_fswidget = require('awesome-wm-widgets.fs-widget.fs-widget')

local dpi = require('beautiful').xresources.apply_dpi

local icons = require('theme.icons')

beautiful.systray_icon_spacing = dpi(15)

-- Clock / Calendar 24h format
local textclock = wibox.widget.textclock('<span font="Roboto Mono bold 11">%d/%m/%Y | %H:%M</span>')

-- Clock / Calendar 12AM/PM fornat
-- local textclock = wibox.widget.textclock('<span font="Roboto Mono bold 9">%d.%m.%Y\n  %I:%M %p</span>\n<span font="Roboto Mono bold 9">%p</span>')
-- textclock.forced_height = 56

local systray = wibox.widget.systray()
systray:set_horizontal(true)
systray:set_base_size(26)

local systray_container = wibox.container {
  wibox.container {
    systray,
    direction = 'north',
    widget = wibox.container.rotate
  },
  margins = dpi(5),
  widget = wibox.container.margin
}

local volume_widget = wibox.container {
  awwidgets_volume {
    widget_type = 'icon_and_text',
    font = 'Roboto 11'
  },
  left = dpi(20),
  right = dpi(20),
  widget = wibox.container.margin
}

local spotify_widget = wibox.container {
  awwidgets_spotify {
    font = 'Roboto 11',
    play_icon = '/usr/share/icons/Papirus-Light/24x24/categories/spotify.svg',
    pause_icon = '/usr/share/icons/Papirus-Dark/24x24/panel/spotify-indicator.svg',
    dim_when_paused = true
  },
  margins = dpi(10),
  widget = wibox.container.margin
}

local calendar_widget = awwidgets_calendar {
  theme = 'nord',
  placement = 'top_right',
  start_sunday = true,
  radius = 8
}
textclock:connect_signal('button::press', function (_, _, _, button)
  if button == 1 then calendar_widget.toggle() end
end)

local cpu_widget = wibox.container {
  awwidgets_cpu {
    width = 80,
    step_width = 4,
    step_spacing = 2,
    color = '#4C5DBA'
  },
  margins = dpi(10),
  widget = wibox.container.margin
}

local fs_widget = wibox.container {
  awwidgets_fswidget(),
  margins = dpi(10),
  widget = wibox.container.margin
}

local clock_widget = wibox.container.margin(textclock, dpi(11), dpi(11), dpi(6), dpi(6))

local add_button = mat_icon_button(mat_icon(icons.plus, dpi(24)))
add_button:buttons(
  gears.table.join(
    awful.button(
      {},
      1,
      nil,
      function()
        awful.spawn(
          awful.screen.focused().selected_tag.defaultApp,
          {
            tag = _G.mouse.screen.selected_tag,
            placement = awful.placement.bottom_right
          }
        )
      end
    )
  )
)

-- Create an imagebox widget which will contains an icon indicating which layout we're using.
-- We need one layoutbox per screen.
local LayoutBox = function(s)
  local layoutBox = clickable_container(awful.widget.layoutbox(s))
  layoutBox:buttons(
    awful.util.table.join(
      awful.button(
        {},
        1,
        function()
          awful.layout.inc(1)
        end
      ),
      awful.button(
        {},
        3,
        function()
          awful.layout.inc(-1)
        end
      ),
      awful.button(
        {},
        4,
        function()
          awful.layout.inc(1)
        end
      ),
      awful.button(
        {},
        5,
        function()
          awful.layout.inc(-1)
        end
      )
    )
  )
  return layoutBox
end

local TopPanel = function(s, offset)
  local offsetx = 0
  if offset == true then
    offsetx = dpi(48)
  end
  local panel =
    wibox(
    {
      ontop = true,
      screen = s,
      height = dpi(38),
      width = s.geometry.width - offsetx,
      x = s.geometry.x + offsetx,
      y = s.geometry.y,
      stretch = false,
      bg = beautiful.background.hue_800,
      fg = beautiful.fg_normal,
      struts = {
        top = dpi(38)
      }
    }
  )

  panel:struts(
    {
      top = dpi(38)
    }
  )

  panel:setup {
    layout = wibox.layout.align.horizontal,
    {
      layout = wibox.layout.fixed.horizontal,
      -- Create a taglist widget
      TaskList(s),
      add_button
    },
    nil,
    {
      layout = wibox.layout.fixed.horizontal,
      cpu_widget,
      fs_widget,
      spotify_widget,
      -- System tray
      systray_container,
      require('widget.package-updater'),
      volume_widget,
      -- require('widget.wifi'),
      -- Clock
      clock_widget,
      -- Layout box
      LayoutBox(s)
    }
  }

  return panel
end

return TopPanel
