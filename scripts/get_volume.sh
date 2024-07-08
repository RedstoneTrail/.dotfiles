pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '/\s*\K[^% //|.]*' | head -1
