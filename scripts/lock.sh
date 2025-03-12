if pactl get-sink-mute @DEFAULT_SINK@ | grep no; then
	pactl set-sink-mute @DEFAULT_SINK@ true
	hyprlock
	pactl set-sink-mute @DEFAULT_SINK@ false
else
	hyprlock
fi
