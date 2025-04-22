unused_args = false

globals = {
	"biome_lib"
}

read_globals = {
	-- Stdlib
	string = {fields = {"split", "trim"}},
	table = {fields = {"copy"}},

	-- Minetest
	"minetest", "vector",
	"dump", "PerlinNoise",

	-- mods
	"default",
}
