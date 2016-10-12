g_PluginInfo = {
	Name = "DisguiseCraft",
	Version = "2",
	Date = "2016-10-12",
	SourceLocation = "https://github.com/mathiascode/DisguiseCraft",
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
