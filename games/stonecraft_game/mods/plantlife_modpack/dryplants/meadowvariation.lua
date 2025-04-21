-- @reviewer: couldn't even find using biome_lib
minetest.register_decoration({
	decoration = {"dryplants:grass_short"},
	fill_ratio = 0.8,
	y_min = 1,
	y_max = 40,
	place_on = {
		"default:dirt_with_grass",
	},
	deco_type = "simple",
	flags = "all_floors"
})
