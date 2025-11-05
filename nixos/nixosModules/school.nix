{
	pkgs,
	lib,
	...
}:
{
	config = {
		environment.systemPackages = with pkgs; [
			google-chrome
			zathura
		];

		allowed-unfree-packages = [
			"google-chrome"
		];

		security.pki.certificates = [
			(builtins.readFile ../../certificates/securly.pem)
			(builtins.readFile ../../certificates/school.pem)
		];
	};
}
