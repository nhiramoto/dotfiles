#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

export MONITOR1=$(xrandr | awk '{ if ($2 == "connected" && $3 == "primary") { print $1 } }')
export MONITOR2=$(xrandr | awk '{ if ($2 == "connected" && $3 ~ /^[1-9]/) { print $1 } }' | head -n 1)
echo "Monitor1: $MONITOR1"
echo "Monitor2: $MONITOR2"

# Launch bars
if [[ $MONITOR1 ]]; then
    polybar -r top &
    #polybar -r bottom &
fi

if [[ $MONITOR2 ]]; then
    #polybar -r top2 &
    env MONITOR2=$MONITOR2 polybar -r bottom2 &
fi

echo "Bars launched..."
