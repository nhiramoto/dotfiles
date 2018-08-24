#!/usr/bin/env sh
# A polybar module to check service status.

colorRunning="#ffffff"
colorStopped="#555"

service="$1" # service name
icon="$2"    # icon for the service status

isRunning=`systemctl is-active $service >/dev/null 2>&1 && echo 1 || echo 0`

if [ $isRunning -ne 0 ]; then
    echo "%{F$colorRunning}$icon%{F-}"
else
    #echo "%{F$colorStopped}$icon%{F-}"
    echo ""
fi

exit 0
