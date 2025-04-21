minetest.register_decoration({
	decoration = {
		"default:grass_1",
		"default:grass_2",
		"default:grass_3",
		"default:grass_4",
		"default:grass_5"
	},
	fill_ratio = 0.8,
	y_min = 1,
	y_max = 40,
	place_on = {
		"default:dirt_with_grass",
		"stoneage:grass_with_silex",
		"sumpf:peat",
		"sumpf:sumpf"
	},
	deco_type = "simple",
	flags = "all_floors"
})
