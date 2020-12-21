#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Get the correct monitor
MONITOR=$(xrandr --query | grep " connected " | grep "1920x1080" | cut -d" " -f1)

# Launch bar
MONITOR="${MONITOR}" polybar --config=$HOME/.config/polybar/config.ini --reload main &
