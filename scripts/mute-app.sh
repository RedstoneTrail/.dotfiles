pactl set-sink-input-mute $(pactl list sink-inputs | grep "$NAME" -B 30 | grep "Sink Input " | sed 's/Sink Input \#//') toggle
