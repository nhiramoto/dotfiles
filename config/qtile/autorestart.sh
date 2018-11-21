#!/bin/sh
# qtile:
#   Command to run on start and restart.

# Wallpaper
feh --bg-fill "$HOME/Pictures/default."{png,jpeg,jpg} &

# Compton
. "$HOME/.config/compton/launch.sh" &

# Conky
. "$HOME/.config/conky/launch.sh" &
