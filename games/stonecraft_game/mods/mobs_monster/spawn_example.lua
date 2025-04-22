
--[[ Spawn Template, defaults to values shown if line not provided

mobs:spawn({

	name = "",

		- Name of mob, must be provided e.g. "mymod:my_mob"

	nodes = {"group:soil, "group:stone"},

		- Nodes to spawn on top of.

	neighbors = {"air"},

		- Nodes to spawn beside.

	min_light = 0,

		- Minimum light level.

	max_light = 15,

		- Maximum light level, 15 is sunlight only.

	interval = 30,

		- Spawn interval in seconds.

	chance = 5000,

		- Spawn chance, 1 in every 5000 nodes.

	active_object_count = 1,

		- Active mobs of this type in area.

	min_height = -31000,

		- Minimum height level.

	max_height = 31000,

		- Maximum height level.

	day_toggle = nil,

		- Daytime toggle, true to spawn during day, false for night, nil for both

	on_spawn = nil,

		- On spawn function to run when mob spawns in world

	on_map_load = nil,

		- On map load, when true mob only spawns in newly generated map areas
})
]]--


-- Dirt Monster

mobs:spawn({
	name = "mobs_monster:dirt_monster",
	nodes = {"default:dirt_with_grass"},
	min_light = 0,
	max_light = 7,
	chance = 6000,
	active_object_count = 2,
	min_height = 0,
	day_toggle = false,
})

-- Dungeon Master

mobs:spawn({
	name = "mobs_monster:dungeon_master",
	nodes = {"default:stone"},
	max_light = 5,
	chance = 9000,
	active_object_count = 1,
	max_height = -70,
})

-- Lava Flan

mobs:spawn({
	name = "mobs_monster:lava_flan",
	nodes = {"default:lava_source"},
	chance = 1500,
	active_object_count = 1,
	max_height = 0,
})

-- Mese Monster

mobs:spawn({
	name = "mobs_monster:mese_monster",
	nodes = {"default:stone"},
	max_light = 7,
	chance = 5000,
	active_object_count = 1,
	max_height = -20,
})

-- Oerkki

mobs:spawn({
	name = "mobs_monster:oerkki",
	nodes = {"default:stone"},
	max_light = 7,
	chance = 7000,
	max_height = -10,
})

-- Sand Monster

mobs:spawn({
	name = "mobs_monster:sand_monster",
	nodes = {"default:desert_sand"},
	chance = 7000,
	active_object_count = 2,
	min_height = 0,
})

-- Spider (above ground)

mobs:spawn({
	name = "mobs_monster:spider",
	nodes = {
		"default:dirt_with_rainforest_litter", "default:snowblock",
		"default:snow", "ethereal:crystal_dirt", "ethereal:cold_dirt"
	},
	min_light = 0,
	max_light = 8,
	chance = 7000,
	active_object_count = 1,
	min_height = 25,
	max_height = 31000,
})

-- Spider (below ground)
mobs:spawn({
	name = "mobs_monster:spider",
	nodes = {"default:stone_with_mese", "default:mese", "default:stone"},
	min_light = 0,
	max_light = 7,
	chance = 7000,
	active_object_count = 1,
	min_height = -31000,
	max_height = -40,
})

-- Stone Monster

mobs:spawn({
	name = "mobs_monster:stone_monster",
	nodes = {"default:stone", "default:desert_stone", "default:sandstone"},
	max_light = 7,
	chance = 7000,
	max_height = 0,
})

-- Tree Monster

mobs:spawn({
	name = "mobs_monster:tree_monster",
	nodes = {"default:leaves", "default:jungleleaves"},
	max_light = 7,
	chance = 7000,
	min_height = 0,
	day_toggle = false,
})

-- Land Guard

mobs:spawn({
	name = "mobs_monster:land_guard",
	nodes = {
		"default:snow", "default:ice", "default:stone",
		"default:dry_dirt_with_dry_grass", "ethereal:dry_dirt"
	},
	max_light = 7,
	chance = 25000,
	min_height = 0,
	active_object_count = 1,
})
