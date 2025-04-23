title = "Creatures Revived"
project = "cmer"
format = "markdown"
not_luadoc = true
wrap = true
boilerplate = true

file = {"register.lua", "common.lua"}

new_type("setting", "Settings")
new_type("feature", "Features")

custom_tags = {
	{
		"settype",
		title = "Type",
	},
	{
		"default",
		title = "Default value",
	},
}
