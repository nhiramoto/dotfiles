#!/bin/sh
# qtile:
#   Command to run on start and restart.

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

run xrdb $HOME/.Xresources
run feh --bg-fill $HOME/Pictures/{wallpaper,Wallpaper,default,Default}.{png,jpg}
run $HOME/.config/picom/launch.sh
run $HOME/.config/conky/launch.sh
