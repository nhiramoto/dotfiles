#!/bin/bash

killall picom 2> /dev/null
sleep 1
picom -b --config $HOME/.config/picom/picom.conf
