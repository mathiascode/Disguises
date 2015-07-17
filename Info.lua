-- Info.lua

-- Implements the g_PluginInfo standard plugin description

g_PluginInfo =
{
	Name = "DisguiseCraft",
	Version = "0.1",
	Description = [[Plugin for Cuberite that allows you to disguise as a mob. It's not like similar plugins for Bukkit, due to Cuberite's limitations. You see the mob and it doesn't always follow you, but I'll try to make the best inside Cuberite limitations.]],

	Commands =
	{
		["/disguise"] =
		{
			Permission = "disguisecraft.disguise",
			HelpString = "Allows you to disguise as a mob.",
			Handler = HandleDisguiseCommand,
			Alias = { "/d", "/dis", }
		},
		["/undisguise"] =
		{
			Permission =  "disguisecraft.undisguise",
			HelpString =  "Remove your mob disguise.",
			Handler =  HandleUnDisguiseCommand,
			Alias = { "/ud", "/undis", }
		},
	},
}
