.PHONY: install nix home config nix-on-droid

install: home config
	# installing nix if present
	if [ "$(shell hostname)" == "localhost" ] && [ "$(shell whoami)" == "nix-on-droid" ]; then make nix-on-droid; fi
	if [ ! -z "$(shell command -v nix)" ]; then make nix; fi

home:
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

	./scripts/install-firefox

config:
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

	rm -rf ~/.config/tridactyl
	ln -s $(realpath tridactyl) ~/.config/tridactyl

	rm -rf ~/.config/waybar
	ln -s $(realpath waybar) ~/.config/waybar

	rm -rf ~/.config/zathura
	ln -s $(realpath zathura) ~/.config/zathura

nix:
	# nix is present, install profile, unless its already installed, then update it
	nix profile list --json | grep '.dotfiles?dir=nix' && nix profile upgrade --all --impure || nix profile install ./nix --impure --priority 4

nix-on-droid:
	# on nix-on-droid, install its config
	nix-on-droid switch --flake ~/.dotfiles/nix-on-droid/
