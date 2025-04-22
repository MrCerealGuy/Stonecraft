unused = false

globals = {
	"currency", "barter",
	"default"
}

read_globals = {
	-- Lua
	string = {fields = {"split", "trim"}},
	table = {fields = {"copy", "getn"}},

	-- Minetest
	"minetest",
	"PseudoRandom", "ItemStack",
	"VoxelArea", "VoxelManip",
	"Settings", "vector",

	-- Mods
	"loot", "pipeworks"
}
