#!/bin/bash
# A script executed after screen is changed.

#PRIMARY=
#SECONDARY=

echo "PRIMARY: $PRIMARY"
echo "SECONDARY: $SECONDARY"

function setWallpaper {
    nitrogen --restore
}

function launchPolybar {
    env MONITOR1="$1" MONITOR2="$2" "$HOME/.config/polybar/launch.sh"
}

function setBspwmWorkspaces {
    if [[ -n "$1" ]]; then
        if [[ -n "$2" ]]; then
            bspc monitor "$1" -d I II III IV V VI VII
            bspc monitor "$2" -d VIII IX X
        else
            bspc monitor "$1" -d I II III IV V VI VII VIII IX X
        fi
    fi
}

case "$CURRENT_DESKTOP" in
    "i3")
        launchPolybar "$PRIMARY" "$SECONDARY"
        ;;
    "bspwm")
        setBspwmWorkspaces "$PRIMARY" "$SECONDARY"
        launchPolybar "$PRIMARY" "$SECONDARY"
        ;;
    *)
        ;;
esac

setWallpaper

