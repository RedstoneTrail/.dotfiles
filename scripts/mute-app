#!/usr/bin/env sh
pactl set-sink-input-mute $(pactl list sink-inputs | grep $1 -i -B 35 | grep 'Sink Input ' | sed 's/Sink Input #//') toggle
