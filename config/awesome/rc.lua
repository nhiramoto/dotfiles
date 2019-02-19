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
local vicious = require("vicious")

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
        in_error = false
    end)
end
-- }}}

-- Variables {{{

local super_key = "Mod4"
local ctrl_key = "Control"
local alt_key = "Mod1"
local shift_key = "Shift"

local terminal = "urxvt"
local editor = os.getenv("EDITOR") or "vim"
local editor_cmd = terminal .. " -e " .. editor
local awesome_config_file = os.getenv("HOME") .. "/.config/awesome/rc.lua"
local theme_dir = os.getenv("HOME") .. "/.config/awesome/themes/"
local theme = "nhtoshiaki"

-- Load theme
beautiful.init(theme_dir .. theme .. "/theme.lua")

-- Define Layouts
awful.layout.layouts = {
    awful.layout.suit.spiral,
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.floating,
}

-- Hotkeys Popup
hotkeys_popup.merge_duplicates = true
-- }}}

-- Functions {{{
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
-- }}}

-- {{{ Menu
-- Sub Menu
local myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome_config_file },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end}
}

-- Root menu
local mymainmenu = awful.menu({
    items = {
        { "awesome", myawesomemenu, beautiful.awesome_icon },
        { "open terminal", terminal }
    }
})

-- Bar menu
local mylauncher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = mymainmenu
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibar

-- Widgets {{{

-- Gap
local widsep = wibox.widget.textbox()
widsep:set_text("   ")

-- Tags Buttons
local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ super_key }, 1,
        function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ super_key }, 3,
        function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

-- Tasks Buttons (Opened windows)
local tasklist_buttons = gears.table.join(
    -- Scroll focus
    awful.button({ }, 4,
        function ()
            awful.client.focus.byidx(1)
        end),
    awful.button({ }, 5,
        function ()
            awful.client.focus.byidx(-1)
        end))

-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
local mytextclock = wibox.widget.textclock("<span color=\"#8FAFD7\">%b %d</span>, %H:%M")
awful.tooltip({ objects = { mytextclock } }):set_text("Date & Time")

-- Battery
local battery_progress = wibox.widget.progressbar()
local battery_percent = wibox.widget.textbox()
local battery_ispresent = wibox.widget.textbox()
local battery_widget = wibox.widget {
    {
        widget = battery_ispresent,
    },
    {
        {
            widget = battery_progress,
            margins = 5,
            width = 70,
            ticks = false,
            -- ticks_gap = 2,
            -- ticks_size = 3,
            shape = gears.shape.rounded_bar,
            color = beautiful.progressbar_fg_normal,
            background_color = beautiful.progressbar_bg_normal,
        },
        {
            widget = battery_percent,
            align = 'center',
            valign = 'center',
            font = beautiful.font_small,
        },
        layout = wibox.layout.stack
    },
    layout = wibox.layout.align.horizontal
}
awful.tooltip({ objects = { battery_widget } }):set_text("Battery Level")
local function batteryLevel(widget, args)
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
vicious.register(battery_progress, vicious.widgets.bat, "$2", 1, "BAT0")
vicious.register(battery_percent, vicious.widgets.bat, "<span bgcolor='black' bgalpha='40%'>$2%</span>", 32, "BAT0")
vicious.register(battery_ispresent, vicious.widgets.bat, "<span font='Exo 2 Medium 10'></span> $1", 1, "BAT0")

-- Cpu
local cpu_widget = wibox.widget {
    widget = wibox.widget.graph,
    width = 50,
    color = beautiful.graph_fg1,
    background_color = beautiful.graph_bg_normal,
}
awful.tooltip({ objects = { cpu_widget } }):set_text("CPU Usage")
vicious.register(cpu_widget, vicious.widgets.cpu, "$1", 1)

local mem_widget = wibox.widget {
    widget = wibox.widget.graph,
    width = 50,
    color = beautiful.graph_fg2,
    background_color = beautiful.graph_bg_normal,
}
awful.tooltip({ objects = { mem_widget } }):set_text("Memory Usage")
vicious.register(mem_widget, vicious.widgets.mem, "$1", 1)

-- Volume
local volume_progress = wibox.widget.progressbar()
local volume_percent = wibox.widget.textbox()
local volume_ismuted = wibox.widget.textbox()
local volume_widget = wibox.widget {
    {
        widget = volume_ismuted,
    },
    {
        {
            widget = volume_progress,
            margins = 5,
            width = 70,
            ticks = false,
            -- ticks_gap = 2,
            -- ticks_size = 3,
            shape = gears.shape.rounded_bar,
            color = beautiful.progressbar_fg_normal,
            background_color = beautiful.progressbar_bg_normal,
        },
        {
            widget = volume_percent,
            align = 'center',
            valign = 'center',
            font = beautiful.font,
        },
        layout = wibox.layout.stack
    },
    layout = wibox.layout.align.horizontal
}
local function volumeLevel(widget, args)
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
vicious.register(volume_progress, vicious.widgets.volume, "$1", 0.2, "Master")
vicious.register(volume_percent, vicious.widgets.volume, "<span bgcolor='black' bgalpha='40%'>$1%</span>", 0.2, "Master")
vicious.register(volume_ismuted, vicious.widgets.volume, function (widget, args)
    local ismuted = {["♫"] = false, ["♩"] = true}
    if ismuted[args[2]] then
        volume_progress.color = beautiful.progressbar_fg_disabled
        return "<span font='Exo 2 Medium 16' color='#8A4900'></span>"
    else
        volume_progress.color = beautiful.progressbar_fg_normal
        return "<span font='Exo 2 Medium 16'></span>"
    end
end, 0.2, "Master")

-- Systray
local systray_widget = wibox.widget.systray()
systray_widget:set_base_size(16)

-- Pacman
local pacwidget = wibox.widget.textbox()
local pacwidget_t = awful.tooltip({ objects = { pacwidget }, })
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
    s.mytaglist = awful.widget.taglist{
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        style   = {
            -- shape = gears.shape.powerline
        },
        layout   = {
            spacing = 5,
            spacing_widget = {
                color  = beautiful.bg_normal,
                -- shape  = gears.shape.powerline,
                widget = wibox.widget.separator,
            },
            layout  = wibox.layout.fixed.horizontal
        },
        buttons = taglist_buttons,
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.focused, tasklist_buttons)

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
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
            widsep,
            cpu_widget,
            widsep,
            mem_widget,
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
    awful.button({ }, 3, function () mymainmenu:toggle() end)
    -- awful.button({ }, 4, awful.tag.viewnext),
    -- awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
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
    awful.key({ super_key }, "Return", function () awful.spawn(terminal) end,
              { description = "Open a terminal.", group = "launcher" }),
    awful.key({ super_key, shift_key   }, "Escape", awesome.restart,
              { description = "reload awesome", group = "awesome" }),
    awful.key({ super_key, ctrl_key }, "Escape", awesome.quit,
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
    awful.key({ super_key }, "e", function(c) awful.spawn(terminal .. " -e vim") end,
        { description = "Open GUI Text Editor", group = "launcher" }),
    awful.key({ super_key }, "r", function(c) awful.spawn(terminal .. " -e ranger") end,
        { description = "Open file manager", group = "launcher" }),
    awful.key({ super_key }, "n", function(c) awful.spawn(terminal .. " -e ncmpcpp") end,
        { description = "Open mpd interface (ncmpcpp)", group = "launcher" }),

    -- Media Keys
    awful.key({ }, "XF86AudioRaiseVolume", function(d) awful.spawn.with_shell("amixer set Master 5%+") end),
    awful.key({ }, "XF86AudioLowerVolume", function(d) awful.spawn.with_shell("amixer set Master 5%-") end),
    awful.key({ }, "XF86AudioMute", function(d) awful.spawn.with_shell("amixer set Master toggle") end),

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
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
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
        properties = { floating = true }
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
        properties = { screen = 1, tag = "1" }
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
    if c.floating == true then
        c.shape = function(cr,w,h)
            gears.shape.rounded_rect(cr,w,h,6)
        end
    elseif #c.screen.tiled_clients == 1 then
        c.border_width = 0
        c.shape = gears.shape.rectangle
    else
        for _, client in pairs(c.screen.tiled_clients) do
            client.border_width = 2
            client.shape = function(cr,w,h)
                gears.shape.rounded_rect(cr,w,h,6)
            end
        end
    end
end)

client.connect_signal("unmanage", function (c)
    if #c.screen.tiled_clients == 1 then
        for _, client in pairs(c.screen.tiled_clients) do
            client.border_width = 0
            client.shape = gears.shape.rectangle
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

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.closebutton    (c),
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            -- awful.titlebar.widget.stickybutton   (c),
            -- awful.titlebar.widget.ontopbutton    (c),
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

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

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

