----------------------------------------------------------
--  "nhtoshiaki" awesome theme                          --
--    Based on "apprentice" color theme from vim        --
--    By nhtoshiaki                                     --
----------------------------------------------------------

local gears = require("gears")
local theme_assets = require("beautiful.theme_assets")
local themes_path = os.getenv("HOME") .. "/.config/awesome/themes"
local thistheme_path = themes_path .. "/nhtoshiaki"
local dpi = require("beautiful.xresources").apply_dpi

local theme = {}

theme.color = {
    white = "#ABB2BF",
    black = "#121212",
    black2 = "#282C34",
    blue = "#61AFEF",
    green = "#98C379",
    yellow = "#5C07B",
    red = "#E06C75"
}

-- {{{ Styles

theme.panel           = theme.color.black

-- {{{ Fonts
theme.font      = "BlexMono Nerd Font Semibold 10"
theme.font_small = "BlexMono Nerd Font Semibold 9"
theme.font_big = "BlexMono Nerd Font Semibold 12"
theme.font_extra = "BlexMono Nerd Font Semibold 14"
-- }}}

-- fg/bg colors {{{

theme.fg_normal  = theme.color.white
theme.bg_normal  = theme.color.black
theme.fg_focus   = theme.bg_normal
theme.bg_focus   = theme.color.blue
theme.fg_urgent  = theme.bg_normal
theme.bg_urgent  = theme.color.red
theme.bg_systray = theme.panel

-- }}}

-- {{{ Borders
theme.useless_gap   = dpi(2)
theme.gap_single_client = false
theme.border_width  = dpi(2)
theme.border_normal = theme.bg_normal
theme.border_focus  = theme.bg_focus
theme.border_marked = theme.color.yellow
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = theme.bg_normal
theme.titlebar_bg_normal = theme.bg_normal
-- }}}

-- {{{ Taglist
theme.taglist_fg_normal = theme.fg_normal
theme.taglist_fg_focus = theme.bg_normal
theme.taglist_fg_occupied = theme.bg_focus
theme.taglist_fg_urgent = theme.fg_urgent
theme.taglist_bg_normal = theme.color.red
theme.taglist_bg_focus = theme.bg_focus
theme.taglist_bg_urgent = theme.bg_urgent
-- }}}

-- {{{ Tasklist
theme.tasklist_fg_normal = theme.fg_normal
theme.tasklist_fg_focus = theme.fg_normal
theme.tasklist_bg_normal = theme.panel
theme.tasklist_bg_focus = theme.panel
-- }}}

-- {{{ Tooltip
theme.tooltip_fg = theme.fg_normal
theme.tooltip_bg = theme.bg_normal
theme.tooltip_shape = function (cr, w, h)
    gears.shape.partially_rounded_rect(cr, w, h, false, false, true, true, 5)
end
-- }}}

-- {{{ Notification
theme.notification_bg = theme.bg_normal
theme.notification_fg = theme.fg_normal
-- theme.notification_font = theme.font
theme.notification_border_width = 10
theme.notification_border_color = theme.notification_bg
theme.notification_max_width = dpi(400)
theme.notification_icon_size = dpi(64)
theme.notification_margin = dpi(12)
theme.notification_font = theme.font
theme.notification_shape = function(cr, width, height)
    gears.shape.partially_rounded_rect(cr, width, height, true, false, true, true)
end
-- }}}

-- {{{ Hotkeys Popup
theme.hotkeys_font = theme.font
theme.hotkeys_description_font = theme.font_small
theme.hotkeys_bg = theme.bg_normal
theme.hotkeys_fg = theme.fg_normal
theme.hotkeys_modifiers_fg = theme.bg_focus
theme.hotkeys_border_width = 0
theme.hotkeys_shape = function (cr, w, h)
    gears.shape.rounded_rect(cr, w, h, 6)
end
-- }}}

-- Titlebar {{{
theme.titlebar_fg = theme.fg_normal
theme.titlebar_bg = theme.bg_normal
theme.titlebar_fg_normal = theme.fg_normal
theme.titlebar_bg_normal = theme.bg_normal
theme.titlebar_fg_focus = theme.fg_normal
theme.titlebar_bg_focus = theme.bg_focus

-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"

theme.fg_widget = theme.fg_normal
theme.bg_widget = theme.color.black2
theme.widget_border_color = theme.color.white

theme.progressbar_bg = theme.bg_widget
theme.progressbar_fg = theme.bg_focus
theme.progressbar_fg_disabled = theme.bg_focus
theme.progressbar_border_width = 0
theme.progressbar_border_color = theme.widget_border_color
theme.progressbar_paddings = 1
theme.progressbar_shape = gears.shape.rounded_bar
theme.progressbar_bar_shape = gears.shape.rounded_bar

theme.graph_bg_normal = theme.bg_widget
theme.graph_fg1 = theme.color.blue
theme.graph_fg2 = theme.color.green
theme.graph_fg3 = theme.color.yellow

theme.systray_icon_spacing = dpi(8)

-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(20)
theme.menu_width  = dpi(150)
-- }}}

-- {{{ Icons

-- {{{ Misc
-- theme.awesome_icon           = thistheme_path .. "/archlinux-black-icon.png"
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.fg_focus, theme.bg_focus
)
theme.menu_submenu_icon      = thistheme_path .. "/submenu.png"
-- }}}

-- {{{ Layout
theme.layout_tile       = thistheme_path .. "/layouts/tile.png"
theme.layout_tileleft   = thistheme_path .. "/layouts/tileleft.png"
theme.layout_tilebottom = thistheme_path .. "/layouts/tilebottom.png"
theme.layout_tiletop    = thistheme_path .. "/layouts/tiletop.png"
theme.layout_fairv      = thistheme_path .. "/layouts/fairv.png"
theme.layout_fairh      = thistheme_path .. "/layouts/fairh.png"
theme.layout_spiral     = thistheme_path .. "/layouts/spiral.png"
theme.layout_dwindle    = thistheme_path .. "/layouts/dwindle.png"
theme.layout_max        = thistheme_path .. "/layouts/max.png"
theme.layout_fullscreen = thistheme_path .. "/layouts/fullscreen.png"
theme.layout_magnifier  = thistheme_path .. "/layouts/magnifier.png"
theme.layout_floating   = thistheme_path .. "/layouts/floating.png"
theme.layout_cornernw   = thistheme_path .. "/layouts/cornernw.png"
theme.layout_cornerne   = thistheme_path .. "/layouts/cornerne.png"
theme.layout_cornersw   = thistheme_path .. "/layouts/cornersw.png"
theme.layout_cornerse   = thistheme_path .. "/layouts/cornerse.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = thistheme_path .. "/titlebar/close_focus.png"
theme.titlebar_close_button_normal = thistheme_path .. "/titlebar/close_normal.png"

theme.titlebar_minimize_button_normal = thistheme_path .. "/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = thistheme_path .. "/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_focus_active  = thistheme_path .. "/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = thistheme_path .. "/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = thistheme_path .. "/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = thistheme_path .. "/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = thistheme_path .. "/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = thistheme_path .. "/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = thistheme_path .. "/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = thistheme_path .. "/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = thistheme_path .. "/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = thistheme_path .. "/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = thistheme_path .. "/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = thistheme_path .. "/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = thistheme_path .. "/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = thistheme_path .. "/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = thistheme_path .. "/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = thistheme_path .. "/titlebar/maximized_normal_inactive.png"
-- }}}

-- {{{ Status Icons
theme.status_audio_on = thistheme_path .. "/panel/audio-on.png"
theme.status_audio_off = thistheme_path .. "/panel/audio-off.png"
theme.status_audio_on_huge = thistheme_path .. "/panel/audio-on-huge.png"
theme.status_audio_off_huge = thistheme_path .. "/panel/audio-off-huge.png"
theme.status_battery = thistheme_path .. "/panel/battery.png"
-- }}}

-- }}}

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
