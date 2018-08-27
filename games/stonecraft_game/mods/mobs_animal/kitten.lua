
local S = mobs.intllib


-- Kitten by Jordach / BFD

mobs:register_mob("mobs_animal:kitten", {
stepheight = 0.6,
	type = "animal",
specific_attack = {"mobs_animal:rat"},
damage = 1,
attack_type = "dogfight",
attack_animals = true, -- so it can attack rat
attack_players = false,
reach = 1,
	passive = false,
	hp_min = 5,
	hp_max = 10,
	armor = 200,
	collisionbox = {-0.3, -0.3, -0.3, 0.3, 0.1, 0.3},
	visual = "mesh",
	visual_size = {x = 0.5, y = 0.5},
	mesh = "mobs_kitten.b3d",
	textures = {
		{"mobs_kitten_striped.png"},
		{"mobs_kitten_splotchy.png"},
		{"mobs_kitten_ginger.png"},
		{"mobs_kitten_sandy.png"},
	},
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_kitten",
	},
	walk_velocity = 0.6,
	run_velocity = 2,
	runaway = true,
	jump = false,
	drops = {
		{name = "farming:string", chance = 1, min = 0, max = 1},
	},
	water_damage = 1,
	lava_damage = 5,
	fear_height = 3,
	animation = {
		speed_normal = 42,
		stand_start = 97,
		stand_end = 192,
		walk_start = 0,
		walk_end = 96,
	},
	follow = {"mobs_animal:rat", "ethereal:fish_raw", "mobs_fish:clownfish", "mobs_fish:tropical"},
	view_range = 8,
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 4, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 50, 50, 90, false, nil) then return end
	end
})


local spawn_on = "default:dirt_with_grass"

if minetest.get_modpath("ethereal") and not core.skip_mod("ethereal") then
	spawn_on = "ethereal:grove_dirt"
end

mobs:spawn({
	name = "mobs_animal:kitten",
	nodes = {spawn_on},
	neighbors = {"group:grass"},
	min_light = 14,
	interval = 60,
	chance = 10000, -- 22000
	min_height = 5,
	max_height = 200,
	day_toggle = true,
})


mobs:register_egg("mobs_animal:kitten", S("Kitten"), "mobs_kitten_inv.png", 0)


mobs:alias_mob("mobs:kitten", "mobs_animal:kitten") -- compatibility
