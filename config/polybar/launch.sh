#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

export MONITOR1=${1:-eDP1}
export MONITOR2=${2:-HDMI1}

# Launch bars
polybar -r top &
polybar -r bottom &
polybar -r bottom2 &

echo "Bars launched..."
