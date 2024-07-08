pactl get-source-volume @DEFAULT_SOURCE@ | grep -oP '/\s*\K[^% //|.]*' | head -1
