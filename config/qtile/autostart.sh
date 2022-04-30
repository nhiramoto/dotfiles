#!/bin/sh
# qtile: Autostart commands

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

export XDG_CURRENT_DESKTOP="qtile"

run xrdb $HOME/.Xresources
run nm-applet
run udiskie
run dropbox
run dunst
run $HOME/.config/picom/launch.sh
run $HOME/.config/conky/launch.sh
run $HOME/.scripts/mon restore
# run feh --bg-fill $HOME/Pictures/{wallpaper,Wallpaper,default,Default}.{png,jpg}
run nitrogen --restore
