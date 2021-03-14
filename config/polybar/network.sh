#!/usr/bin/env sh
# A polybar module to check a network interface status.

colorRunning=$(xgetres URxvt.foreground || echo "#fff")
colorStopped=$(xgetres URxvt.color8 || echo "#555")

# Interfaces name pattern (regex)
wlan=^wlp2s0$
wired=^enp2s0$
usb=^enp0s20u[1-3]$

# Icons
wlan_icon="直"
wired_icon=""
usb_icon=" "
unknown_icon="ﯳ"

# get current default interface name
default=`route | awk '{ if ($1 == "default") { print $8 } }' | head -n1`

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
