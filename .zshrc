# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' menu select=0
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' use-compctl false
zstyle :compinstall filename '/home/redstonetrail/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt beep extendedglob nomatch notify
unsetopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install

# set fzf bindings and completion
source <(fzf --zsh)

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

PS1='%F{green}%n%F{cyan}%/%f ]> '

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias l='ls -alh'
alias open="xdg-open"
alias bc="bc -lq"

export NNN_OPTS="cdHiJQuU"
export NNN_OPENER="/home/redstonetrail/.dotfiles/scripts/nnn-nuke.sh"

export UNIPICKER_SYMBOLS_FILE=/home/redstonetrail/projects/unipicker/symbols
export UNIPICKER_COPY_COMMAND=/bin/wl-copy

export PATH=/sbin:/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/sbin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/usr/lib/rustup/bin:/home/redstonetrail/bin
export PAGER=less
export EDITOR=nvim
export BROWSER=firefox
export TERMINAL=alacritty
export XKB_DEFAULT_OPTIONS=ctrl:nocaps
export XKB_DEFAULT_LAYOUT=gb

export LISTMAX=-1
setopt no_hist_verify

# ZVM
export ZVM_INSTALL="$HOME/.zvm/self"
export PATH="$PATH:$HOME/.zvm/bin"
export PATH="$PATH:$ZVM_INSTALL/"

# Zinit plugins/packages
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions

zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
# End thereof

# Created by `pipx` on 2024-12-17 09:12:09
export PATH="$PATH:/home/redstonetrail/.local/bin"

# Fix home and end
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^B' backward-word
bindkey '^W' forward-word

if [ -z $DISPLAY ]; then
	cage -d -- ghostty
	exit
fi

if [ -z $LOWEST ] && [ -z $TMUX ]; then
	LOWEST='y'
	
	tmux
	kill ${${(v)jobstates##*:*:}%=*}
	sleep .01
	kill ${${(v)jobstates##*:*:}%=*}
	sleep .01
	exit
else
	if [ -z $TMUX ]; then
		tmux attach
	fi
fi
