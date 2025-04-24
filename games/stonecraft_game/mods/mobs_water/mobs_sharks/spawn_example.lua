
-- load settings

local ENABLE_LARGE = minetest.settings:get_bool("mobs_sharks.enable_large") ~= false
local ENABLE_MEDIUM = minetest.settings:get_bool("mobs_sharks.enable_medium") ~= false
local ENABLE_SMALL = minetest.settings:get_bool("mobs_sharks.enable_small") ~= false

-- Shark spawn examples

if ENABLE_SMALL then

	mobs:spawn({
		name = "mobs_sharks:shark_sm",
		nodes = {"group:water"},
		neighbors = {"group:water", "seawrecks:woodship", "seawrecks:uboot"},
		interval = 30,
		chance = 20000,
		max_height = 0
	})
end

if ENABLE_MEDIUM then

	mobs:spawn({
		name = "mobs_sharks:shark_md",
		nodes = {"group:water"},
		neighbors = {"group:water", "seawrecks:woodship", "seawrecks:uboot"},
		interval = 30,
		chance = 20000,
		max_height = 0
	})
end

if ENABLE_LARGE then

	mobs:spawn({
		name = "mobs_sharks:shark_lg",
		nodes = {"group:water"},
		neighbors = {"group:water", "seawrecks:woodship", "seawrecks:uboot"},
		interval = 30,
		chance = 20000,
		max_height = 0
	})
end
