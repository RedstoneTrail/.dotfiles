which -v hyprctl &> /dev/null && pgrep Hyprland &>/dev/null && export HYPRLAND_INSTANCE_SIGNATURE=$(hyprctl -j instances | jq -r '.[0].instance')

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

alias ls="ls --color=auto -ahp"
alias  l="ls -l"

alias lsusb="cyme --lsusb"

alias grep="grep --color=auto"

alias fm="fzfman"

alias open="xdg-open"

alias notify="notify-send -a zsh done"

alias bc="bc -lq"

alias proxychains4="env proxychains4 -q"
alias pc="IS_TOR_SHELL=1 env proxychains4 -q"

nd-gcroot() {
	dir=$(git rev-parse --show-toplevel)
	nix build .#devShells.x86_64-linux.default --out-link "$dir/.nix-gcroot"
}

alias   nix="IS_NIX_SHELL=1 nix"
alias    ns="nix-wrapper shell"
alias  pcns="nix-wrapper proxychains-shell"
alias    nr="nix-wrapper run"
alias  pcnr="nix-wrapper proxychains-run"
alias    nd="nix-wrapper develop"
alias  pcnd="nix-wrapper proxychains-develop"
alias   nfu="nix flake update"
alias pcnfu="proxychains4 -q nix flake update"

alias httplz="python -m http.server"

alias  m="make"
alias mt="make test"
alias mb="make build"

if command -v zig &>/dev/null
then
	zig_test() {
		if echo $@ | grep summary &>/dev/null
		then
			zig build test
		else
			zig build test --summary all
		fi
	}
	alias zbt=zig_test
	alias zbr="zig build run"
	alias  zb="zig build"
fi

alias vim=nvim

export NNN_OPTS="cdHiJQuU"
export NNN_OPENER="$HOME/.dotfiles/scripts/nnn-nuke.sh"

export GNUPGHOME="~/.gnupg"

# export PATH=$PATH:/sbin:/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/sbin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/usr/lib/rustup/bin:$HOME/bin:$HOME/.dotfiles/scripts:$HOME/.cargo/bin/
export PATH=$PATH:$HOME/.dotfiles/scripts
export PAGER=less
export MANPAGER="nvim \+Man\!"
export EDITOR=nvim
export BROWSER=firefox
export TERMINAL=$TERM

export LISTMAX=-1
setopt no_hist_verify

PS1="%F{2}%n%f|%F{6}%~%f]> "
RPROMPT="[%D{%L:%M:%S}]"

if [ -z $IS_NIX_SHELL ]
then
else
	PS1="%F{4}nix-shell%f|$PS1"
fi

if [ -z $IS_TOR_SHELL ]
then
else
	PS1="%F{13}tor-shell%f|$PS1"
fi

PS1="[$PS1"

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zdharma-continuum/fast-syntax-highlighting
fast-theme ~/.dotfiles/zsh-fast-theme.ini > /dev/null

zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
bindkey -v

# zinit wait lucid for \
# 	pick"zsh/fzf-zsh-completion.sh" \
# 		lincheney/fzf-tab-completion \
# 		OMZP::git \

# ZSH_AUTOSUGGEST_IGNORE_WIDGETS=(fzf_completion)

zinit light joshskidmore/zsh-fzf-history-search
command -v fzf &> /dev/null && source <(fzf --zsh)


# Fix home and end
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
	export PATH="$PATH:/nix/var/nix/profiles/default/bin"
fi
# End Nix

# # remove the non-directory path entry ~/.nix-profile/bin
# export PATH=$(echo $PATH | tr ':' '\n' | grep -v '.nix-profile/bin' | tr '\n' ':' | rev | cut -b2- | rev)

# start tmux session if not on vt
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
