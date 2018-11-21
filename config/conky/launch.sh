#!/bin/bash

killall conky 2> /dev/null

conky -c ~/.config/conky/conky_cpumem &
conky -c ~/.config/conky/conky_host &

