if pactl get-sink-mute @DEFAULT_SINK@ | grep no; then
	playerctl pause
	pactl set-sink-mute @DEFAULT_SINK@ true
	hyprlock
	pactl set-sink-mute @DEFAULT_SINK@ false
else
	playerctl pause
	hyprlock
fi
