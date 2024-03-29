--Imports {{{
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
-- Autofocus when tag switching
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local vicious = require("vicious")

local apps = require 'user.apps'
local theme = require 'user.theme'
local layout = require 'user.layout'

-- Error handling {{{
-- Startup errors
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Runtime errors
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
    end)
end
-- }}}

-- Variables {{{

local super_key = "Mod4"
local ctrl_key = "Control"
local alt_key = "Mod1"
local shift_key = "Shift"

-- Define Layouts
awful.layout.layouts = {
    awful.layout.suit.spiral,
    awful.layout.suit.tile,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating,
}

-- Naughty (Notifications)
naughty.config.defaults.margin = theme.notification_margin
naughty.config.padding = 10

-- }}}

-- Popups {{{

local volume_popup = awful.popup {
    widget = {
        widget = wibox.container.margin,
        margins = 20,
        {
            layout = wibox.layout.fixed.vertical,
            spacing = 20,
            {
                widget = wibox.container.place,
                halign = 'center',
                {
                    widget = wibox.widget.imagebox,
                    -- image = theme.status_audio_on_huge,
                    forced_height = 96,
                    forced_width = 96
                },
            },
            {
                widget = wibox.container.place,
                halign = 'center',
                {
                    widget = wibox.widget.textbox,
                    id = 'percent',
                    align = 'center',
                    valign = 'center',
                    font = theme.font_big
                }
            },
            {
                widget = wibox.container.place,
                halign = 'center',
                {
                    widget = wibox.widget.progressbar,
                    id = 'progress',
                    ticks = true,
                    forced_height = 10,
                    forced_width = 150,
                    shape = function(cr, w, h)
                        gears.shape.rounded_rect(cr, w, h, 4)
                    end,
                    bar_shape = function(cr, w, h)
                        gears.shape.rounded_rect(cr, w, h, 4)
                    end
                }
            }
        }
    },
    shape = function (c, w, h)
        gears.shape.rounded_rect(c, w, h, 8)
    end,
    border_width = 0,
    border_color = theme.border_focus,
    placement = awful.placement.centered,
    ontop = true,
    opacity = 0.9,
    width = 100,
    visible = false
}
local volume_popup_timer = gears.timer {
    timeout = 1,
    single_shot = true,
    callback = function()
        volume_popup.visible = false
    end
}
local show_volume_popup = function()
    volume_popup.visible = true
    volume_popup_timer:again()
end
vicious.register(volume_popup.widget, vicious.widgets.volume, function (widget, args)
    -- $1: Volume level, $2: Mute state
    local ismuted = {['♫'] = false, ['♩'] = true}
    widget:get_children_by_id('progress')[1]:set_value(ismuted[args[2]] and 0 or args[1] / 100)
    widget:get_children_by_id("percent")[1].text = (ismuted[args[2]] and "0%" or args[1] .. "%")
end, 1, "Master")

-- }}}

-- Functions {{{
local function set_wallpaper(s)
    -- Wallpaper
    if theme.wallpaper then
        local wallpaper = theme.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Placement
local placeon_bottomright_scaled = awful.placement.bottom_right + awful.placement.scale

-- }}}

-- {{{ Menu
-- Sub Menu

-- Menubar configuration
menubar.utils.terminal = apps.default.terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibar

-- Widgets {{{

-- Separators and Borders
local spr = wibox.container {
    widget = wibox.container.margin,
    margins = 2
}
local spr5px = wibox.container {
    widget = wibox.container.margin,
    margins = 5
}

-- Cpu
local cpu_widget = wibox.widget {
    widget = wibox.widget.graph,
    width = 50,
    color = theme.graph_fg1,
    background_color = theme.graph_bg_normal,
}
local cpu_tooltip = awful.tooltip {
    objects = { cpu_widget },
    text = "CPU Usage",
    mode = "outside",
    preferred_alignments = { "middle", "front", "back" }
}
-- vicious.register(cpu_widget, vicious.widgets.cpu, "$1", 3)

local mem_widget = wibox.widget {
    widget = wibox.widget.graph,
    width = 50,
    color = theme.graph_fg2,
    background_color = theme.graph_bg_normal,
}
local mem_tooltip = awful.tooltip {
    objects = { mem_widget },
    text = "Memory Usage",
    mode = "outside",
    preferred_alignments = { "middle", "front", "back" }
}
-- vicious.register(mem_widget, vicious.widgets.mem, "$1", 3)

local system_usage_widget = wibox.container {
    widget = wibox.container.margin,
    margins = 2,
    {
        widget = wibox.container.background,
        shape = function (cr, w, h)
            gears.shape.rounded_rect(cr, w, h, 2)
        end,
        shape_clip = true,
        shape_border_width = 0,
        shape_border_color = theme.widget_border_color,
        {
            layout = wibox.layout.fixed.horizontal,
            {
                widget = cpu_widget
            },
            {
                widget = mem_widget
            }
        }
    }
}

-- Widgets }}}

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    layout.setup(s)

end)

-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end)
    -- awful.button({ }, 4, awful.tag.viewnext),
    -- awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ super_key }, "g", function(c) volume_tooltip.visible = not volume_tooltip.visible end),

    awful.key({ super_key }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ super_key }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ super_key }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ ctrl_key, alt_key }, "a", awful.tag.viewprev,
              { description = "Go to the previous tag.", group = "tag" }),
    awful.key({ ctrl_key, alt_key }, "d", awful.tag.viewnext,
              { description = "Go to the next tag.", group = "tag" }),
    awful.key({ ctrl_key, alt_key }, "w", awful.tag.viewprev,
              { description = "Go to the previous tag.", group = "tag" }),
    awful.key({ ctrl_key, alt_key }, "s", awful.tag.viewnext,
              { description = "Go to the next tag.", group = "tag" }),

    -- Focus
    awful.key({ super_key }, "h",
        function ()
            awful.client.focus.bydirection("left")
        end,
        { description = "Focus left.", group = "client" }
    ),
    awful.key({ super_key }, "j",
        function ()
            awful.client.focus.bydirection("down")
        end,
        { description = "Focus down.", group = "client" }
    ),
    awful.key({ super_key }, "k",
        function ()
            awful.client.focus.bydirection("up")
        end,
        { description = "Focus up.", group = "client"}
    ),
    awful.key({ super_key }, "l",
        function ()
            awful.client.focus.bydirection("right")
        end,
        { description = "Focus right.", group = "client"}
    ),
    awful.key({ alt_key }, "Tab", function(c) awful.client.focus.byidx(1) end),
    awful.key({ alt_key, shift_key }, "Tab", function(c) awful.client.focus.byidx(-1) end),

    awful.key({ super_key }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    -- Move windows
    awful.key({ super_key, shift_key }, "h", function () awful.client.swap.bydirection("left") end,
              { description = "Swap with left client.", group = "client" }),
    awful.key({ super_key, shift_key }, "j", function () awful.client.swap.bydirection("down") end,
              { description = "Swap with down client.", group = "client" }),
    awful.key({ super_key, shift_key }, "k", function () awful.client.swap.bydirection("up") end,
              { description = "Swap with up client.", group = "client" }),
    awful.key({ super_key, shift_key }, "l", function () awful.client.swap.bydirection("right") end,
              { description = "swap with right client.", group = "client" }),

    -- Focus monitors.
    awful.key({ super_key }, "o", function () awful.screen.focus_relative( 1) end,
              { description = "Focus the next monitor.", group = "screen"}),
    awful.key({ super_key }, "y", function () awful.screen.focus_relative(-1) end,
              { description = "Focus the previous monitor.", group = "screen"}),

    awful.key({ super_key, shift_key   }, "w", function () mymainmenu:show() end,
              {description = "Show main menu.", group = "awesome"}),

    -- Standard program
    awful.key({ super_key }, "Return", function () awful.spawn(apps.default.terminal) end,
              { description = "Open a terminal.", group = "launcher" }),
    awful.key({ super_key, ctrl_key   }, "r", awesome.restart,
              { description = "reload awesome", group = "awesome" }),
    awful.key({ super_key, ctrl_key }, "q", awesome.quit,
              { description = "quit awesome", group = "awesome" }),

    awful.key({ super_key, ctrl_key }, "l", function () awful.tag.incmwfact( 0.05) end,
              {description = "Increase master width factor", group = "layout"}),
    awful.key({ super_key, ctrl_key }, "h", function () awful.tag.incmwfact(-0.05) end,
              {description = "Decrease master width factor", group = "layout"}),
    awful.key({ super_key }, "=",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "Increase the number of master clients", group = "layout"}),
    awful.key({ super_key }, "-",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "Decrease the number of master clients", group = "layout"}),

    -- Layout switching
    awful.key({ super_key, }, "Tab", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ super_key, shift_key }, "Tab", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    -- Prompt
    awful.key({ super_key }, ";", function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ super_key }, ".",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    -- awful.key({ super_key }, "p", function() menubar.show() end,
    --           {description = "show the menubar", group = "launcher"})

    -- Lock Screen
    awful.key({ super_key, ctrl_key }, "e", function(c) awful.spawn("i3lock-fancy -p") end),

    -- Reload Xresources
    awful.key({ super_key, shift_key }, "x", function(c) awful.spawn.with_shell("xrdb " .. os.getenv("HOME") .. "/.Xresources") end),

    -- rofi
    awful.key({ super_key }, "space", function(c) awful.spawn("rofi -show drun") end),
    awful.key({ super_key, shift_key }, "space", function(c) awful.spawn("rofi -show run") end),
    -- Programs
    awful.key({ super_key }, "w", function(c) awful.spawn("google-chrome-stable") end,
        { description = "Open the browser", group = "launcher" }),
    awful.key({ super_key }, "e", function(c) awful.spawn(apps.default.editor) end,
        { description = "Open GUI Text Editor", group = "launcher" }),
    awful.key({ super_key }, "r", function(c) awful.spawn(apps.default.terminal .. " -e ranger") end,
        { description = "Open file manager", group = "launcher" }),
    awful.key({ super_key }, "n", function(c) awful.spawn(apps.default.terminal .. " -e ncmpcpp") end,
        { description = "Open mpd interface (ncmpcpp)", group = "launcher" }),

    -- Media Keys
    awful.key({ }, "XF86AudioRaiseVolume", function(d)
        awful.spawn.with_shell("amixer set Master 5%+")
        show_volume_popup()
    end),
    awful.key({ }, "XF86AudioLowerVolume", function(d)
        awful.spawn.with_shell("amixer set Master 5%-")
        show_volume_popup()
    end),
    awful.key({ }, "XF86AudioMute", function(d)
        awful.spawn.with_shell("amixer set Master toggle")
        show_volume_popup()
    end),

    awful.key({ }, "XF86MonBrightnessUp", function(d) awful.spawn.with_shell("xbacklight -inc 5") end),
    awful.key({ }, "XF86MonBrightnessDown", function(d) awful.spawn.with_shell("xbacklight -dec 5") end),

    awful.key({ }, "XF86AudioPlay", function(d) awful.spawn.with_shell("mpc toggle || playerctl play-pause") end),
    awful.key({ }, "XF86AudioNext", function(d) awful.spawn.with_shell("mpc next || playerctl next") end),
    awful.key({ }, "XF86AudioPrev", function(d) awful.spawn.with_shell("mpc prev || playerctl previous") end),
    awful.key({ }, "XF86AudioStop", function(d) awful.spawn.with_shell("mpc stop || playerctl stop") end)
)

clientkeys = gears.table.join(
    awful.key({ super_key, shift_key }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ super_key }, "f",  awful.client.floating.toggle,
              {description = "toggle floating", group = "client"}),
    awful.key({ super_key }, "q", function (c) c:kill() end,
              {description = "close", group = "client"}),
    awful.key({ super_key, ctrl_key }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ super_key, shift_key }, "o", function (c) c:move_to_screen() end,
              {description = "move to screen", group = "client"}),
    awful.key({ super_key }, "t", function (c) c.ontop = not c.ontop end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ super_key }, "b", function(c) awful.screen.focused().mywibox.visible = not awful.screen.focused().mywibox.visible end,
              { description = "Hide top bar", group = "client" }),
    awful.key({ super_key }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ super_key, ctrl_key }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ super_key, shift_key   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 10 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ super_key }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ super_key, ctrl_key }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ super_key, shift_key }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ super_key, ctrl_key, shift_key }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ super_key }, 1, awful.mouse.client.move),
    awful.button({ super_key }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients
    {
        rule = { },
        properties = {
            border_width = theme.border_width,
            border_color = theme.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen,
        }
    },

    -- Normal and dialog clients
    {
        rule_any = { type = { "normal", "dialog" } },
        properties = {
            titlebars_enabled = false
        }
    },

    -- Floating clients.
    {
        rule_any = {
            instance = {
                "DTA",  -- Firefox addon DownThemAll.
                "copyq",  -- Includes session name in class.
            },
            class = {
                "Arandr",
                "Gpick",
                "Kruler",
                "MessageWin",  -- kalarm.
                "Sxiv",
                "Wpa_gui",
                "pinentry",
                "veromix",
                "xtightvncviewer",
                "VirtualBox",
                "VirtualBox Manager",
                "VirtualBox Machine",
                "mpv",
                "Polybar"
            },
            name = {
                "Event Tester",  -- xev.
            },
            role = {
                "AlarmWindow",  -- Thunderbird's calendar.
                "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
                "vlc-media-info", -- vlc current media information dialog
            }
        },
        properties = {
            floating = true,
            placement = awful.placement.centered
        }
    },

    -- Popup clients.
    {
        rule_any = {
            role = { "pop-up", "GtkFileChooserDialog" }
        },
        properties = {
            floating = true,
            placement = awful.placement.centered,
            above = true,
        }
    },

    -- Picture N Picture
    {
        rule_any = {
            class = { "mpv", "feh" }
        },
        properties = {
            floating = true,
            ontop = true,
            sticky = true,
            role = "pnp",
            placement = function (c)
                placeon_bottomright_scaled(c, { to_percent = 0.3, margins = 20 })
            end
        }
    },

    -- Docks and panels
    {
        rule_any = { class = { "Polybar" } },
        properties = {
            focusable = false,
            floating = true,
            sticky = true,
            ontop = false,
            below = true,
        }
    },

    -- Assign Programs to Tags
    {
        rule_any = { class = { "qutebrowser", "Google-chrome", "Firefox" } },
        properties = {
            screen = 1,
            tag = "1",
            ontop = false,
            floating = false,
            maximized = false
        }
    }
}
-- }}}

-- {{{ Signals
-- New client appears
client.connect_signal("manage", function (c)
    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end

    -- Restore Picture N Picture
    if c.class == "mpv" or c.class == "feh" then
        c:connect_signal("property::size", function ()
            if not c.fullscreen then
                awful.placement.bottom_right(c, { margins = 20 })
                c.ontop = true
            end
        end)
    end
end)

client.connect_signal("property::geometry", function (c)
    if c.floating == true or #c.screen.tiled_clients > 1 then
        c.border_width = theme.border_width
        c.border_color = theme.border_normal
    elseif not c.floating and #c.screen.tiled_clients == 1 then
        c.border_width = 0
        c.shape = gears.shape.rectangle
     else
         for _, client in pairs(c.screen.tiled_clients) do
             client.border_width = theme.border_width
             client.border_color = theme.border_normal
             client.shape = function(cr,w,h)
                 gears.shape.rounded_rect(cr, w, h, 6)
             end
        end
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    local titlebar = awful.titlebar(c, {
        size = 22
    })
end)

screen.connect_signal("property::geometry", function(s)
    set_wallpaper()
    awful.spawn.with_shell(os.getenv('HOME') .. '/.config/conky/launch.sh')
end)

client.connect_signal("focus", function(c) c.border_color = theme.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = theme.border_normal end)

-- Fullscreen
client.connect_signal("property::fullscreen", function (c)
    if c.fullscreen and c == client.focus then
        mouse.screen.visible = false
        -- c.floating = true
        -- c.shape = function(cr,w,h)
        --     gears.shape.rounded_rect(cr,w,h,0)
        -- end
    else
        mouse.screen.visible = true
        -- c.floating = false
        -- c.shape = function(cr,w,h)
        --     gears.shape.rounded_rect(cr,w,h,6)
        -- end
    end
end)

-- }}}

-- Autostart {{{
awful.spawn.with_shell(os.getenv("HOME") .. "/.config/awesome/autorun.sh")
-- }}}


