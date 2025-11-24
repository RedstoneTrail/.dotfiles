{
  pkgs,
  ...
}:
{
  programs = {
    hyprland.enable = true;
    dconf = {
      enable = true;
      profiles.user.databases = [
        {
          settings = {
            "org/gnome/desktop/interface" = {
              cursor-theme = "catppuccin-frappe-green-cursors";
              application-prefer-dark-theme = true;
              color-scheme = "prefer-dark";
              gtk-theme = "Materia-dark";
            };
          };
          lockAll = true;
        }
      ];
    };
  };

  environment.etc = {
    "xdg/gtk-2.0/gtkrc".text = ''
      gtk-application-prefer-dark-theme = true
      gtk-cursor-theme-name="catppuccin-frappe-green-cursors"
      gtk-theme-name = "Materia-dark"
    '';

    "xdg/gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme = true
      gtk-cursor-theme-name = catppuccin-frappe-green-cursors
      gtk-theme-name = Materia-dark
    '';
  };

  services = {
    libinput.enable = true;
    dbus.enable = true;
    upower.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
    };
    udisks2.enable = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-mono
    noto-fonts-color-emoji
  ];

  environment.systemPackages = with pkgs; [
    alacritty
    catppuccin-cursors.frappeGreen
    dunst
    fuzzel
    grim
    hyprlock
    hyprpolkitagent
    libnotify
    materia-theme
    pipewire
    pulseaudio
    pulsemixer
    slurp
    waybar
    wireplumber
    wl-clipboard
    xrandr
    xwayland
  ];
}
