#!/bin/bash
# vi:syntax=sh
###
# rofi-script: Select a setup for monitors
##

# Options
P="Primary Only"
S="Secondary Only"
ER="Extend to Right"
EL="Extend to Left"
SW="Swap Monitors"

case "$1" in
    "$P")
        bash $HOME/.script/mon primary
        exit 0
        ;;
    "$S")
        bash $HOME/.script/mon secondary
        exit 0
        ;;
    "$ER")
        bash $HOME/.script/mon extend-right
        exit 0
        ;;
    "$EL")
        bash $HOME/.script/mon extend-left
        exit 0
        ;;
    "$SW")
        bash $HOME/.script/mon swap
        exit 0
        ;;
    *)
        echo -e "$P\n$S\n$ER\n$EL\n$SW"
esac

exit 0

