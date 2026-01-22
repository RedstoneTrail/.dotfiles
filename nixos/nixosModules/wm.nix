{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.dotfiles.graphical;
in
{
  config = lib.mkIf cfg.enable {
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
        gtk-cursor-theme-name="catppuccin-frappe-green-cursors"
        gtk-application-prefer-dark-theme = true
        gtk-theme-name = "Materia-dark"
      '';

      "xdg/gtk-3.0/settings.ini".text = ''
        [Settings]
        gtk-cursor-theme-name = catppuccin-frappe-green-cursors
        gtk-application-prefer-dark-theme = true
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

    environment.systemPackages =
      with pkgs;
      [ alacritty ] # terminal
      ++ [
        catppuccin-cursors.frappeGreen
        materia-theme
      ] # theming
      ++ [
        fuzzel
        gimp3
        grim
        hyprlock
        pulsemixer
        slurp
        waybar
        wl-clipboard
        zathura
      ] # utility
      ++ [
        dunst
        hyprpolkitagent
        libnotify
        pipewire
        poweralertd
        pulseaudio
        wireplumber
        xwayland
      ]; # daemons
  };
}
