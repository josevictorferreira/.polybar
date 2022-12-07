#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar"

PRIMARY=$(xrandr --query | grep " connected" | grep "primary" | cut -d" " -f1)
OTHERS=$(xrandr --query | grep " connected" | grep -v "primary" | cut -d" " -f1)

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar

if type "xrandr"; then
  for p in $PRIMARY; do
    MONITOR=$p polybar -q top -c "$DIR"/config.ini &
    MONITOR=$p polybar -q bottom -c "$DIR"/config.ini &
  done
  sleep 1
  for m in $OTHERS; do
    MONITOR=$m polybar -q top -c "$DIR"/config.ini &
    MONITOR=$m polybar -q bottom -c "$DIR"/config.ini &
  done
else
  polybar -q top -c "$DIR"/config.ini &
  polybar -q bottom -c "$DIR"/config.ini &
fi
