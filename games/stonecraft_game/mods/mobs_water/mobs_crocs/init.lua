
-- load settings

local croc_walkers = minetest.settings:get_bool("mobs_crocs.enable_walkers", true)
local croc_floaters = minetest.settings:get_bool("mobs_crocs.enable_floaters", true)
local croc_swimmers = minetest.settings:get_bool("mobs_crocs.enable_swimmers", true)
local croc_spawn_chance = 60000

-- tweak croc spawn chance depending on which one's are enabled

croc_spawn_chance = croc_spawn_chance - (croc_walkers and 0 or 20000)
croc_spawn_chance = croc_spawn_chance - (croc_floaters and 0 or 20000)
croc_spawn_chance = croc_spawn_chance - (croc_swimmers and 0 or 20000)

-- Mineclone check

local mod_mcl = minetest.get_modpath("mcl_core")

-- crocodile definition

local croc_def = {
	type = "monster",
	attack_type = "dogfight",
	damage = 8,
	reach = 3,
	hp_min = 20,
	hp_max = 25,
	armor = 100,
	collisionbox = {-0.85, -0.30, -0.85, 0.85, 1.5, 0.85},
	drawtype = "front",
	visual = "mesh",
	mesh = "crocodile.x",
	textures = {
		{"croco.png"},
		{"croco2.png"}
	},
	visual_size = {x = 4, y = 4},
	sounds = {
		random = "croco"
	},
	fly = false,
	floats = 0,
	stepheight = 1,
	view_range = 10,
	water_damage = 0,
	lava_damage = 10,
	light_damage = 0,
	animation = {
		speed_normal = 24, speed_run = 24,
		stand_start = 0, stand_end = 80,
		walk_start = 81, walk_end = 170,
		fly_start = 81, fly_end = 170,
		run_start = 81, run_end = 170,
		punch_start = 205, punch_end = 220
	},
	drops = {
		{name = (mod_mcl and "mcl_mobitems:beef" or "mobs:meat_raw"),
				chance = 1, min = 1, max = 3},
		{name = (mod_mcl and "mcl_mobitems:leather" or "mobs:leather"),
				chance = 1, min = 0, max = 2}
	}
}


if croc_walkers then

	mobs:register_mob("mobs_crocs:crocodile", table.copy(croc_def))

	mobs:register_egg("mobs_crocs:crocodile", "Crocodile (walk)", "default_grass.png", 1)
end


if croc_floaters then

	croc_def.reach = 2
	croc_def.collisionbox = {-0.638, -0.23, -0.638, 0.638, 1.13, 0.638}
	croc_def.visual_size = {x = 3, y = 3}
	croc_def.floats = 1

	mobs:register_mob("mobs_crocs:crocodile_float", table.copy(croc_def))

	mobs:register_egg("mobs_crocs:crocodile_float", "Crocodile (float)", "default_grass.png", 1)
end


if croc_swimmers then

	croc_def.reach = 1
	croc_def.collisionbox = {-0.425, -0.15, -0.425, 0.425, 0.75, 0.425}
	croc_def.visual_size = {x = 2, y = 2}
	croc_def.fly = true
	croc_def.fly_in = (mod_mcl and "mcl_core:water_source" or "default:water_source")
	croc_def.fall_speed = -1
	croc_def.floats = 0

	mobs:register_mob("mobs_crocs:crocodile_swim", table.copy(croc_def))

	mobs:register_egg("mobs_crocs:crocodile_swim", "Crocodile (swim)", "default_grass.png", 1)
end

-- Check for custom spawn.lua

local MP = minetest.get_modpath(minetest.get_current_modname()) .. "/"
local input = io.open(MP .. "spawn.lua", "r")

if input then
	input:close() ; input = nil ; dofile(MP .. "spawn.lua")
else
	if croc_walkers then

		mobs:spawn({
			name = "mobs_crocs:crocodile",
			nodes = {
				(mod_mcl and "group:shovely" or "group:crumbly")
			},
			neighbors = {
				"group:water", "dryplants:juncus", "dryplants:reedmace",
				(mod_mcl and "mcl_core:reeds" or "default:papyrus")
			},
			interval = 30,
			chance = croc_spawn_chance,
			min_height = 0,
			max_height = 10
		})
	end

	if croc_floaters then

		mobs:spawn({
			name = "mobs_crocs:crocodile_float",
			nodes = {"group:water"},
			neighbors = {
				(mcl_core and "group:shovely" or "group:crumbly"),
				"group:seaplants", "dryplants:juncus", "dryplants:reedmace",
				(mod_mcl and "mcl_core:reeds" or "default:papyrus")
			},
			interval = 30,
			chance = croc_spawn_chance,
			min_height = -3,
			max_height = 10
		})
	end

	if croc_swimmers then

		mobs:spawn({
			name = "mobs_crocs:crocodile_swim",
			nodes = {"group:water"},
			neighbors = {(mcl_core and "group:shovely" or "group:crumbly")},
			interval = 30,
			chance = croc_spawn_chance,
			min_height = -8,
			max_height = 10
		})
	end
end

print("[MOD] Mobs Redo Crocs loaded")
