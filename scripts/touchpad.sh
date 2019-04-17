#!/bin/bash

device="ELAN1200:00 04F3:303E Touchpad" 
state=`xinput list-props "$device" | grep "Device Enabled" | grep -o "[01]$"`

#echo "device: $device"
#echo "state: $state"

function enable_touchpad () {
    xinput set-prop "$device" "Device Enabled" 1
    notify-send "Touchpad" "Enabling touchpad."
}

function disable_touchpad () {
    xinput set-prop "$device" "Device Enabled" 0
    notify-send "Touchpad" "Disabling touchpad."
}

# echo "parsing argument..."
case $1 in
    toggle)
        #echo "toggling touchpad..."
        if [[ $state -eq 0 ]]; then
            enable_touchpad
        else
            disable_touchpad
        fi
        ;;
    enable)
        #echo "enabling touchpad..."
        enable_touchpad
        ;;
    disable)
        #echo "disabling touchpad..."
        disable_touchpad
        ;;
    *)
        #echo "getting state..."
        echo "$state"
        ;;
esac
