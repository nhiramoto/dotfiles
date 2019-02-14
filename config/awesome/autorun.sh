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
run dropbox
run $HOME/.config/compton/launch.sh
run $HOME/.config/conky/launch.sh
#run $HOME/.script/mon er
