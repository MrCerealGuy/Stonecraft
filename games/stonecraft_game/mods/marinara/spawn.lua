--- seashells

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:sand"},
		sidelen = 16,
		noise_params = {
			offset = -0,
			scale = 0.01,
			spread = {x = 100, y = 100, z = 100},
			seed = 3789,
			octaves = 4,
			persist = 0.8,
		},
    place_offset_y=-1,
    flags = "place_center_x,place_center_z,force_placement",
		biomes = {"savanna_shore", "savanna_ocean", "coniferous_forest_ocean", "sandstone_desert_ocean", "grassland_ocean",},
		y_max = 2,
		y_min = 0,
		decoration = "marinara:sand_with_seashells"
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:sand"},
		sidelen = 16,
		noise_params = {
			offset = -0,
			scale = 0.01,
			spread = {x = 100, y = 100, z = 100},
			seed = 3789,
			octaves = 4,
			persist = 0.8,
		},
    place_offset_y=-1,
    flags = "place_center_x,place_center_z,force_placement",
		biomes = {"savanna_shore", "savanna_ocean", "coniferous_forest_ocean", "sandstone_desert_ocean", "grassland_ocean",},
		y_max = 2,
		y_min = 0,
		decoration = "marinara:sand_with_seashells_broken"
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:sand"},
		sidelen = 16,
		noise_params = {
			offset = -0,
			scale = 0.01,
			spread = {x = 100, y = 100, z = 100},
			seed = 3789,
			octaves = 4,
			persist = 0.8,
		},
    place_offset_y=-1,
    flags = "place_center_x,place_center_z,force_placement",
		biomes = {"savanna_shore", "savanna_ocean", "coniferous_forest_ocean", "sandstone_desert_ocean", "grassland_ocean",},
		y_max = 2,
		y_min = 0,
		decoration = "marinara:sand_with_seashells_white"
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:sand"},
		sidelen = 16,
		noise_params = {
			offset = -0,
			scale = 0.01,
			spread = {x = 100, y = 100, z = 100},
			seed = 3789,
			octaves = 4,
			persist = 0.8,
		},
    place_offset_y=-1,
    flags = "place_center_x,place_center_z,force_placement",
		biomes = {"savanna_shore", "savanna_ocean", "coniferous_forest_ocean", "sandstone_desert_ocean", "grassland_ocean",},
		y_max = 2,
		y_min = 0,
		decoration = "marinara:sand_with_seashells_yellow"
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:sand"},
		sidelen = 16,
		noise_params = {
			offset = -0,
			scale = 0.01,
			spread = {x = 100, y = 100, z = 100},
			seed = 3789,
			octaves = 4,
			persist = 0.8,
		},
    place_offset_y=-1,
    flags = "place_center_x,place_center_z,force_placement",
		biomes = {"savanna_shore", "savanna_ocean", "coniferous_forest_ocean", "sandstone_desert_ocean", "grassland_ocean",},
		y_max = 2,
		y_min = 0,
		decoration = "marinara:sand_with_seashells_brown"
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:sand"},
		sidelen = 16,
		noise_params = {
			offset = -0,
			scale = 0.01,
			spread = {x = 100, y = 100, z = 100},
			seed = 3789,
			octaves = 4,
			persist = 0.8,
		},
    place_offset_y=-1,
    flags = "place_center_x,place_center_z,force_placement",
		biomes = {"savanna_shore", "savanna_ocean", "coniferous_forest_ocean", "sandstone_desert_ocean", "grassland_ocean",},
		y_max = 2,
		y_min = 0,
		decoration = "marinara:sand_with_seashells_pink"
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:sand"},
		sidelen = 16,
		noise_params = {
			offset = -0,
			scale = 0.01,
			spread = {x = 100, y = 100, z = 100},
			seed = 3789,
			octaves = 4,
			persist = 0.8,
		},
    place_offset_y=-1,
    flags = "place_center_x,place_center_z,force_placement",
		biomes = {"savanna_shore", "savanna_ocean", "coniferous_forest_ocean", "sandstone_desert_ocean", "grassland_ocean",},
		y_max = 2,
		y_min = 0,
		decoration = "marinara:sand_with_seashells_orange"
	})


--- wrecks

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.00001,
    biomes = {"cold_desert_ocean", "coniferous_forest_ocean", "deciduous_forest_ocean", "grassland_ocean", "sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean", "tundra_ocean", "icesheet_ocean", "snowy_grassland_ocean",},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -10,
    y_min = -20,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_wreck.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.00001,
    biomes = {"cold_desert_ocean", "coniferous_forest_ocean", "deciduous_forest_ocean", "grassland_ocean", "sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean", "tundra_ocean", "icesheet_ocean", "snowy_grassland_ocean",},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -10,
    y_min = -20,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_wreck2.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.00001,
    biomes = {"cold_desert_ocean", "coniferous_forest_ocean", "deciduous_forest_ocean", "grassland_ocean", "sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean", "tundra_ocean", "icesheet_ocean", "snowy_grassland_ocean",},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -10,
    y_min = -20,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_wreck3.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.00001,
    biomes = {"cold_desert_ocean", "coniferous_forest_ocean", "deciduous_forest_ocean", "grassland_ocean", "sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean", "tundra_ocean", "icesheet_ocean", "snowy_grassland_ocean",},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -10,
    y_min = -20,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_wreckbounty.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.00001,
    biomes = {"cold_desert_ocean", "coniferous_forest_ocean", "deciduous_forest_ocean", "grassland_ocean", "sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean", "tundra_ocean", "icesheet_ocean", "snowy_grassland_ocean",},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -10,
    y_min = -20,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_wreckbounty2.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.00001,
    biomes = {"cold_desert_ocean", "coniferous_forest_ocean", "deciduous_forest_ocean", "grassland_ocean", "sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean", "tundra_ocean", "icesheet_ocean", "snowy_grassland_ocean",},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -10,
    y_min = -20,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_wreckbounty3.mts",
	rotation = "random",
})

--- cold oceans

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0009,
    biomes = {"cold_desert_ocean", "tundra_ocean", "icesheet_ocean", "snowy_grassland_ocean",},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -1,
    y_min = -4,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coast_rock.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0009,
    biomes = {"cold_desert_ocean", "tundra_ocean", "icesheet_ocean", "snowy_grassland_ocean",},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -1,
    y_min = -4,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coast_rock2.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0009,
    biomes = {"cold_desert_ocean", "tundra_ocean", "icesheet_ocean", "snowy_grassland_ocean",},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -1,
    y_min = -4,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coast_rock3.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0009,
    biomes = {"cold_desert_ocean", "tundra_ocean", "icesheet_ocean", "snowy_grassland_ocean",},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -1,
    y_min = -4,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coast_rock4.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0009,
    biomes = {"cold_desert_ocean", "tundra_ocean", "icesheet_ocean", "snowy_grassland_ocean",},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -1,
    y_min = -4,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coast_rock5.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0009,
    biomes = {"cold_desert_ocean", "tundra_ocean", "icesheet_ocean", "snowy_grassland_ocean",},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -1,
    y_min = -4,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coast_rock6.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0009,
    biomes = {"cold_desert_ocean", "tundra_ocean", "icesheet_ocean", "snowy_grassland_ocean",},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -3,
    y_min = -5,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coast_rock7.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0007,
    biomes = {"cold_desert_ocean", "tundra_ocean", "icesheet_ocean", "snowy_grassland_ocean", "coniferous_forest_ocean", "grassland_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -2,
    y_min = -3,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_oister_bank.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0007,
    biomes = {"cold_desert_ocean", "tundra_ocean", "icesheet_ocean", "snowy_grassland_ocean", "coniferous_forest_ocean", "grassland_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -2,
    y_min = -3,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_oister_bank2.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0007,
    biomes = {"cold_desert_ocean", "tundra_ocean", "icesheet_ocean", "snowy_grassland_ocean", "coniferous_forest_ocean", "grassland_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -2,
    y_min = -3,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_oister_bank3.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0007,
    biomes = {"cold_desert_ocean", "coniferous_forest_ocean", "grassland_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -2,
    y_min = -3,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_musslebank.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0007,
    biomes = {"cold_desert_ocean", "coniferous_forest_ocean", "grassland_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -2,
    y_min = -3,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_musslebank2.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0007,
    biomes = {"cold_desert_ocean", "coniferous_forest_ocean", "grassland_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -2,
    y_min = -3,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_musslebank3.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0007,
    biomes = {"snowy_grassland_ocean", "coniferous_forest_ocean", "grassland_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -5,
    y_min = -10,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coldreef.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0007,
    biomes = {"snowy_grassland_ocean", "coniferous_forest_ocean", "grassland_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -5,
    y_min = -10,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coldreef2.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0007,
    biomes = {"snowy_grassland_ocean", "coniferous_forest_ocean", "grassland_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -5,
    y_min = -10,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coldreef3.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0007,
    biomes = {"snowy_grassland_ocean", "coniferous_forest_ocean", "grassland_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -5,
    y_min = -10,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coldreef4.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0007,
    biomes = {"snowy_grassland_ocean", "coniferous_forest_ocean", "grassland_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -5,
    y_min = -10,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coldreef5.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0007,
    biomes = {"snowy_grassland_ocean", "coniferous_forest_ocean", "grassland_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -5,
    y_min = -10,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coldreef6.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 0.2,
			spread = {x = 300, y = 300, z = 300},
			seed = 87112,
			octaves = 5,
			persist = 0.9
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -11,
		y_min = -16,
		flags = "force_placement",
		decoration = "marinara:sand_with_kelp",
		param2 = 48,
		param2_max = 96,
	})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand", "naturalbiomes:palmbeach_sand"},
		sidelen = 16,
noise_params = {
			offset = -0.04,
			scale = 0.2,
			spread = {x = 100, y = 100, z = 100},
			seed = 87112,
			octaves = 7,
			persist = 0.9
		},
    biomes = {"coniferous_forest_ocean", "deciduous_forest_ocean", "grassland_ocean", "sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean", "tundra_ocean", "snowy_grassland_ocean", "naturalbiomes:palmbeach",},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -3,
    y_min = -8,
    place_offset_y=0,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_seagrass.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand", "naturalbiomes:palmbeach_sand"},
		sidelen = 16,
noise_params = {
			offset = -0.04,
			scale = 0.2,
			spread = {x = 100, y = 100, z = 100},
			seed = 87112,
			octaves = 7,
			persist = 0.9
		},
    biomes = {"coniferous_forest_ocean", "deciduous_forest_ocean", "grassland_ocean", "sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean", "tundra_ocean", "snowy_grassland_ocean", "naturalbiomes:palmbeach",},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -4,
    y_min = -8,
    place_offset_y=0,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_seagrass_long.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand", "naturalbiomes:palmbeach_sand"},
		sidelen = 16,
noise_params = {
			offset = -0.04,
			scale = 0.2,
			spread = {x = 100, y = 100, z = 100},
			seed = 87112,
			octaves = 7,
			persist = 0.9
		},
    biomes = {"deciduous_forest_ocean", "grassland_ocean", "coniferous_forest_ocean", "naturalbiomes:palmbeach",},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -0,
    y_min = -3,
    place_offset_y=0,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_alage.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
noise_params = {
			offset = -0.04,
			scale = 0.2,
			spread = {x = 100, y = 100, z = 100},
			seed = 87112,
			octaves = 7,
			persist = 0.9
		},
    biomes = {"cold_desert_ocean", "coniferous_forest_ocean", "grassland_ocean", "tundra_ocean", "icesheet_ocean", "snowy_grassland_ocean",},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -1,
    y_min = -5,
    place_offset_y=0,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_brownalage.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
noise_params = {
			offset = -0.04,
			scale = 0.2,
			spread = {x = 100, y = 100, z = 100},
			seed = 87112,
			octaves = 7,
			persist = 0.9
		},
    biomes = {"deciduous_forest_ocean", "deciduous_forest_shore"},
    spawn_by = "default:water_source",
    flags = "place_center_x,place_center_z,force_placement",
    y_max = 1,
    y_min = 0,
    place_offset_y=0,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_reed.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt"},
		sidelen = 16,
noise_params = {
			offset = -0.04,
			scale = 0.2,
			spread = {x = 100, y = 100, z = 100},
			seed = 87112,
			octaves = 7,
			persist = 0.9
		},
    biomes = {"deciduous_forest_ocean", "deciduous_forest_shore"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -0,
    y_min = -0,
    place_offset_y=0,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_reed2.mts",
	rotation = "random",
})

--- tropical oceans

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0003,
    biomes = {"sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -6,
    y_min = -12,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coralreef.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0003,
    biomes = {"sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -6,
    y_min = -12,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coralreef2.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0003,
    biomes = {"sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -6,
    y_min = -12,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coralreef3.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0003,
    biomes = {"sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -6,
    y_min = -12,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coralreef_blue.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0003,
    biomes = {"sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -6,
    y_min = -12,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coralreef_blue2.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0003,
    biomes = {"sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -6,
    y_min = -12,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coralreef_blue3.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0003,
    biomes = {"sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -6,
    y_min = -12,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coralreef_brown.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0003,
    biomes = {"sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -6,
    y_min = -12,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coralreef_brown2.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0003,
    biomes = {"sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -6,
    y_min = -12,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coralreef_brown3.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0003,
    biomes = {"sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -6,
    y_min = -12,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coralreef_green.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0003,
    biomes = {"sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -6,
    y_min = -12,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coralreef_green2.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0003,
    biomes = {"sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -6,
    y_min = -12,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coralreef_green3.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0003,
    biomes = {"sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -6,
    y_min = -12,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coralreef_pink.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0003,
    biomes = {"sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -6,
    y_min = -12,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coralreef_pink2.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0003,
    biomes = {"sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -6,
    y_min = -12,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coralreef_pink3.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0003,
    biomes = {"sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -6,
    y_min = -12,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coralreef_red.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0003,
    biomes = {"sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -6,
    y_min = -12,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coralreef_red2.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0003,
    biomes = {"sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -6,
    y_min = -12,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coralreef_red3.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0003,
    biomes = {"sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -6,
    y_min = -12,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coralreef_yellow.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0003,
    biomes = {"sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -6,
    y_min = -12,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coralreef_yellow2.mts",
	rotation = "random",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:sand"},
		sidelen = 16,
    fill_ratio = 0.0003,
    biomes = {"sandstone_desert_ocean", "savanna_ocean", "rainforest_ocean"},
    flags = "place_center_x,place_center_z,force_placement",
    y_max = -6,
    y_min = -12,
    place_offset_y=-1,
    schematic = minetest.get_modpath("marinara").."/schematics/marinara_coralreef_yellow3.mts",
	rotation = "random",
})
