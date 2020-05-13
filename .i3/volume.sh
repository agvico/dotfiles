#!/bin/bash

# Clear previous notifications
pkill notify-osd

# Increase/decrease volume or mute

case $1 in
	up)
		pactl set-sink-volume 0 +5%
		volume=`amixer -D default -M get Master | grep -Pio '(\d)+%' -m1`
		notify-send "Volumen: $volume"
		;;
	down)
		pactl set-sink-volume 0 -5%
		volume=`amixer -D default -M get Master | grep -Pio '(\d)+%' -m1`
		notify-send "Volumen: $volume"
		;;
	mute)
		pactl set-sink-mute 0 toggle
		volume=`amixer -D default -M get Master | grep -Pio '(\d)+%' -m1`
		notify-send "Volumen: $volume"
		;;
	play)
		playerctl play-pause
		;;
	stop)
		playerctl stop
		;;
	next)
		playerctl next
		;;
	previous)
		playerctl previous
		;;
esac

