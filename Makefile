.PHONY: install

install: install-home install-config
	# installing nix if present
	if [ ! -z "$(shell which nix)" ]; then make install-nix; fi
	if [ "$(shell hostname)" == "localhost" ] && [ "$(shell whoami)" == "nix-on-droid" ]; then make install-nix-on-droid; fi

install-home:
	mkdir -p ~/.abook
	rm -rf ~/.abook/abookrc
	ln -s $(realpath abookrc) ~/.abook/abookrc

	rm -f ~/.clang-format
	ln -s $(realpath .clang-format) ~/.clang-format

	mkdir -p ~/.w3m
	rm -rf ~/.w3m/config
	ln -s $(realpath .w3m/config) ~/.w3m/config

	rm -f ~/.zshrc
	ln -s $(realpath .zshrc) ~/.zshrc

install-config:
	rm -rf ~/.config/aerc
	ln -s $(realpath aerc) ~/.config/aerc
	chmod 600 ~/.config/aerc/accounts.conf

	rm -rf ~/.config/alacritty
	ln -s $(realpath alacritty) ~/.config/alacritty

	rm -rf ~/.config/dunst
	ln -s $(realpath dunst) ~/.config/dunst

	rm -rf ~/.config/fuzzel
	ln -s $(realpath fuzzel) ~/.config/fuzzel

	rm -rf ~/.config/hypr
	ln -s $(realpath hypr) ~/.config/hypr

	rm -rf ~/.config/MangoHud
	ln -s $(realpath MangoHud) ~/.config/MangoHud

	rm -rf ~/.config/mpv
	ln -s $(realpath mpv) ~/.config/mpv

	rm -rf ~/.config/nvim
	ln -s $(realpath nvim) ~/.config/nvim

	rm -rf ~/.config/pulseaudio-ctl
	ln -s $(realpath pulseaudio-ctl) ~/.config/pulseaudio-ctl

	rm -f ~/.tmux.conf
	ln -s $(realpath tmux.conf) ~/.tmux.conf

	rm -rf ~/.config/waybar
	ln -s $(realpath waybar) ~/.config/waybar

	rm -rf ~/.config/zathura
	ln -s $(realpath zathura) ~/.config/zathura

install-nix:
	# nix is present, install profile, unless its already installed, then update it
	nix profile list --json | grep '.dotfiles?nix' && nix profile upgrade --all --impure || nix profile install ./nix --impure --priority 4

install-nix-on-droid:
	# on nix-on-droid install its config
	rm -rf ~/.config/nix-on-droid
	ln -s $(realpath nix-on-droid) ~/.config/nix-on-droid
	nix-on-droid switch --flake ~/.config/nix-on-droid/
