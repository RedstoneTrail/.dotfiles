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
  ];
}
