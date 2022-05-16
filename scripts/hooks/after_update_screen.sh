#!/bin/bash
# A script executed after screen is changed.

#PRIMARY=
#SECONDARY=

echo "PRIMARY: $PRIMARY"
echo "SECONDARY: $SECONDARY"

function setWallpaper {
    nitrogen --restore || true
}

function launch_polybar {
    MONITOR1="$1"
    MONITOR2="$2" 
    echo "MONITOR1: $MONITOR1, MONITOR2: $MONITOR2"
    . "$HOME/.config/polybar/launch.sh"
}

function launch_conky {
    . "$HOME/.config/conky/launch.sh"
}

function set_bspwm_desktops {
    if [[ -n "$1" ]]; then
        if [[ -n "$2" ]]; then
            bspc monitor "$1" -d I II III IV V VI VII
            bspc monitor "$2" -d VIII IX X
        else
            bspc monitor "$1" -d I II III IV V VI VII VIII IX X
        fi
    fi
}

case "$DESKTOP_SESSION" in
    "i3")
        launch_polybar "$PRIMARY" "$SECONDARY"
        launch_conky
        ;;
    "bspwm")
        set_bspwm_desktops "$PRIMARY" "$SECONDARY"
        launch_polybar "$PRIMARY" "$SECONDARY"
        launch_conky
        ;;
    *)
        echo "Desktop session $DESKTOP_SESSION not recognized."
        ;;
esac

setWallpaper

