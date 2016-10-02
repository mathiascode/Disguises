-- Info.lua

-- Implements the g_PluginInfo standard plugin description

g_PluginInfo =
{
	Name = "DisguiseCraft",
	Version = "1",
	Description = [[Plugin for Cuberite that allows you to disguise as an entity.]],

	Commands =
	{
		["/disguise"] =
		{
			Permission = "disguisecraft.disguise",
			HelpString = "Disguises you as an entity",
			Handler = HandleDisguiseCommand,
			Alias = { "/d", "/dis", }
		},
		["/undisguise"] =
		{
			Permission =  "disguisecraft.undisguise",
			HelpString =  "Removes your entity disguise",
			Handler =  HandleUnDisguiseCommand,
			Alias = { "/ud", "/undis", }
		},
	},
}
