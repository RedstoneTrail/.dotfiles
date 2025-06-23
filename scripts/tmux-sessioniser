#!/usr/bin/env sh

PATH=$PATH:$HOME/.fzf/bin

if [[ $# -eq 1 ]]; then
	selected=$1
else
	paths() {
		fd -ad1 -td . ~
		fd -Had1 -td . ~/projects
	}
	selected=$(paths | fzf-tmux -p 80%,80% -- --preview '
		selected_name=$(basename {1} | tr . _)
		if tmux has-session -t=$selected_name 2> /dev/null; then
			echo -e "\033[32msession running\033[0m"
			tmux list-windows -t=$selected_name
		else
			cd {1}
			git -C . rev-parse 2>/dev/null && git log --oneline --color | head -n3
			rg --files | tree --fromfile
		fi
	')
fi

if [[ -z $selected ]]; then
	exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
	tmux new-session -s $selected_name -c $selected
	exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
	tmux new-session -ds $selected_name -c $selected
fi

tmux switch-client -t $selected_name
