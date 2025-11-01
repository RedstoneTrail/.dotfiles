{
  pkgs,
  ...
}:
{
  services.libinput.enable = true;

  programs = {
    hyprland.enable = true;
    dconf = {
        enable = true;
        profiles.user.databases = [
          {
            settings = {
              "org/gnome/desktop/interface" = {
                cursor-theme = "catppuccin-frappe-light-cursors";
                application-prefer-dark-theme = true;
                color-scheme = "prefer-dark";
                gtk-theme = "Catppuccin-GTK-Green-Dark-Frappe";
              };
            };
            lockAll = true;
          }
        ];
      };
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-mono
    noto-fonts-color-emoji
  ];

  environment.systemPackages = with pkgs; [
    alacritty
    dunst
    fuzzel
    grim
    hyprlock
    pipewire
    pulseaudio
    pulsemixer
    slurp
    waybar
    wireplumber
    wl-clipboard
    xwayland
  ];
}
