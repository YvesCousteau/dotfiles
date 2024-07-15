#!/bin/bash

DIR="$HOME/.config/polybar"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config
polybar -q top -c "$DIR"/config.ini &
polybar -q bottom -c "$DIR"/config.ini &

echo "Polybar launched..."
