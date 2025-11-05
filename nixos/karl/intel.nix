{
	pkgs,
	...
}:
{
	environment.systemPackages = with pkgs; [
		intel-compute-runtime
	];
}
