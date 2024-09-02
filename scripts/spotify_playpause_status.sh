#!/usr/bin/env bash

get_spotify_status() { PLAYER_STATUS=$(/usr/bin/playerctl --player=spotify status 2>/dev/null); }

get_spotify_status

if [ "$PLAYER_STATUS" = "Playing" ]; then
  echo "   "
  exit 0
elif [ "$PLAYER_STATUS" = "Paused" ]; then
  echo "   "
  exit 0
else
  echo "   "
  exit 1
fi
