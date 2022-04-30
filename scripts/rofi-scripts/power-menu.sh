#!/bin/bash

OPTIONS=(
    "鈴 Suspend"
    #" Logout"
    " Restart"
    " Shutdown"
)

SELECTION=$((printf "%s;%s;%s;%s\n" "${OPTIONS[0]}" "${OPTIONS[1]}" "${OPTIONS[2]}" "${OPTIONS[3]}") | (rofi -dmenu -sep ";" -p "Select:"))

case "$SELECTION" in
    "${OPTIONS[0]}")
        systemctl suspend
        ;;
    "${OPTIONS[1]}")
        #notify-send "Loging out..."
        ;;
    "${OPTIONS[2]}")
        zenity --question --text "Are you sure you want to restart?" --width 400 && systemctl reboot
        ;;
    "${OPTIONS[3]}")
        zenity --question --text "Are you sure you want to power off?" --width 400 && systemctl poweroff
        ;;
esac
