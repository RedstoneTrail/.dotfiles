#!/usr/bin/env sh

set -o posix

install_link () {
	# arg 1 is source directory
	# arg 2 is destination
	
	if [ -e $(realpath "$2") ]
	then
		printf "\tfile already present at $(realpath $2), skipping\n"
		return
	fi
	printf "\tlinking $(realpath $1) into $(realpath $2)\n"
	# rm -rf "$2"
	# ln -s $(realpath "$1") $(realpath "$2")
}

if [ -z "$1" ]
then
	echo arg 1 is where the dotfiles are
	exit
fi

DOTFILES_DIR=$1
CONFIG_DIR=$HOME/.config

printf "linking directories into ~/.config/\n"
install_link $DOTFILES_DIR/alacritty $CONFIG_DIR/alacritty
install_link $DOTFILES_DIR/MangoHud $CONFIG_DIR/MangoHud
install_link $DOTFILES_DIR/mpv $CONFIG_DIR/mpv
install_link $DOTFILES_DIR/nvim $CONFIG_DIR/nvim
install_link $DOTFILES_DIR/tmux $CONFIG_DIR/tmux
install_link $DOTFILES_DIR/zathura $CONFIG_DIR/zathura

printf "\nlinking files into ~/\n"
install_link $DOTFILES_DIR/.clang-format $HOME/.clang-format
install_link $DOTFILES_DIR/tmux/tmux.conf $HOME/.tmux.conf
mkdir -p ~/.w3m
install_link $DOTFILES_DIR/.w3m/config $HOME/.w3m/config

if [ "$(whoami)" == "nix-on-droid" ] && [ "$(hostname)" == "localhost" ]
then
	NIX_ON_DROID="true"
	INSTALL_TYPE="limited"
else
	NIX_ON_DROID="false"
fi

if [ "$NIX_ON_DROID" == "true" ]
then
	printf "\ndetected nix-on-droid, installing related config\n"
	install_link $DOTFILES_DIR/nix-on-droid $CONFIG_DIR/nix-on-droid
else
	printf "\nnot on nix-on-droid, installing normal config\n"
	install_link $DOTFILES_DIR/.zshrc $HOME/.zshrc
fi

if [ "$NIX_ON_DROID" == "false" ]
then
	printf "\n"'full installation or limited installation? (full/limited)'"\n\t> "
	read INSTALL_TYPE

	while [ "$INSTALL_TYPE" != "full" ] && [ "$INSTALL_TYPE" != "limited" ]
	do
		printf "\n\t\"full\""' for a full installation, installs all config'"\n\t"'"limited" for a limited installation, only installs config for apps and cli stuff'"\n\t"'(case-sensitive)'"\n\t> "
		read INSTALL_TYPE
	done
fi

if [ "$INSTALL_TYPE" == "full" ]
then
	printf "\ndoing full config installation\n"
	install_link $DOTFILES_DIR/dunst $CONFIG_DIR/dunst
	install_link $DOTFILES_DIR/fuzzel $CONFIG_DIR/fuzzel
	install_link $DOTFILES_DIR/hypr $CONFIG_DIR/hypr
	install_link $DOTFILES_DIR/pulseaudio-ctl $CONFIG_DIR/pulseaudio-ctl
	install_link $DOTFILES_DIR/waybar $CONFIG_DIR/waybar
fi

if [ "$INSTALL_TYPE" == "limited" ] && [ "$NIX_ON_DROID" == "false" ] && which nix >/dev/null
then
	printf "\ndetected nix installation\n"
	if which jq >/dev/null
	then
		if [ "$(nix profile list --json | jq -r '.elements.nix')" == "null" ]
		then
			printf "\tnix profile not installed\n"
			while [ "$WANT_NIX_PROFILE" != "Y" ] && [ "$WANT_NIX_PROFILE" != "N" ]
			do
				printf "\tdo you want the nix profile installed? "'(Y/N) (case-sensitive)'"\n\t> "
				read WANT_NIX_PROFILE
			done

			if [ "$WANT_NIX_PROFILE" == "Y" ]
			then
				printf "\tok, installing nix profile\n\n"
				nix profile install $DOTFILES_DIR/nix
			else
				printf "\tok, skipping\n"
				FINAL_NOTES="${FINAL_NOTES}\tinstall wanted packages\n"
			fi
		else
			printf "\tnix profile already installed, skipping\n"
		fi
	else
		while [ "$USE_GREP_CHECK" != "Y" ] && [ "$USE_GREP_CHECK" != "N" ]
		do
			printf "\tjq not found, fall back to grep based check? (Y/N) (case-sensitive)\n\t> "
			read USE_GREP_CHECK
		done

		if [ "$USE_GREP_CHECK" == "Y" ]
		then
			if [ "$(nix profile list --json | jq -r '.elements.nix')" == "null" ]
			then
				printf "\tnix profile not installed\n"
				while [ "$WANT_NIX_PROFILE" != "Y" ] && [ "$WANT_NIX_PROFILE" != "N" ]
				do
					printf "\tdo you want the nix profile installed? (Y/N) (case-sensitive)\n\t> "
					read WANT_NIX_PROFILE
				done

				if [ "$WANT_NIX_PROFILE" == "Y" ]
				then
					printf "\tok, installing nix profile\n\n"
					nix profile install $DOTFILES_DIR/nix
				else
					printf "\tok, skipping\n"
					FINAL_NOTES="${FINAL_NOTES}\tinstall wanted packages\n"
				fi
			else
				printf "\tnix profile already installed, skipping\n"
				FINAL_NOTES="${FINAL_NOTES}\tinstall wanted packages\n"
			fi
		else
			printf "\tok, skipping\n"
			FINAL_NOTES="${FINAL_NOTES}\tinstall wanted packages\n"
		fi
	fi
fi

if [ "$INSTALL_TYPE" == "full" ]
then
	printf "\nno nix detected, you'll have to do packages for yourself\n"
	FINAL_NOTES="${FINAL_NOTES}\tinstall wanted packages\n"
fi

if [ "$INSTALL_TYPE" == "limited" ] && [ "$NIX_ON_DROID" == "false" ] && ! which nix >/dev/null
then
	printf "\nrecommending a nix installation "'(single user or global)'"\n"
fi

printf "\ninstallation finished\n"

if [ ! -e ~/.gitconfig ]
then
	FINAL_NOTES="${FINAL_NOTES}\tset up ~/.gitconfig\n"
fi

if [ ! -e ~/.ssh ]
then
	FINAL_NOTES="${FINAL_NOTES}\tset up ~/.ssh\n"
fi

if [ ! -z "$FINAL_NOTES" ]
then
	printf "\ndont forget to\n${FINAL_NOTES}"
fi
