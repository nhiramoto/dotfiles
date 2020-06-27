#!/bin/bash

killall compton 2> /dev/null
compton -b --config ~/.config/compton/compton.conf
