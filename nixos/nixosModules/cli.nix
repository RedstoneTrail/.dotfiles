{
  pkgs,
  ...
}:
{
  programs = {
    zsh.enable = true;
  };

  environment.systemPackages = with pkgs; [
    abook
    aerc
    brightnessctl
    catimg
    gh
    git
    gnumake
    htop-vim
    impala
    jq
    neovim
    pass
    playerctl
    ripgrep
    tmux
    wget
    nixfmt-rfc-style
    nixd
    texlab
    fd
  ];

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
}
