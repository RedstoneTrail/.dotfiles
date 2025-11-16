local mp = require("mp")

mp.observe_property("vo-configured", "string", function(_, val)
	if val == "yes" then
		mp.msg.info("GUI window active, enabling [gui] section")
		mp.command("enable-section gui")
	else
		mp.msg.info("No GUI, disabling [gui] section")
		mp.command("disable-section gui")
	end
end)
