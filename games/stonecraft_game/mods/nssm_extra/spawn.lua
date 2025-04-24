
local v6 = nssm.mymapgenis == 6 -- true if set to 6
local mm = nssm.multimobs

-- Spawning parameters

if mm ~= 0 then

	-- V6 MAPGEN

	if v6 then

			-- DIRT

			mobs:spawn({
				name = "nssm:berinhog",
				nodes = {"default:dirt_with_grass"},
				neighbors = {"default:dirt_with_grass"},
				interval = 60,
				chance = (12000000 / mm),
				min_light = 10,
				min_height = 20
			})

			-- ICE

			mobs:spawn({
				name == "nssm:icelizard",
				nodes = {
					"default:snowblock", "default:ice",
					"default:dirt_with_snow", "default:snow"
				},
				neighbors = {
					{"default:snowblock", "default:ice", "default:dirt_with_snow"}
				},
				chance = (6000000 / mm)
			})

			-- FOREST

			mobs:spawn({
				name = "nssm:crystal_slug",
				nodes = {"default:leaves", "default:aspen_leaves"},
				interval = 40,
				chance = (4000000 / mm),
				max_height = 140
			})

			-- PINE FOREST

			mobs:spawn({
				name = "nssm:pumpkid",
				nodes = {
					"default:dirt_with_grass", "default:dirt_with_snow",
					"default:snowblock", "default:snow"
				},
				neighbors = {"default:pine_tree"},
				chance = (3000000 / mm)
			})

	else -- ALL OTHER MAPGENS

			-- MOUNTAINS

			mobs:spawn({
				name = "nssm:berinhog",
				nodes = {"default:dirt_with_grass"},
				neighbors = {"default:dirt_with_grass"},
				interval = 60,
				chance = (13000000 / mm),
				min_light = 10,
				min_height = 20
			})

			-- ICE

			mobs:spawn({
				name = "nssm:icelizard",
				nodes = {
					"default:snowblock", "default:ice",
					"default:dirt_with_snow", "default:snow"
				},
				neighbors = {
					"default:snowblock", "default:ice", "default:dirt_with_snow"
				},
				interval = 40,
				chance = (20000000 / mm)
			})

			-- FOREST

			mobs:spawn({
				name = "nssm:crystal_slug",
				nodes = {"default:leaves", "default:aspen_leaves"},
				interval = 40,
				chance = (4000000 / mm),
				max_height = 140
			})

			-- PINE FOREST

			mobs:spawn({
				name = "nssm:pumpkid",
				nodes = {
					"default:dirt_with_grass", "default:dirt_with_snow",
					"default:snowblock"
				},
				neighbors = {"default:pine_tree"},
				chance = (3300000 / mm)
			})

			-- SAVANNA

			mobs:spawn({
				name = "nssm:kele",
				nodes = {"default:dirt_with_dry_grass"},
				neighbors = {"default:dirt_with_dry_grass"},
				interval = 80,
				chance = (30000000 / mm),
				min_height = -200
			})

			mobs:spawn({
				name = "nssm:tartacacia",
				nodes = {"default:dirt_with_dry_grass"},
				neighbors = {"default:dirt_with_dry_grass"},
				interval = 180,
				chance = (2000000000 / mm),
				min_height = -200
			})

			--COLD DESERT

			mobs:spawn({
				name = "nssm:silver_sandonisc",
				nodes = {"default:silver_sand"},
				neighbors = {"default:silver_sand"},
				interval = 80,
				chance = (300000000 / mm),
				min_height = -200
			})

			mobs:spawn({
				name = "nssm:black_scoprion",
				nodes = {"default:silver_sand"},
				neighbors = {"default:silver_sand"},
				interval = 80,
				chance = (300000000 / mm),
				min_height = -200
			})

			mobs:spawn({
				name = "nssm:silversand_dragon",
				nodes = {"default:silver_sand"},
				neighbors = {"default:silver_sand"},
				interval = 180,
				chance = (2000000000 / mm),
				min_height = -200
			})

			--RIVER

			mobs:spawn({
				name = "nssm:chog",
				nodes = {"default:river_water_source"},
				neighbors = {"default:sand", "default:river_water_source"},
				chance = (3000000 / mm),
				max_height = 300
			})

			mobs:spawn({
				name = "nssm:river_lord",
				nodes = {"default:river_water_source"},
				neighbors = {"default:sand", "default:river_water_source"},
				chance = (300000000 / mm),
				max_height = 300
			})
	end

	-- CAVES

	mobs:spawn({
		name = "nssm:albino_spider",
		nodes = {"default:stone"},
		neighbors = {"default:stone"},
		chance = (500000 / mm),
		active_object_count = 3,
		max_height = -150
	})

	mobs:spawn({
		name = "nssm:salamander",
		nodes = {"default:lava_source"},
		neighbors = {
			"default:stone", "default:lava_flowing", "default:lava_source", "air"
		},
		chance = (500000 / mm),
		active_object_count = 3,
		max_height = -200
	})

	mobs:spawn({
		name = "nssm:flust",
		nodes = {"default:stone", "default:desert_stone"},
		neighbors = {"default:stone", "default:desert_stone"},
		chance = (500000/mm),
		active_object_count = 3,
		max_height = -164
	})

	-- SEA

	mobs:spawn({
		name = "nssm:pelagia",
		nodes = {"default:water_source"},
		neighbors = {"default:water_source"},
		interval = 80,
		chance = (40000000 / mm),
		max_height = 0
	})
end

