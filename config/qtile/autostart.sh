#!/bin/sh
# qtile: Autostart commands

export XDG_CURRENT_DESKTOP="qtile"

# Network Manager
nm-applet &

# Disk automonter
udiskie &

# Dropbox
. "$HOME/.dropbox-dist/dropboxd" &

# Setup Monitors
. "$HOME/.script/mon" "er"
