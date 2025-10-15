{
	description = "System config flake";

	inputs = {
		nixpkgs = {
			url = "github:nixos/nixpkgs/nixos-unstable";
		};
	};

	outputs = {
		self,
		nixpkgs,
	}:
	let
		system = "x86_64-linux";
		pkgs = import nixpkgs {
			system = "x86_64-linux";
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
			];
		};
	};
}
