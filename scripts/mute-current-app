#!/usr/bin/env sh
pactl set-sink-input-mute $(pactl list sink-inputs | grep $(hyprctl activewindow | grep pid | sed 's/\tpid: //') -B 30 | grep "Sink Input" | sed 's/Sink Input #//') toggle
