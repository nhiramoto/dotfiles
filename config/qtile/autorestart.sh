#!/bin/sh
# qtile:
#   Command to run on start and restart.

# Wallpaper
feh --bg-fill "$HOME/Pictures/default."{png,jpeg,jpg} &

# Picom
. "$HOME/.config/picom/launch.sh" &

# Conky
. "$HOME/.config/conky/launch.sh" &
