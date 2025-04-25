local S = minetest.get_translator("livingcavesmobs")

mobs:register_mob("livingcavesmobs:chubby", {
	stepheight = 3,
	type = "animal",
	passive = false,
	attack_type = "dogfight",
	group_attack = true,
	owner_loyal = true,
	attack_npcs = true,
	reach = 2,
	damage = 1,
	hp_min = 5,
	hp_max = 35,
	armor = 100,
	collisionbox = {-0.3, -0.01, -0.3, 0.3, 0.3, 0.3},
	visual = "mesh",
	mesh = "Chubby.b3d",
	textures = {
		{"texturechubby.png"},
	},
	makes_footstep_sound = true,
	sounds = {
		death = "livingcavesmobs_chubby",
		attack = "livingcavesmobs_chubby2",
	},
	walk_velocity = 1.5,
	run_velocity = 2,
	jump = true,
	jump_height = 4,
	pushable = true,
	stay_near = {"livingcaves:bacteriacave_poolstone", 4},
	follow = {"fishing:bait:worm", "ethereal:worm", "animalworld:ant", "animalworld:termite", "animalworld:cockroach"},
	view_range = 10,
	drops = {
	},
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 4,
	animation = {
		speed_normal = 160,
		stand_speed = 80,
		stand_start = 0,
		stand_end = 100,
		stand1_start = 100,
		stand1_end = 200,
		walk_start = 200,
		walk_end = 300,
		punch_speed = 70,
		punch_start = 300,
		punch_end = 400,
		die_start = 300,
		die_end = 400,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
	fly_in = {"default:water_source", "default:river_water_source", "default:water_flowing", "default:river_water_flowing", "livingcaves:water_source", "livingcaves:water_flowing",},
	floats = 0,
	follow = {
		"ethereal:worm", "seaweed", "fishing:bait_worm", "animalworld:ant", "animalworld:termite", "animalworld:fishfood"
	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 15, 25, 0, false, nil) then return end
	end,
})

if not mobs.custom_spawn_livingcavesmobs then
mobs:spawn({
	name = "livingcavesmobs:chubby",
	nodes = {"livingcaves:water_source", "livingcaves:water_flowing"},
	neighbors = {"livingcaves:bacteriacave_poolstone"},
	min_light = 0,
	interval = 60,
	chance = 80,
	active_object_count = 1,
	min_height = -400,
	max_height = -200,
})
end

mobs:register_egg("livingcavesmobs:chubby", ("Chubby"), "achubby.png")


mobs:alias_mob("livingcavesmobs:chubby", "livingcavesmobs:chubby") -- compatibility


