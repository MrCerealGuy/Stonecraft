local S = minetest.get_translator("animalworld")

mobs:register_mob("animalworld:mosquito", {
	type = "monster",
	passive = false,
        attack_type = "dogfight",
	reach = 1,
        damage = 1,
	hp_min = 1,
	hp_max = 5,
	armor = 100,
	collisionbox = {-0.1, -0.01, -0.1, 0.1, 0.1, 0.1},
	visual = "mesh",
	mesh = "Mosquito.b3d",
	visual_size = {x = 1, y = 1},
	textures = {
		{"texturemosquito.png"},
	},
	sounds = {
		random = "animalworld_mosquito",
		attack = "animalworld_mosquito",
		damage = "animalworld_mosquito",
		death = "animalworld_mosquito",
	},
	makes_footstep_sound = false,
	stay_near = {"naturalbiomes:alderswamp_reed", 5},
	view_range = 15,
	walk_velocity = 2,
        walk_chance = 50,
	run_velocity = 3,
        fly = true,
        fly_in = {"air"},
	floats = 0,
	runaway = false,
	jump = true,
        jump_height = 6,
	stepheight = 3,
	drops = {
	},
	water_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 0,
	animation = {
		speed_normal = 400,
		stand_start = 0,
		stand_end = 100,
		walk_start = 0,
		walk_end = 100,
		punch_start = 100,
		punch_end = 200,
		die_start = 100,
		die_end = 200,
		die_speed = 50,
		die_loop = false,
		die_rotate = true,
	},
})


if not mobs.custom_spawn_animalworld then
mobs:spawn({
	name = "animalworld:mosquito",
	nodes = {"naturalbiomes:alderswamp_reed", "mcl_core:dirt_with_grass", "naturalbiomes:alderswamp_reed2", "naturalbiomes:alderswamp_reed3", "naturalbiomes:swampgrass", "livingjungle:jungleground", "livingjungle:leafyjungleground"},
	neighbors = {"air"},
	min_light = 0,
	interval = 30,
	chance = 200, -- 15000
	active_object_count = 2,
	min_height = 0,
	max_height = 50,
        day_toggle = false
})
end

mobs:register_egg("animalworld:mosquito", S("Mosquito"), "amosquito.png")

mobs:alias_mob("animalworld:mosquito", "animalworld:mosquito")


