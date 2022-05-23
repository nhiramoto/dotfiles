local beautiful = require 'beautiful'
local theme_assets = require 'beautiful.theme_assets'
local gears = require 'gears'
local dpi = require 'beautiful.xresources'.apply_dpi

local M = {}

local colors = require 'user.theme.colors.xresources'
local icons = require 'user.theme.icons'
-- local colors = require 'colors.xresources'

M.colors = colors
M.icons = icons

-- Fonts
M.font = 'JetBrainsMono Nerd Font Semibold 10'
M.font_small = "JetBrainsMono Nerd Font Semibold 9"
M.font_big = "JetBrainsMono Nerd Font Semibold 12"
M.font_extra = "JetBrainsMono Nerd Font Semibold 14"

-- Colors
M.panel = colors.background
M.fg_normal  = colors.foreground
M.bg_normal  = colors.background
M.fg_focus   = colors.color0
M.bg_focus   = colors.color4
M.fg_urgent  = colors.color0
M.bg_urgent  = colors.color1
M.bg_systray = colors.background

-- Borders
M.useless_gap   = dpi(2)
M.gap_single_client = false
M.border_width  = dpi(2)
M.border_normal = M.bg_normal
M.border_focus  = M.bg_focus
M.border_marked = colors.color3

-- Titlebar
M.titlebar_fg = M.fg_normal
M.titlebar_bg = M.bg_normal
M.titlebar_fg_normal = M.fg_normal
M.titlebar_bg_normal = M.bg_normal
M.titlebar_fg_focus = M.fg_normal
M.titlebar_bg_focus = M.bg_focus

-- Taglist
M.taglist_fg_normal = M.fg_normal
M.taglist_fg_focus = M.bg_normal
M.taglist_fg_occupied = M.bg_focus
M.taglist_fg_urgent = M.fg_urgent
M.taglist_bg_normal = colors.color1
M.taglist_bg_focus = M.bg_focus
M.taglist_bg_urgent = M.bg_urgent

-- Tasklist
M.tasklist_fg_normal = M.fg_normal
M.tasklist_fg_focus = M.fg_normal
M.tasklist_bg_normal = M.panel
M.tasklist_bg_focus = M.panel

-- Tooltip
M.tooltip_fg = M.fg_normal
M.tooltip_bg = M.bg_normal
M.tooltip_shape = function (cr, w, h)
    gears.shape.partially_rounded_rect(cr, w, h, false, false, true, true, 5)
end

-- Notification
M.notification_bg = M.bg_normal
M.notification_fg = M.fg_normal
--M.notification_font =M.font
M.notification_border_width = 10
M.notification_border_color = M.notification_bg
M.notification_max_width = dpi(400)
M.notification_icon_size = dpi(64)
M.notification_margin = dpi(12)
M.notification_font = M.font
M.notification_shape = function(cr, width, height)
    gears.shape.partially_rounded_rect(cr, width, height, true, false, true, true)
end

-- Hotkeys Popup
M.hotkeys_font = M.font
M.hotkeys_description_font = M.font_small
M.hotkeys_bg = M.bg_normal
M.hotkeys_fg = M.fg_normal
M.hotkeys_modifiers_fg = M.bg_focus
M.hotkeys_border_width = 0
M.hotkeys_shape = function (cr, w, h)
    gears.shape.rounded_rect(cr, w, h, 6)
end

-- Widgets
M.fg_widget =M.fg_normal
M.bg_widget = colors.color8
M.widget_border_color = colors.color7

M.progressbar_bg =M.bg_widget
M.progressbar_fg =M.bg_focus
M.progressbar_fg_disabled =M.bg_focus
M.progressbar_border_width = 0
M.progressbar_border_color =M.widget_border_color
M.progressbar_paddings = 1
M.progressbar_shape = gears.shape.rounded_bar
M.progressbar_bar_shape = gears.shape.rounded_bar

M.graph_bg_normal =M.bg_widget
M.graph_fg1 = colors.color4
M.graph_fg2 = colors.color2
M.graph_fg3 = colors.color3

M.systray_icon_spacing = dpi(8)

-- Menus
M.menu_height = dpi(20)
M.menu_width  = dpi(150)

M.awesome_icon = theme_assets.awesome_icon(
    dpi(20), colors.color0, M.bg_focus
)
-- M.menu_submenu_icon      = thistheme_path .. "/submenu.png"

-- Layoutbox Icons
M.layout_tile = icons.layoutbox.tile
M.layout_tileleft = icons.layoutbox.tileleft
M.layout_tilebottom = icons.layoutbox.tilebottom
M.layout_tiletop = icons.layoutbox.tiletop
M.layout_fairv = icons.layoutbox.fairv
M.layout_fairh = icons.layoutbox.fairh
M.layout_spiral = icons.layoutbox.spiral
M.layout_dwindle = icons.layoutbox.dwindle
M.layout_max = icons.layoutbox.max

beautiful.init(M)

return M
