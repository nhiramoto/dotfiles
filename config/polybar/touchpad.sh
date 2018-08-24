#!/bin/bash

colorRunning="#abb2bf"
colorStopped="#88be5046"

state=`~/.script/touchpad.sh`

if [[ $state -eq 0 ]]; then
    echo "%{F$colorStopped}%{F-}"
else
    echo "%{F$colorRunning}%{F-}"
fi
