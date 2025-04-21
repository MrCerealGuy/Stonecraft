--Map Generation Stuff

minetest.register_decoration({
	decoration = {
		"cavestuff:pebble_1",
		"cavestuff:pebble_2"
	},
	place_on = {
		"default:dirt_with_grass",
		"default:gravel",
		"default:stone",
		"default:permafrost_with_stones"
	},
	noise_params = {
		offset = 0,
		scale = 0.0078125,
		spread = {
			y = 100,
			z = 100,
			x = 100
		},
		seed = 0,
		octaves = 3,
		persist = 0.6,
		flags = "absvalue",
		lacunarity = 2
	},
	param2 = 0,
	flags = "all_floors",
	deco_type = "simple",
	param2_max = 3,
	y_min = -16,
	y_max = 48
})

minetest.register_decoration({
	decoration = {
		"cavestuff:desert_pebble_1",
		"cavestuff:desert_pebble_2"
	},
	place_on = {
		"default:desert_sand",
		"default:desert_stone"
	},
	noise_params = {
		offset = 0,
		scale = 0.0078125,
		spread = {
				y = 100,
				z = 100,
				x = 100
		},
		seed = 0,
		octaves = 3,
		persist = 0.6,
		flags = "absvalue",
		lacunarity = 2
	},
	param2 = 0,
	flags = "all_floors",
	deco_type = "simple",
	param2_max = 3,
	y_min = -16,
	y_max = 48
})