-- Info.lua

-- Implements the g_PluginInfo standard plugin description

g_PluginInfo =
{
	Name = "DisguiseCraft",
	Version = "0.1",
	Description = [[Plugin for MCServer that allows you to disguise as a mob.]],

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
