local awful = require 'awful'
local hotkeys_popup = require'awful.hotkeys_popup'.widget
hotkeys_popup.merge_duplicates = true

local theme = require 'user.theme'
local apps = require 'user.apps'

local M = {}

local awesome_config_file = os.getenv("HOME") .. "/.config/awesome/rc.lua"

local awesome_menu = {
  { 'hotkeys', function () return false, hotkeys_popup.show_help end },
  { 'manual', apps.default.terminal .. ' -e man awesome' },
  { 'edit config', apps.default.editor .. ' ' .. awesome_config_file },
  { 'restart awesome', awesome.restart },
  { 'logout', function() awesome.quit() end }
}

local main_menu = awful.menu({
  items = {
    { 'awesome', awesome_menu, theme.awesome_icon },
    { 'open terminal', apps.default.terminal }
  }
})

M.widget = function (screen)
  return awful.widget.launcher({
    image = theme.awesome_icon,
    menu = main_menu
  })
end

return M
