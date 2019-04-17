#!/bin/bash

colorRunning=$(xgetres URxvt.foreground || echo "#fff")
colorStopped=$(xgetres URxvt.color8 || echo "#555")

state=$(~/.script/touchpad.sh 2> /dev/null)

if [[ $state -eq 0 ]]; then
    echo "%{F$colorStopped}%{F-}"
else
    echo "%{F$colorRunning}%{F-}"
fi
