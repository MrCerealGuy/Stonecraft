local S = minetest.get_translator("livingcavesmobs")

mobs:register_mob("livingcavesmobs:flesheatingbacteria", {
stepheight = 0,
	type = "monster",
	passive = false,
        attack_type = "dogfight",
	attack_animals = true,
	reach = 1,
        damage = 6,
	hp_min = 5,
	hp_max = 10,
	armor = 100,
	collisionbox = {-0.1, -0.01, -0.1, 0.1, 0.1, 0.1},
	visual = "mesh",
	visual_size = {x = 0.5, y = 0.5},
	mesh = "Flesheatingbacteria.b3d",
	textures = {
		{"textureflesheatingbacteria.png"},
	},
	sounds = {
		attack = "livingcavesmobs_flesheatingbacteria",
	},
	makes_footstep_sound = false,
	walk_velocity = 0.3,
	run_velocity = 0.5,
	runaway = false,
	jump = false,
        jump_height = 0,
	stepheight = 0,
	stay_near = {"livingcaves:bacteriacave_trapstone", 3},
	drops = {
	},
	water_damage = 1,
	lava_damage = 1,
	light_damage = 1,
	fear_height = 0,
	animation = {
		speed_normal = 75,
		stand_start = 0,
		stand_end = 100,
		walk_start = 100,
		walk_end = 200,
		punch_start = 200,
		punch_end = 300,
		-- 50-70 is slide/water idle
	},
	view_range = 3,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 25, 0, 0, false, nil) then return end
	end,
})


if not mobs.custom_spawn_livingcavesmobs then
mobs:spawn({
	name = "livingcavesmobs:flesheatingbacteria",
	nodes = {"livingcaves:bacteriacave_trapnode"},
	min_light = 0,
	interval = 10,
	chance = 1, 
	active_object_count = 4,
	min_height = -400,
	max_height = -200,
})
end

mobs:register_egg("livingcavesmobs:flesheatingbacteria", S("Flesh Eating Bacteria"), "aflesheatingbacteria.png")
