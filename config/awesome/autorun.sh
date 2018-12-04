#!/usr/bin/env bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

run xrdb $HOME/.Xresources
run nm-applet
run udiskie
run $HOME/.dropbox-dist/dropboxd
run $HOME/.config/compton/launch.sh
run $HOME/.config/conky/launch.sh
run $HOME/.config/polybar/launch.sh
