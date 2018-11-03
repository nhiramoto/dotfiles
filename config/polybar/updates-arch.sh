#!/bin/bash

colorRunning=$(xgetres URxvt.foreground || echo "#fff")
colorStopped=$(xgetres URxvt.color8 || echo "#555")

ping -q -c 1 8.8.8.8 2> /dev/null > /dev/null

if [ $? -eq 0 ]; then
    updates_arch=$(checkupdates > /dev/null | wc -l)
    updates_aur=$(checkupdates-aur > /dev/null | wc -l)
    updates=$(($updates_arch + $updates_aur))

    if [[ $updates -gt 0 ]]; then
        echo "%{F$colorHas} ($updates)%{F-}"
    else
        #echo "%{F$colorNo}%{F-}"
        echo ""
    fi
else
    #echo "%{F$colorNo}%{F-}"
    echo ""
fi

exit 0
