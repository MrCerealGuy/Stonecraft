local S = minetest.get_translator("livingcavesmobs")

mobs:register_mob("livingcavesmobs:biter", {
stepheight = 3,
	type = "monster",
	passive = false,
        attack_type = "dogfight",
	attack_animals = true,
	reach = 2,
        damage = 4,
	hp_min = 35,
	hp_max = 55,
	armor = 100,
	collisionbox = {-0.3, -0.01, -0.3, 0.3, 0.95, 0.3},
	visual = "mesh",
	mesh = "Biter.b3d",
	visual_size = {x = 1.0, y = 1.0},
	textures = {
		{"texturebiter.png"},
		{"texturebiter2.png"},
		{"texturebiter3.png"},
	},
	sounds = {
		random = "livingcavesmobs_biter2",
		attack = "livingcavesmobs_biter2",
		death = "livingcavesmobs_biter3",
		damage = "livingcavesmobs_biter",
	},
	makes_footstep_sound = true,
	walk_velocity = 2,
	run_velocity = 3,
	runaway = false,
	jump = true,
        jump_height = 6,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
		{name = "mobs:leather", chance = 1, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 1,
	fear_height = 4,
        stay_near = {{"livingcaves:water_flowing", "livingcaves:water_source"}, 4},
	animation = {
		speed_normal = 75,
		stand_start = 0,
		stand_end = 100,
		stand2_start = 100,
		stand2_end = 200,
		walk_speed = 100,
		walk_start = 200,
		walk_end = 300,
		punch_start = 300,
		punch_end = 400,
		die_start = 300,
		die_end = 400,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	follow = {
		"ethereal:fish_raw", "anjimalworld:rawfish", "mobs_fish:tropical",
		"mobs:meat_raw", "animalworld:rabbit_raw", "xocean:fish_edible", "fishing:fish_raw", "water_life:meat_raw", "fishing:carp_raw", "animalworld:chicken_raw"
	},
	view_range = 12,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, false, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 25, 0, false, nil) then return end
	end,
})

if not mobs.custom_spawn_livingcavesmobs then
mobs:spawn({
	name = "livingcavesmobs:biter",
	nodes = {"livingcaves:dripstonecave_bottom"},
	min_light = 0,
	interval = 60,
	chance = 80,
	active_object_count = 3,
	min_height = -200,
	max_height = -90,
})
end

mobs:register_egg("livingcavesmobs:biter", S("Biter"), "abiter.png")
