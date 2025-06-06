# hyprctl notify 3 1000 0 "fontsize:15 Entering kill mode" && hyprctl kill
hyprctl kill
notify-send -u critical -a hyprland -t 500 "kill mode activated"
