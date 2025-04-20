mobs:register_mob("nssm:crab", {
	type = "monster",
	hp_max = 32,
	hp_min = 19,
	collisionbox = {-0.5, 0, -0.5, 0.5, 0.55, 0.5},
	visual = "mesh",
	mesh = "crab.x",
	textures = {
		{"crab1.png"},
		{"crab2.png"}
	},
	sounds = {
		random = "crab"
	},
	visual_size = {x = 3, y = 3},
	makes_footstep_sound = true,
	view_range = 7,
	rotate = 270,
	fear_height = 4,
	walk_velocity = 1,
	run_velocity = 2,
	damage = 5,
	reach = 2,
	floats = 0,
	jump = true,
	drops = {
		{name = "nssm:life_energy", chance = 1, min = 1, max = 2},
		{name = "nssm:surimi", chance = 1, min = 1, max = 2},
		{name = "nssm:crab_chela", chance = 4, min = 1, max = 2},
		{name = "nssm:crab_carapace_fragment", chance = 4, min = 1, max = 1}
	},
	armor = 40,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 10,
	fire_damage = 10,
	light_damage = 0,
	group_attack = true,
	attack_animals = true,
	knock_back = 1,
	blood_texture = "nssm_blood_blue.png",
	stepheight = 1.1,
	attack_type = "dogfight",
	animation = {
		speed_normal = 25,
		speed_run = 35,
		stand_start = 10,
		stand_end = 80,
		walk_start = 120,
		walk_end = 140,
		run_start = 120,
		run_end = 140,
		punch_start = 90,
		punch_end = 110
	}
})
