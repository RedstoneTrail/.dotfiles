{
	...
}:
{
	config = {
		services.tor = {
			enable = true;
			client.enable = true;
			torsocks.enable = true;
			settings = {
				ControlPort = 9051;
			};
		};

		programs.proxychains.enable = true;
	};
}
