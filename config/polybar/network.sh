#!/usr/bin/env sh
# A polybar module to check a network interface status.

colorRunning="#ffffff"
colorStopped="#555"

# Interfaces name pattern (regex)
wlan=^wlo1$
wired=^enp8s0$
usb=^enp0s20u[1-3]$

# Icons
wlan_icon=""
wired_icon=""
usb_icon=""
unknown_icon=""

# get current default interface name
default=`route | awk '{ if ($1 == "default") { print $8 } }'`

if [[ "$default" =~ $wlan ]]; then
    echo "%{F$colorRunning}$wlan_icon%{F-}"
elif [[ "$default" =~ $wired ]]; then
    echo "%{F$colorRunning}$wired_icon%{F-}"
elif [[ "$default" =~ $usb ]]; then
    echo "%{F$colorRunning}$usb_icon%{F-}"
else
    echo "%{F$colorStopped}$unknown_icon%{F-}"
fi

exit 0
