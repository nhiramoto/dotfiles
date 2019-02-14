-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
vicious = require("vicious")

--- awesome-wm-widgets (https://github.com/streetturtle/awesome-wm-widgets) {{{
-- local batteryarc_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")
-- local volumearc_widget = require("awesome-wm-widgets.volumearc-widget.volumearc")
-- local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")
-- }}}

-- {{{ awesome-arrowlain-wibar (https://github.com/Kirill-Bugaev/awesome-arrowlain-wibar)
-- -- My color schemes
-- local base16 = require("base16")
-- -- My wibars
--- local wibars = require("wibars")
-- local arrowlain = wibars.arrowlain
-- }}}

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions

terminal = "termite"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"
altkey = "Mod1"
theme_dir = os.getenv("HOME") .. "/.config/awesome/themes/"
theme = "zenburn"

-- Themes define colours, icons, font and wallpapers.
beautiful.init(theme_dir .. theme .. "/theme.lua")

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.floating,
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end}
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibar

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Widgets {{{
-- -- Gap
widsep = wibox.widget.textbox()
widsep:set_text(" ")

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                            if client.focus then
                                                client.focus:move_to_tag(t)
                                            end
                                        end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                            if client.focus then
                                                client.focus:toggle_tag(t)
                                            end
                                        end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                    -- Minimize with left click
                    -- awful.button({ }, 1, function (c)
                    --                          if c == client.focus then
                    --                              c.minimized = true
                    --                          else
                    --                              -- Without this, the following
                    --                              -- :isvisible() makes no sense
                    --                              c.minimized = false
                    --                              if not c:isvisible() and c.first_tag then
                    --                                  c.first_tag:view_only()
                    --                              end
                    --                              -- This will also un-minimize
                    --                              -- the client, if needed
                    --                              client.focus = c
                    --                              c:raise()
                    --                          end
                    --                      end),
                    awful.button({ }, 3, client_menu_toggle_fn()),
                    awful.button({ }, 4, function ()
                                            awful.client.focus.byidx(1)
                                        end),
                    awful.button({ }, 5, function ()
                                            awful.client.focus.byidx(-1)
                                        end))

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
mytextclock = wibox.widget.textclock("<span color=\"#8FAFD7\">%b %d</span>, %H:%M")
awful.tooltip({ objects = { mytextclock } }):set_text("Date & Time")

-- Battery
battery_progress = wibox.widget.progressbar()
battery_percent = wibox.widget.textbox()
battery_ispresent = wibox.widget.textbox()
battery_widget = wibox.widget {
    {
        widget = battery_ispresent,
    },
    {
        {
            widget = battery_progress,
            margins = 5,
            width = 70,
            ticks = true,
            ticks_gap = 2,
            ticks_size = 3,
        },
        {
            widget = battery_percent,
            align = 'center',
            valign = 'center',
            font = 'Exo 2 Medium 8',
        },
        layout = wibox.layout.stack
    },
    layout = wibox.layout.align.horizontal
}
awful.tooltip({ objects = { battery_widget } }):set_text("Battery Level")
function batteryLevel(widget, args)
    if args[2] <= 10 then
        return "<span font=\"DejaVu Sans 12\" color=\"#5FAF5F\"></span> (" .. args[2] .. "%)"
    elseif args[2] <= 20 then
        return "<span font=\"DejaVu Sans 12\" color=\"#5FAF5F\"></span> (" .. args[2] .. "%)"
    elseif args[2] <= 30 then
        return "<span font=\"DejaVu Sans 12\" color=\"#5FAF5F\"></span> (" .. args[2] .. "%)"
    elseif args[2] <= 40 then
        return "<span font=\"DejaVu Sans 12\" color=\"#5FAF5F\"></span> (" .. args[2] .. "%)"
    elseif args[2] <= 50 then
        return "<span font=\"DejaVu Sans 12\" color=\"#5FAF5F\"></span> (" .. args[2] .. "%)"
    elseif args[2] <= 60 then
        return "<span font=\"DejaVu Sans 12\" color=\"#5FAF5F\"></span> (" .. args[2] .. "%)"
    elseif args[2] <= 70 then
        return "<span font=\"DejaVu Sans 12\" color=\"#5FAF5F\"></span> (" .. args[2] .. "%)"
    elseif args[2] <= 80 then
        return "<span font=\"DejaVu Sans 12\" color=\"#5FAF5F\"></span> (" .. args[2] .. "%)"
    elseif args[2] <= 90 then
        return "<span font=\"DejaVu Sans 12\" color=\"#5FAF5F\"></span> (" .. args[2] .. "%)"
    else
        return "<span font=\"DejaVu Sans 12\" color=\"#5FAF5F\"></span> (" .. args[2] .. "%)"
    end
end
vicious.register(battery_progress, vicious.widgets.bat, "$2", 1, "BAT1")
vicious.register(battery_percent, vicious.widgets.bat, "<span bgcolor='black' bgalpha='40%'>$2%</span>", 32, "BAT1")
vicious.register(battery_ispresent, vicious.widgets.bat, "<span font='Exo 2 Medium 10'></span> $1", 1, "BAT1")

-- Cpu
cpu_widget = wibox.widget {
    widget = wibox.widget.graph,
    width = 50
}
awful.tooltip({ objects = { cpu_widget } }):set_text("CPU Usage")
vicious.register(cpu_widget, vicious.widgets.cpu, "$1", 1)

-- Volume
volume_progress = wibox.widget.progressbar()
volume_percent = wibox.widget.textbox()
volume_ismuted = wibox.widget.textbox()
volume_widget = wibox.widget {
    {
        widget = volume_ismuted,
    },
    {
        {
            widget = volume_progress,
            margins = 5,
            width = 70,
            ticks = true,
            ticks_gap = 2,
            ticks_size = 3,
        },
        {
            widget = volume_percent,
            align = 'center',
            valign = 'center',
            font = 'Exo 2 Medium 8',
        },
        layout = wibox.layout.stack
    },
    layout = wibox.layout.align.horizontal
}
function volumeLevel(widget, args)
    if args[2] == "Muted" then
        return "🔇"
    elseif args[1] <= 40 then
        return "🔈 " .. args[1] .. "%"
    elseif args[1] <= 70 then
        return "🔉 " .. args[1] .. "%"
    else
        return "🔊 " .. args[1] .. "%"
    end
end
awful.tooltip({ objects = { volume_widget } }):set_text("Volume")
vicious.register(volume_progress, vicious.widgets.volume, "$1", 0.5, "Master")
vicious.register(volume_percent, vicious.widgets.volume, "<span bgcolor='black' bgalpha='40%'>$1%</span>", 0.5, "Master")
vicious.register(volume_ismuted, vicious.widgets.volume, function (widget, args)
    local ismuted = {["♫"] = false, ["♩"] = true}
    if ismuted[args[2]] then
        volume_progress.color = '#8A4900'
        return "<span font='Exo 2 Medium 16' color='#8A4900'></span>"
    else
        volume_progress.color = beautiful.progressbar_fg
        return "<span font='Exo 2 Medium 16'></span>"
    end
end, 0.5, "Master")

-- Systray
systray_widget = wibox.widget.systray()
systray_widget:set_base_size(18)

-- Pacman
pacwidget = wibox.widget.textbox()
pacwidget_t = awful.tooltip({ objects = { pacwidget }, })
vicious.register(pacwidget, vicious.widgets.pkg, function (widget, args)
    local io = { popen = io.popen }
    local s = io.popen("checkupdates")

    local str = ''
    local i = 0

    for line in s:lines() do
        str = str .. line .. "\n"
        i = i + 1
    end
    pacwidget_t:set_text(str)
    s:close()
    return "PACMAN: " .. i .. "   "
end, 1800, "Arch")

-- Widgets }}}

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" }, s, awful.layout.layouts[1])

    -- Screen Wibar {{{
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.focused, tasklist_buttons)

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            widsep,
            s.mytaglist,
            widsep,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            systray_widget,
            widsep,
            cpu_widget,
            widsep,
            volume_widget,
            widsep,
            battery_widget,
            widsep,
            mytextclock,
            widsep,
            s.mylayoutbox,
        },
    }

    -- Screen Wibar }}}
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    -- awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
    --           {description = "go back", group = "tag"}),

    -- Focus
    awful.key({ modkey }, "h",
        function ()
            awful.client.focus.bydirection("left")
        end,
        {description = "focus down", group = "client"}
    ),
    awful.key({ modkey }, "j",
        function ()
            awful.client.focus.bydirection("down")
        end,
        {description = "focus down", group = "client"}
    ),
    awful.key({ modkey }, "k",
        function ()
            awful.client.focus.bydirection("up")
        end,
        {description = "focus up", group = "client"}
    ),
    awful.key({ modkey }, "l",
        function ()
            awful.client.focus.bydirection("right")
        end,
        {description = "focus up", group = "client"}
    ),
    awful.key({ altkey }, "Tab", function(c) awful.client.focus.byidx(1) end),
    awful.key({ altkey, "Shift" }, "Tab", function(c) awful.client.focus.byidx(-1) end),
    awful.key({ modkey }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    -- Move windows
    awful.key({ modkey, "Shift"   }, "h", function () awful.client.swap.bydirection("left") end,
              {description = "swap with left client", group = "client"}),
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.bydirection("down") end,
              {description = "swap with down client", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.bydirection("up")    end,
              {description = "swap with up client", group = "client"}),
    awful.key({ modkey, "Shift"   }, "l", function () awful.client.swap.bydirection("right")    end,
              {description = "swap with right client", group = "client"}),

    -- Layout manipulation
    awful.key({ modkey }, "o", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey }, "y", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    -- awful.key({ modkey,           }, "Tab",
    --     function ()
    --         awful.client.focus.history.previous()
    --         if client.focus then
    --             client.focus:raise()
    --         end
    --     end,
    --     {description = "go back", group = "client"}),
    awful.key({ modkey, "Shift"   }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Shift"   }, "Escape", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Control" }, "Escape", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey }, "=",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey }, "-",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    -- awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
    --           {description = "increase the number of columns", group = "layout"}),
    -- awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
    --           {description = "decrease the number of columns", group = "layout"}),

    -- Layout switching
    awful.key({ modkey, }, "Tab", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift" }, "Tab", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    -- Prompt
    awful.key({ modkey }, ";", function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, ".",
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
    -- awful.key({ modkey }, "p", function() menubar.show() end,
    --           {description = "show the menubar", group = "launcher"})

    awful.key({ modkey, "Control" }, "e", function(c) awful.spawn("i3lock-fancy -g -p -f 'Exo 2 Medium'") end),

    -- rofi
    awful.key({ modkey }, "space", function(c) awful.spawn("rofi -show drun") end),
    awful.key({ modkey, "Shift" }, "space", function(c) awful.spawn("rofi -show run") end),
    -- Programs
    awful.key({ modkey }, "w", function(c) awful.spawn("qutebrowser") end,
        { description = "Open the browser", group = "launcher" }),
    awful.key({ modkey }, "e", function(c) awful.spawn("gedit") end,
        { description = "Open GUI Text Editor", group = "launcher" }),
    awful.key({ modkey }, "r", function(c) awful.spawn(terminal .. " -e ranger") end,
        { description = "Open file manager", group = "launcher" }),
    awful.key({ modkey }, "n", function(c) awful.spawn(terminal .. " -e ncmpcpp") end,
        { description = "Open mpd interface (ncmpcpp)", group = "launcher" }),
    awful.key({ modkey, "Shift" }, "h", function(c) awful.spawn(terminal .. " -e htop") end,
        { description = "Open htop", group = "launcher" }),

    -- Media Keys
    awful.key({ }, "XF86AudioRaiseVolume", function(d) awful.spawn("amixer set Master 5%+") end),
    awful.key({ }, "XF86AudioLowerVolume", function(d) awful.spawn("amixer set Master 5%-") end),
    awful.key({ }, "XF86AudioMute", function(d) awful.spawn("amixer set Master toggle") end),

    awful.key({ }, "XF86MonBrightnessUp", function(d) awful.spawn("xbacklight -inc 5") end),
    awful.key({ }, "XF86MonBrightnessDown", function(d) awful.spawn("xbacklight -dec 5") end),

    awful.key({ }, "XF86AudioPlay", function(d) awful.spawn.with_shell("mpc toggle || playerctl play-pause") end),
    awful.key({ }, "XF86AudioNext", function(d) awful.spawn.with_shell("mpc next || playerctl next") end),
    awful.key({ }, "XF86AudioPrev", function(d) awful.spawn.with_shell("mpc prev || playerctl previous") end),
    awful.key({ }, "XF86AudioStop", function(d) awful.spawn.with_shell("mpc stop || playerctl stop") end)
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Shift"   }, "f",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey, "Shift" }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey, }, "b", function(c) awful.screen.focused().mywibox.visible = not awful.screen.focused().mywibox.visible end,
              { description = "Hide top bar", group = "client" }),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
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
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
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
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
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
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
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
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true }
    },

    -- Assign Programs to Tags
    { rule_any = { class = { "qutebrowser", "Google-chrome", "Firefox" } },
      properties = { screen = 1, tag = "1" } },

    -- Docks and panels
    { rule_any = { class = { "Polybar" } },
      properties = {
        focusable = false,
        floating = true,
        sticky = true,
        ontop = false,
        below = true,
      }
    }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
    -- Enable round corners with the shape api
    c.shape = function(cr,w,h)
        gears.shape.rounded_rect(cr,w,h,6)
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

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.closebutton    (c),
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.iconwidget(c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
--     if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
--         and awful.client.focus.filter(c) then
--         client.focus = c
--     end
-- end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Fullscreen
client.connect_signal("property::fullscreen", function (c)
    if c.fullscreen and c == client.focus then
        mouse.screen.visible = false
        c.floating = true
        c.shape = function(cr,w,h)
            gears.shape.rounded_rect(cr,w,h,0)
        end
    else
        mouse.screen.visible = true
        c.floating = false
        c.shape = function(cr,w,h)
            gears.shape.rounded_rect(cr,w,h,6)
        end
    end
end)

-- }}}

-- Autostart {{{
awful.spawn.with_shell(os.getenv("HOME") .. "/.config/awesome/autorun.sh")
-- }}}

