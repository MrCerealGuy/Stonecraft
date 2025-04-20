--Before starting a new game write 6 or 7 in order to regulate the spawns
-- (7 works also with flat and fractal).

local v6 = nssm.mymapgenis == 6 -- true if set to 6
local mm = nssm.multimobs

-- Spawning parameters

if mm ~= 0 then

	-- V6 MAPGEN

	if v6 then

		-- ANTS (why only V6 mapgen ?)

		mobs:spawn({
			name = "nssm:ant_queen",
			nodes = {"nssm:ant_dirt"},
			interval = 60,
			chance = (200000 / mm)
		})

		mobs:spawn({
			name = "nssm:ant_soldier",
			nodes = {"nssm:ant_dirt"},
			interval = 7,
			chance = (30000 / mm),
			active_object_count = 4
		})

		mobs:spawn({
			name = "nssm:ant_worker",
			nodes = {"nssm:ant_dirt"},
			interval = 5,
			chance = (10000 / mm),
			active_object_count = 5
		})

	else -- ALL OTHER MAPGENS

		-- SWIMMING DUCK (river water only)

		mobs:spawn({
			name = "nssm:swimming_duck",
			nodes = {"default:river_water_source"},
			neighbors = {"default:sand","default:river_water_source"},
			max_height = 300,
			interval = 60,
			chance = (3000000 / mm)
		})

		-- SAVANNA

		mobs:spawn({
			name = "nssm:felucco",
			nodes = {"default:dirt_with_dry_grass", "default:dry_dirt_with_dry_grass"},
			neighbors = {"default:dirt_with_dry_grass"},
			min_height = -200,
			interval = 80,
			chance = (20000000 / mm)
		})
	end

	-- NSSB SPECIAL

	if minetest.get_modpath("nssb") then

		mobs:spawn({
			name = "nssm:xgaloctopus",
			nodes = {"default:water_source"},
			neighbors = {"nssb:marine_brick"},
			max_height = 0,
			interval = 20,
			chance = (800000 / mm)
		})
	end

	-- FOREST

	mobs:spawn({
		name = "nssm:larva",
		nodes = {"default:dirt_with_grass"},
		neighbors = {"default:tree", "default:aspen_tree"},
		max_height = 140,
		interval = 40,
		chance = v6 and (200000 / mm) or (800000 / mm)
	})

	mobs:spawn({
		name = "nssm:masticone",
		nodes = {"default:dirt_with_grass"},
		neighbors = {"default:tree", "default:aspen_tree"},
		max_height = 140,
		interval = v6 and 120 or 180,
		chance = v6 and (5000000 / mm) or (6000000 / mm),
		active_object_count = 2
	})

	-- PINE FOREST

	mobs:spawn({
		name = "nssm:pumpboom_small",
		nodes = {
			"default:dirt_with_coniferous_litter", "default:dirt_with_snow",
			"default:snowblock"
		},
		neighbors = {"default:pine_tree"},
		interval = v6 and 30 or 80,
		chance = v6 and (600000 / mm) or (1400000 / mm)
	})

	mobs:spawn({
		name = "nssm:pumpboom_medium",
		nodes = {
			"default:dirt_with_coniferous_litter", "default:dirt_with_snow",
			"default:snowblock"
		},
		neighbors = {"default:pine_tree"},
		interval = v6 and 30 or 80,
		chance = v6 and (800000 / mm) or (1600000 / mm)
	})

	mobs:spawn({
		name = "nssm:pumpboom_large",
		nodes = {
			"default:dirt_with_coniferous_litter", "default:dirt_with_snow",
			"default:snowblock"
		},
		neighbors = {"default:pine_tree"},
		interval = v6 and 30 or 80,
		chance = v6 and (1000000 / mm) or (1800000 / mm)
	})

	if minetest.settings:get_bool("nssm.enable_pumpking_spawn") ~= false then
	mobs:spawn({
		name = "nssm:pumpking",
		nodes = {
			"default:dirt_with_coniferous_litter", "default:dirt_with_snow",
			"default:snowblock"
		},
		neighbors = {"default:pine_needles", "default:pine_tree"},
		max_light = v6 and 15 or 12,
		interval = 120,
		chance = (8000000 / mm)
	})
	end

	-- ICE

	mobs:spawn({
		name = "nssm:icelamander",
		nodes = {"default:snowblock", "default:ice", "default:dirt_with_snow"},
		neighbors = {"default:snowblock", "default:ice", "default:dirt_with_snow"},
		interval = v6 and 120 or 180,
		chance = v6 and (25000000 / mm) or (120000000 / mm)
	})

	mobs:spawn({
		name = "nssm:icesnake",
		nodes = {"default:snowblock", "default:ice", "default:dirt_with_snow"},
		neighbors = {"default:snowblock", "default:ice", "default:dirt_with_snow"},
		interval = v6 and 30 or 40,
		chance = v6 and (6000000 / mm) or (20000000 / mm)
	})

	mobs:spawn({
		name = "nssm:white_werewolf",
		nodes = {"default:dirt_with_snow","default:snowblock"},
		min_height = v6 and 20 or 31000,
		interval = v6 and 60 or 40,
		chance = v6 and (9000000 / mm) or (22000000 / mm)
	})

	mobs:spawn({
		name = "nssm:snow_biter",
		nodes = {"default:snowblock", "default:ice", "default:dirt_with_snow"},
		neighbors = {"default:snowblock", "default:ice", "default:dirt_with_snow"},
		chance = v6 and (6000000 / mm) or (20000000 / mm)
	})

	-- MOUNTAINS

	mobs:spawn({
		name = "nssm:echidna",
		nodes = {"default:dirt_with_grass"},
		neighbors = {"default:dirt_with_grass"},
		min_height = v6 and 22 or 50,
		interval = 200,
		chance = (100000000 / mm)
	})

	mobs:spawn({
		name = "nssm:manticore",
		nodes = {"default:dirt_with_grass"},
		neighbors = {"default:dirt_with_grass"},
		min_height = v6 and 20 or 50,
		interval = 60,
		chance = v6 and (12000000 / mm) or (13000000 / mm)
	})

	mobs:spawn({
		name = "nssm:werewolf",
		nodes = {"default:dirt_with_grass"},
		neighbors = {"default:dirt_with_grass"},
		max_light = 10,
		min_height = v6 and 20 or 40,
		interval = 60,
		chance = v6 and (12000000 / mm) or (13000000 / mm)
	})

	-- DUCKS

	mobs:spawn({
		name = "nssm:duck",
		nodes = {"default:dirt_with_grass"},
		neighbors = {"group:flora"},
		min_light = 10,
		max_height = 40,
		interval = v6 and 20 or 50,
		chance = v6 and (350000 / mm) or (1500000 / mm)
	})

	mobs:spawn({
		name = "nssm:duckking",
		nodes = {"default:dirt_with_grass"},
		neighbors = {"group:flora"},
		min_light = 10,
		max_height = v6 and 20 or 40,
		interval = v6 and 300 or 400,
		chance = v6 and (5000000 / mm) or (120000000 / mm)
	})

	mobs:spawn({
		name = "nssm:enderduck",
		nodes = {"default:dirt_with_grass"},
		neighbors = {"group:flora"},
		max_light = 10,
		max_height = v6 and 20 or 40,
		interval = v6 and 45 or 120,
		chance = v6 and (900000 / mm) or (5000000 / mm)
	})

	mobs:spawn({
		name = "nssm:flying_duck",
		nodes = v6 and {"default:dirt_with_grass"} or {"air"},
		neighbors = {"group:leaves"},
		min_light = 10,
		min_height = 1,
		max_height = v6 and 25 or 40,
		interval = 120,
		chance = v6 and (24000000 / mm) or (8000000 / mm)
	})

	mobs:spawn({
		name = "nssm:flying_duck",
		nodes = v6 and {"default:dirt_with_grass"} or {"air"},
		neighbors = {"group:flora"},
		min_light = 10,
		min_height = 1,
		max_height = v6 and 25 or 40,
		interval = 120,
		chance = v6 and (6000000 / mm) or (25000000 / mm)
	})

	mobs:spawn({
		name = "nssm:spiderduck",
		nodes = {"default:dirt_with_grass"},
		neighbors = {"group:flora"},
		max_light = 10,
		max_height = 20,
		interval = v6 and 45 or 120,
		chance = v6 and (850000 / mm) or (5000000 / mm)
	})

	mobs:spawn({
		name = "nssm:swimming_duck",
		nodes = {"default:water_source"},
		neighbors = {"default:water_source"},
		max_height = v6 and 20 or 40,
		interval = 60,
		chance = (45000000 / mm)
	})

	-- SPIDERS

	mobs:spawn({
		name = "nssm:black_widow",
		nodes = {
			"default:dirt_with_rainforest_litter",
			"default:jungletree", "nssm:web"
		},
		interval = v6 and 20 or 30,
		chance = v6 and (1200000 / mm) or (4400000 / mm),
		active_object_count = 2
	})

	mobs:spawn({
		name = "nssm:daddy_long_legs",
		nodes = {
			"default:dirt_with_rainforest_litter",
			"default:jungletree", "nssm:web"
		},
		interval = 10,
		chance = v6 and (1200000 / mm) or (4400000 / mm),
		active_object_count = 2
	})

	mobs:spawn({
		name = "nssm:tarantula",
		nodes = {
			"default:dirt_with_rainforest_litter",
			"default:jungletree", "nssm:web"
		},
		max_light = 14,
		interval = 120,
		chance = v6 and (5000000 / mm) or (50000000 / mm)
	})

	mobs:spawn({
		name = "nssm:ulboros",
		nodes = {
			"default:dirt_with_rainforest_litter",
			"default:jungletree", "nssm:web"
		},
		interval = v6 and 20 or 30,
		chance = v6 and (1200000 / mm) or (4400000 / mm)
	})

	-- CAVES

	mobs:spawn({
		name = "nssm:bloco",
		nodes = {"default:stone", "default:desert_stone", "default:sandstone"},
		max_height = -20,
		chance = (500000 / mm)
	})

	mobs:spawn({
		name = "nssm:lava_titan",
		nodes = {
			"default:stone", "default:desert_stone",
			"default:sandstone", "default:lava_source"
		},
		max_height = -100,
		max_light = 12,
		interval = 120,
		chance = (22000000 / mm)
	})

	mobs:spawn({
		name = "nssm:stone_eater",
		nodes = {"default:stone", "default:desert_stone", "default:sandstone"},
		max_height = -20,
		interval = 40,
		chance = (700000 / mm),
		active_object_count = 2
	})

	mobs:spawn({
		name = "nssm:signosigno",
		nodes = {"default:stone", "default:desert_stone", "default:sandstone"},
		max_height = -20,
		max_light = 10,
		interval = 20,
		chance = (400000 / mm),
		active_object_count = 2
	})

	mobs:spawn({
		name = "nssm:signosigno",
		nodes = {"bones:bones"},
		max_light = 15,
		interval = 20,
		chance = (5000 / mm),
		active_object_count = 5
	})

	-- SEA

	mobs:spawn({
		name = "nssm:crab",
		nodes = {"default:sand"},
		neighbors = {"default:water_source"},
		interval = 60,
		chance = (4000000 / mm)
	})

	mobs:spawn({
		name = "nssm:crocodile",
		nodes = {"default:sand","default:water_source"},
		neighbors = {"default:water_source"},
		interval = 100,
		chance = (35000000 / mm)
	})

	mobs:spawn({
		name = "nssm:crocodile",
		nodes = {"default:sand","default:river_water_source"},
		neighbors = {"default:river_water_source"},
		interval = 60,
		chance = (12000000 / mm)
	})

	mobs:spawn({
		name = "nssm:dolidrosaurus",
		nodes = {"default:water_source"},
		neighbors = {"default:water_source"},
		max_height = -1,
		interval = 100,
		chance = (35000000 / mm)
	})

	mobs:spawn({
		name = "nssm:kraken",
		nodes = {"default:water_source"},
		neighbors = {"default:water_source"},
		max_height = 0,
		interval = 400,
		chance = (500000000 / mm)
	})

	mobs:spawn({
		name = "nssm:octopus",
		nodes = {"default:water_source"},
		neighbors = {"default:water_source"},
		max_height = 0,
		interval = 80,
		chance = (38000000 / mm)
	})

	-- DESERT

	mobs:spawn({
		name = "nssm:sandworm",
		nodes = {"default:desert_sand", "default:desert_stone"},
		interval = 100,
		chance = (28000000 / mm)
	})

	mobs:spawn({
		name = "nssm:giant_sandworm",
		nodes = {"default:desert_sand", "default:desert_stone"},
		interval = 400,
		chance = (600000000 / mm)
	})

	mobs:spawn({
		name = "nssm:sand_bloco",
		nodes = {"default:desert_sand", "default:desert_stone"},
		interval = 90,
		chance = (20000000 / mm)
	})

	-- SKY

	mobs:spawn({
		name = "nssm:moonheron",
		nodes = {"air"},
		max_light = 10,
		min_height = 10,
		max_height = 180,
		interval = 110,
		chance = (950000000 / mm)
	})

	mobs:spawn({
		name = "nssm:night_master",
		nodes = {"air"},
		max_light = 7,
		min_height = 10,
		max_height = 180,
		interval = 400,
		chance = (4500000000 / mm)
	})

	mobs:spawn({
		name = "nssm:phoenix",
		nodes = {"air"},
		max_light = 10,
		min_height = 10,
		max_height = 180,
		interval = 400,
		chance = (10000000000 / mm)
	})

	mobs:spawn({
		name = "nssm:scrausics",
		nodes = {"air"},
		max_light = 10,
		min_height = 10,
		max_height = 180,
		interval = 110,
		chance = (950000000 / mm)
	})
end
