{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg-enabled = config.dotfiles.cli;
  cfg-hardware-access = config.dotfiles.hardware-accessible;
  genAttrsConst = keys: value: lib.attrsets.genAttrs keys (_: value);
in
{
  config = lib.mkIf cfg-enabled.enable {
    xdg.mime.defaultApplications = {
      "application/pdf" = "org.pwmt.zathura.desktop";
      "x-scheme-handler/mailto" = "neomutt.desktop";
      "image/svg+xml" = "inkview.desktop";
    }
    // (genAttrsConst [
      "text/html"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
      "x-scheme-handler/about"
      "x-scheme-handler/unknown"
    ] "firefox.desktop")
    // (genAttrsConst [
      "image/png"
      "image/jpeg"
      "image/webp"
      "image/avif"
      "image/gif"
      "video/vnd.avi"
      "video/mp4"
      "video/mpeg"
      "video/webm"
      "video/ogg"
      "audio/mp4"
      "audio/x-mpegurl"
      "audio/x-flac"
      "audio/x-wav"
      "audio/x-opus+ogg"
      "audio/mpeg"
      "audio/ogg"
      "audio/vnd.wave"
    ] "mpv.desktop")
    // (genAttrsConst [
      "inode/directory"
    ] "nvim.desktop");

    programs = {
      zsh.enable = true;
    };

    environment.systemPackages = with pkgs; [
      # communications
      abook
      aerc
      neomutt
      pass

      # system-level
      brightnessctl
      cyme # lsusb-like

      # for nvim
      buf
      lua-language-server
      neovim
      nixd
      nixfmt
      prettier
      texlab
      tinymist
      websocat

      # networking
      arp-scan
      dig
      impala
      nmap

      # useful
      bc
      custom.mountui
      fd
      ffmpeg-full
      file
      fzf
      jq
      (mpv.override {
        scripts = with mpvScripts; [
          uosc
          mpris
          mpv-image-viewer.detect-image
          mpv-image-viewer.image-positioning
        ];
      })
      ripgrep
      socat
      tmux
      tree
      w3m-nographics
      wget
      zip
      units
      unzip

      # man
      man-pages
      man-pages-posix
      tldr

      # git
      gh
      git

      # development
      gnumake
      (python3.withPackages (python-pkgs: [
        python3Packages.pygobject3
        python3Packages.requests
      ]))
      typst

      # gtk
      gtk4
      gtk3
      gtk2

      # monitoring
      htop-vim
      hyperfine
      lm_sensors
      playerctl
      smartmontools
      cpufrequtils

      # fun
      catimg
      figlet
      glow
      id3v2
      lolcat
      vitetris
      yt-dlp
    ];

    documentation = {
      dev.enable = true;
      # man.generateCaches = true;
    };

    programs.gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };

    services.smartd.enable = lib.mkIf cfg-hardware-access.enable true;
  };
}
