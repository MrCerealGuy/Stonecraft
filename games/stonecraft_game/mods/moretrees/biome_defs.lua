
moretrees.beech_biome = {
	place_on = xcompat.materials.dirt_with_grass,
}

moretrees.palm_biome = {
	place_on = xcompat.materials.sand,
	min_elevation = -1,
	max_elevation = 1,
	spawn_by = {xcompat.materials.water_source},
	num_spawn_by = 10,
}

moretrees.date_palm_biome = {
	place_on = xcompat.materials.desert_sand,
	min_elevation = -1,
	max_elevation = 10,
	spawn_by = {xcompat.materials.water_source},
	num_spawn_by = 100,
}

moretrees.date_palm_biome_2 = {
	place_on = xcompat.materials.desert_sand,
	min_elevation = 11,
	max_elevation = 30,
	spawn_by = {xcompat.materials.water_source},
	num_spawn_by = 1,
}

moretrees.apple_tree_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 1,
	max_elevation = 10,
	biomes = {"deciduous_forest"},
	fill_ratio = 0.0001,
}

moretrees.oak_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 0,
	max_elevation = 10,
	fill_ratio = 0.0003
}

moretrees.sequoia_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 0,
	max_elevation = 10,
	fill_ratio = 0.0001,
}

moretrees.birch_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 10,
	max_elevation = 15,
	fill_ratio = 0.001,
}

moretrees.willow_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = -5,
	max_elevation = 5,
	spawn_by = {xcompat.materials.water_source},
	num_spawn_by = 5,
}

moretrees.rubber_tree_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = -5,
	max_elevation = 5,
	spawn_by = {xcompat.materials.water_source},
	num_spawn_by = 10,
}

moretrees.jungletree_biome = {
	place_on = {
		xcompat.materials.dirt,
		xcompat.materials.dirt_with_grass,
		"woodsoils:dirt_with_leaves_1",
		"woodsoils:grass_with_leaves_1",
		"woodsoils:grass_with_leaves_2",
		"default:dirt_with_rainforest_litter",
	},
	min_elevation = 1,
	spawn_by = minetest.get_modpath("default") and {"default:jungletree"} or nil,
	num_spawn_by = minetest.get_modpath("default") and 1 or nil,
	biomes = {"rainforest", "rainforest_swamp"},
}

moretrees.spruce_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 20,
}

moretrees.cedar_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 0,  --Added to solve an issue where cedar trees would sometimes spawn deep underground
	spawn_by = {xcompat.materials.water_source},
	num_spawn_by = 5,
}


-- Poplar requires a lot of water.
moretrees.poplar_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 0,
	max_elevation = 50,
	spawn_by = {xcompat.materials.water_source},
	num_spawn_by = 1,
}

-- Spawn an occasional poplar elsewhere.
moretrees.poplar_biome_2 = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 0,
	max_elevation = 50,
	spawn_by = {xcompat.materials.water_source},
	num_spawn_by = 10,
}

-- Subterranean lakes provide enough water for poplars to grow
moretrees.poplar_biome_3 = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 0,
	max_elevation = 50,
	spawn_by = {xcompat.materials.water_source},
	num_spawn_by = 1,
}

moretrees.poplar_small_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 0,
	max_elevation = 50,
	spawn_by = {xcompat.materials.water_source},
	num_spawn_by = 1,
}

moretrees.poplar_small_biome_2 = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 0,
	max_elevation = 50,
	spawn_by = {xcompat.materials.water_source},
	num_spawn_by = 5,
}


moretrees.fir_biome = {
	place_on = xcompat.materials.dirt_with_grass,
	min_elevation = 25,
}

moretrees.fir_biome_snow = {
	place_on = {"snow:dirt_with_snow", "snow:snow"},
	below_nodes = {xcompat.materials.dirt, xcompat.materials.dirt_with_grass, "snow:dirt_with_snow"},
}
