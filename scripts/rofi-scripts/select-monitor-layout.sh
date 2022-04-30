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

SELECTION=$( (echo $P; echo $S; echo $ER; echo $EL; echo $SW;) | (rofi -dmenu -p "Select monitor layout:") )

case "$SELECTION" in
    "$P")
        bash $HOME/.scripts/mon primary
        ;;
    "$S")
        bash $HOME/.scripts/mon secondary
        ;;
    "$ER")
        bash $HOME/.scripts/mon extend-right
        ;;
    "$EL")
        bash $HOME/.scripts/mon extend-left
        ;;
    "$SW")
        bash $HOME/.scripts/mon swap
        ;;
esac

