mobs:register_mob("nssm:giant_sandworm", {
	type = "monster",
	hp_max = 330,
	hp_min = 330,
	collisionbox = {-1.2, 0, -1.2, 1.2, 4.5, 1.2},
	visual = "mesh",
	mesh = "giant_sandworm.x",
	textures = {
		{"sandworm.png"}
	},
	visual_size = {x = 13, y = 13},
	makes_footstep_sound = false,
	view_range = 9,
	rotate = 270,
	reach = 8,
	walk_velocity = 0,
	run_velocity = 0,
	damage = 12,
	jump = false,
	drops = {
		{name = "nssm:worm_flesh", chance = 1, min = 20, max = 30},
		{name = "nssm:sandworm_skin", chance = 2, min = 3, max = 12},
		{name = "nssm:life_energy", chance = 1, min = 7, max = 8},
		{name = "nssm:digested_sand", chance = 1, min = 1, max = 1}
	},
	armor = 40,
	drawtype = "front",
	water_damage = 5,
	lava_damage = 3,
	light_damage = 0,
	fire_damage = 0,
	blood_texture = "nssm_blood_blue.png",
	blood_amount = 50,
	knock_back = 0,
	jump_height = 0,
	attack_type = "dogfight",
	animation = {
		speed_normal = 25,
		speed_run = 40,
		stand_start = 1,
		stand_end = 100,
		walk_start = 110,
		walk_end = 140,
		run_start = 110,
		run_end = 140,
		punch_start = 150,
		punch_end = 180
	}
})
