
-- load settings

local croc_walkers = minetest.settings:get_bool("mobs_crocs.enable_walkers", true)
local croc_floaters = minetest.settings:get_bool("mobs_crocs.enable_floaters", true)
local croc_swimmers = minetest.settings:get_bool("mobs_crocs.enable_swimmers", true)

-- spawn examples

if croc_walkers then

	mobs:spawn({
		name = "mobs_crocs:crocodile",
		nodes = {"group:crumbly"},
		neighbors = {
			"group:water", "dryplants:juncus", "dryplants:reedmace", "default:papyrus"
		},
		interval = 30,
		chance = 20000,
		min_height = 0,
		max_height = 10
	})
end

if croc_floaters then

	mobs:spawn({
		name = "mobs_crocs:crocodile_float",
		nodes = {"group:water"},
		neighbors = {
			"group:crumbly", "group:seaplants", "dryplants:juncus",
			"dryplants:reedmace", "default:papyrus"
		},
		interval = 30,
		chance = 20000,
		min_height = -3,
		max_height = 10
	})
end

if croc_swimmers then

	mobs:spawn({
		name = "mobs_crocs:crocodile_swim",
		nodes = {"group:water"},
		neighbors = {"group:crumbly"},
		interval = 30,
		chance = 20000,
		min_height = -8,
		max_height = 10
	})
end
