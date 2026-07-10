# zmodload zsh/zprof

have_cmd() {
	command -v $1 &>/dev/null
}

have_cmd hyprctl && have_cmd pgrep && have_cmd jq && pgrep Hyprland &>/dev/null && export HYPRLAND_INSTANCE_SIGNATURE=$(hyprctl -j instances | jq -r '.[0].instance')

zstyle ':completion:*' completer _expand _complete _match _correct _prefix _ignored
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt nobeep notify extendedglob nonomatch autolist globcomplete noautoparamslash globdots rematchpcre interactivecomments

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

zinit ice depth=1

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

if have_cmd fzf
then
	zinit light joshskidmore/zsh-fzf-history-search
	source <(fzf --zsh)
fi

zinit light zdharma-continuum/fast-syntax-highlighting

zinit light jeffreytse/zsh-vi-mode
bindkey -v

bindkey -M vicmd q push-line-or-edit

ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
ZVM_MODE=$ZVM_LINE_INIT_MODE

function zvm_after_select_vi_mode() {
	create_prompt
}

alias ls="ls --color=auto -ahp --time-style='+%Y-%m-%d %H:%M'"
alias  l="ls -l"

have_cmd grep && alias grep="grep --color=auto"

have_cmd fzf && alias fm="fzfman"

have_cmd bc && alias bc="bc -lq"

have_cmd xdg-open && alias open="xdg-open"

if have_cmd notify-send
then
	alias notify="notify-send -a zsh done"
fi

if have_cmd proxychains4
then
	alias proxychains4="env proxychains4 -q"
	alias pc="IS_TOR_SHELL=1 env proxychains4 -q"
fi

if have_cmd nix
then
	if have_cmd git
	then
		nd-gcroot() {
			dir=$(git rev-parse --show-toplevel)
			nix build .#devShells.x86_64-linux.default --out-link "$dir/.nix-gcroot"
		}
	fi

	alias   nix="IS_NIX_SHELL=1 nix"
	alias    ns="nix-wrapper shell"
	alias    nr="nix-wrapper run"
	alias    nd="nix-wrapper develop"
	alias   nfu="nix flake update"

	if have_cmd proxychains4
	then
		alias  pcns="nix-wrapper proxychains-shell"
		alias  pcnr="nix-wrapper proxychains-run"
		alias  pcnd="nix-wrapper proxychains-develop"
		alias pcnfu="proxychains4 -q nix flake update"
	fi
fi

have_cmd python && alias httplz="python -m http.server"

if have_cmd make
then
	alias  m="make"
	alias mt="make test"
	alias mb="make build"
fi

if have_cmd cargo
then
	alias c=cargo
	alias cr="c r"
	alias cb="c b"
fi

if have_cmd zig
then
	zbt() {
		if echo $@ | grep '--summary' &>/dev/null
		then
			zig build test $@
		else
			zig build test --summary all $@
		fi
	}

	alias zbr="zig build run"
	alias  zb="zig build"
fi

have_cmd cyme && alias lsusb="cyme --lsusb"

if have_cmd nvim
then
	alias vim=nvim

	export MANPAGER="nvim \+Man\!"
	export EDITOR=nvim
fi

have_cmd gpg && export GNUPGHOME="~/.gnupg"

if have_cmd waves
then
	waves () {
		# auto start slskd
		have_cmd slskd && ! pgrep slskd && env SLSKD_SLSK_PASSWORD="$(pass show slsk)" setsid -f slskd &>/dev/null

		env waves
	}
fi

export PATH=$PATH:$HOME/.dotfiles/scripts:$HOME/bin

have_cmd less && export PAGER=less

have_cmd firefox && export BROWSER=firefox
export TERMINAL=$TERM

export ESCDELAY=0

export LISTMAX=-1
setopt no_hist_verify

export FUNCNEST=1000

have_cmd date && export today=$(date '+%Y-%m-%d')

create_prompt() {
	separator="/"

	PS1="]> "

	case $ZVM_MODE in
		$ZVM_MODE_NORMAL)
			PS1="%F{8}normal%f$PS1"
		;;
		$ZVM_MODE_INSERT)
			PS1="%F{2}insert%f$PS1"
		;;
		$ZVM_MODE_VISUAL)
			PS1="%F{5}visual%f$PS1"
		;;
		$ZVM_MODE_VISUAL_LINE)
			PS1="%F{5}v-line%f$PS1"
		;;
		$ZVM_MODE_REPLACE)
			PS1="%F{1}replace%f$PS1"
		;;
	esac

	PS1="%F{6}%~%f$separator$PS1"
	RPROMPT="[%D{%L:%M:%S}]"

	PS1="%F{2}%n%f$separator$PS1"

	case "$HOST" in
		"localhost")
			if [ -e ~/.termux/hostname ]
			then
				PS1="%F{1}$(<~/.termux/hostname)%f$separator$PS1"
			fi
			;;
		*)
			PS1="%F{1}$HOST%f$separator$PS1"
			;;
	esac

	if [ -z $IS_NIX_SHELL ]
	then
	else
		PS1="%F{4}nix-shell%f$separator$PS1"
	fi

	if [ -z $IS_TOR_SHELL ]
	then
	else
		PS1="%F{13}tor-shell%f$separator$PS1"
	fi

	PS1="[$PS1"
}

create_prompt

# Fix home and end
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line

# start tmux session if not on vt, termux or in tmux
if [ -z "$TMUX" ] && [ "$TERM" != "linux" ] && [ -z "$TERMUX_VERSION" ]
then
	exec tmux
fi

# ask for tmux session when on vt or in termux
if [ "$TERM" == "linux" ] || [ ! -z "$TERMUX_VERSION" ] && [ -z "$TMUX" ]
then
	echo 'Enter a tmux session? (y)'
	read -k 1 want_tmux
	echo

	if [ -z "$want_tmux" ]
	then
		want_tmux='n'
	fi

	if [ "$want_tmux" == 'y' ]
	then
		echo 'Entering tmux session'
		exec tmux
	fi

	echo 'Not entering a tmux session'
fi

# zprof | less
