#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/cuts"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar

echo "Entrou aqui!"

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    echom $m
    MONITOR=$m polybar -q top -c "$DIR"/config.ini &
    MONITOR=$m polybar -q bottom -c "$DIR"/config.ini &
  done
else
  polybar -q top -c "$DIR"/config.ini &
  polybar -q bottom -c "$DIR"/config.ini &
fi

ln -s /tmp/polybar_mqueue.$! /tmp/ipc-bottom

echo message >/tmp/ipc-bottom
