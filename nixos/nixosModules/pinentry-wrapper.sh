#!/usr/bin/env sh

gui_pinentry () {
	pinentry-qt $@
}

tui_pinentry () {
	# set alarm for pane
	printf '\a' > $(tmux display-message -pt "$TMUX_PANE" '#{pane_tty}')

	pinentry-curses $@
}

case $PINENTRY_OVERRIDE in
	gui)
		gui_pinentry
		exit
		;;
	tui)
		tui_pinentry
		exit
		;;
esac

if [ $(tmux display-message -pt "$TMUX_PANE" '#{session_active}') == 1 ]
then
	tui_pinentry
else
	gui_pinentry
fi
