#!/bin/bash

killall picom 2> /dev/null
picom -b --config $HOME/.config/picom/picom.conf
