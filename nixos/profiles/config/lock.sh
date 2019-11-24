#!/bin/sh
pactl set-sink-mute 0 1
pactl set-source-mute 1 1
pkill -u $USER -USR1 dunst
i3lock -c 000000 -n 
pkill -u $USER -USR2 dunst
