g_PluginInfo = {
	Name = "Disguises",
	Version = "2.1",
	Date = "2017-02-22",
	SourceLocation = "https://github.com/mathiascode/Disguises",
	Description = [[Plugin for Cuberite that allows you to disguise as an entity.]],

	Commands =
	{
		["/disguise"] =
		{
			Permission = "disguises.disguise",
			HelpString = "Disguises you as an entity",
			Handler = HandleDisguiseCommand,
			Alias = { "/d", "/dis", }
		},
		["/undisguise"] =
		{
			Permission =  "disguises.undisguise",
			HelpString =  "Removes your entity disguise",
			Handler =  HandleUnDisguiseCommand,
			Alias = { "/ud", "/undis", }
		},
	},
}
