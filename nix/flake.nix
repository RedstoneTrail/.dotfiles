{
  description = "System config flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      system = builtins.currentSystem;
      pkgs = import nixpkgs {
        system = system;
        config.allowUnfree = true;
      };
    in
    {
      packages.${system}.default = pkgs.symlinkJoin {
        name = "package-list";
        paths = [
          pkgs.zsh
          pkgs.neovim
          pkgs.git
          pkgs.openssh
          pkgs.nixfmt-rfc-style
        ];
      };
    };
}
