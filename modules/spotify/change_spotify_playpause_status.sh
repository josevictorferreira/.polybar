#!/bin/sh

playerctl play-pause -p spotify

player_status=$(/usr/bin/playerctl --player=spotify status 2>/dev/null);

if [ "$player_status" = "Playing" ]; then
	polybar-msg action "#spotify-play-pause.hook.1"
elif [ "$player_status" = "Paused" ]; then
	polybar-msg action "#spotify-play-pause.hook.0"
fi
