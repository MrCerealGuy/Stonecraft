
-- mineclone check

local mod_mcl = minetest.get_modpath("mcl_core")

-- jellyfish definition

mobs:register_mob("mobs_jellyfish:jellyfish", {
	type = "monster",
	attack_type = "dogfight",
	passive = false,
	damage = 5,
	reach = 1.1,
	hp_min = 5,
	hp_max = 10,
	armor = 100,
	collisionbox = {-0.1, -0.25, -0.1, 0.1, 0.25, 0.1},
	visual = "mesh",
	mesh = "jellyfish.b3d",
	textures = {
		{"jellyfish.png"}
	},
	makes_footstep_sound = false,
	walk_velocity = 0.1,
	run_velocity = 0.1,
	fly = true,
	fly_in = (mod_mcl and "mcl_core:water_source" or "default:water_source"),
	stepheight = 0,
	fall_speed = 0,
	view_range = 10,
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,

	on_rightclick = function(self, clicker)
		mobs:capture_mob(self, clicker, 80, 100, 0, true, "mobs_jellyfish:jellyfish")
	end
})

-- Check for custom spawn.lua

local MP = minetest.get_modpath(minetest.get_current_modname()) .. "/"
local input = io.open(MP .. "spawn.lua", "r")

if input then
	input:close() ; input = nil ; dofile(MP .. "spawn.lua")
else
	mobs:spawn({
		name = "mobs_jellyfish:jellyfish",
		nodes = {(mod_mcl and "mcl_core:water_source" or "default:water_source")},
		neighbors = {"group:water"},
		min_light = 5,
		interval = 30,
		chance = 10000,
		max_height = 0
	})
end

-- spawn egg

mobs:register_egg("mobs_jellyfish:jellyfish", "Jellyfish", "jellyfish_inv.png", 0)

-- compatibility

minetest.register_alias("mobs_jellyfish:jellyfish_set", "mobs_jellyfish:jellyfish")


print("[MOD] Mobs Redo Jellyfish loaded")
