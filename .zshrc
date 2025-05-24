zstyle ':completion:*' completer _expand _complete _match _correct _prefix _ignored
zstyle :compinstall filename '~/.zshrc'

# autoload -Uz compinit
# compinit

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt nobeep notify extendedglob nonomatch autolist globcomplete noautoparamslash interactivecomments
bindkey -v

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

alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias l="ls -alhp"
alias open="xdg-open"
alias bc="bc -lq"
alias nix="IS_NIX_SHELL=1 nix"
alias nd="nix develop -c zsh"
alias ns="nix shell"
alias nr="nix run"
alias zbr="zig build run"
alias fs="source /home/redstonetrail/.dotfiles/scripts/fuzzy-search.sh"
alias notify-done="notify-send -u low -a zsh process\ finished"

export NNN_OPTS="cdHiJQuU"
export NNN_OPENER="/home/redstonetrail/.dotfiles/scripts/nnn-nuke.sh"

export UNIPICKER_SYMBOLS_FILE=/home/redstonetrail/projects/unipicker/symbols
export UNIPICKER_COPY_COMMAND=/bin/wl-copy

export MANPAGER="less"

export GNUPGHOME="~/.gnupg"

export PATH=$PATH:/sbin:/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/sbin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/usr/lib/rustup/bin:/home/redstonetrail/bin
export PAGER=less
export EDITOR=nvim
export BROWSER=firefox
export TERMINAL=$TERM

export LISTMAX=-1
setopt no_hist_verify

# ZVM
export ZVM_INSTALL="$HOME/.zvm/self"
export PATH="$PATH:$HOME/.zvm/bin"
export PATH="$PATH:$ZVM_INSTALL/"

PS1="%F{green}%n%f|%F{cyan}%~%f]> "
RPROMPT="[%D{%L:%M:%S}]"

if [ -z $IS_NIX_SHELL ]
then
else
	PS1="%F{blue}nix-shell%f|$PS1"
fi

PS1="[$PS1"

# Zinit plugins/packages
# zinit wait lucid for \
#  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
#     zdharma-continuum/fast-syntax-highlighting \
#  blockf \
#     zsh-users/zsh-completions \
#  atload"!_zsh_autosuggest_start" \
#     zsh-users/zsh-autosuggestions

# zinit light zsh-users/zsh-completions
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
# End thereof

# Fix home and end
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
   . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
export PATH="$PATH:/nix/var/nix/profiles/default/bin"
# End Nix

# remove the non-directory path entry ~/.nix-profile/bin
export PATH=$(echo $PATH | tr ':' '\n' | grep -v '.nix-profile/bin' | tr '\n' ':' | rev | cut -b2- | rev):/opt/cuda/bin:/opt/cuda/nsight_compute:/opt/cuda/nsight_systems/bin

if [ -z $LOWEST ] && [ -z $TMUX ] && [ -z $DISPLAY ]; then
	LOWEST='y'

	export TMUX_TMPDIR=~/tmp/tmux/
	
	exec tmux
fi
