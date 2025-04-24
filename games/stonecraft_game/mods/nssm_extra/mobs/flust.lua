mobs:register_mob("nssm:flust", {
	type = "monster",
	hp_max = 27,
	hp_min = 23,
	collisionbox = {-0.35, 0, -0.35, 0.35, 1, 0.35},
	visual = "mesh",
	mesh = "flust.x",
	textures = {{"flust.png"}},
	visual_size = {x = 6, y = 6},
	makes_footstep_sound = true,
	view_range = 16,
	fear_height = 4,
	walk_velocity = 0.8,
	run_velocity = 2.4,
--	sounds = {
--		random = "flust",
--	},
	damage = 4,
	reach = 4,
	jump = true,
	drops = {
		{name = "nssm:life_energy", chance = 1, min = 1, max = 1},
	},
	armor = 50,
	drawtype = "front",
	water_damage = 8,
	lava_damage = 8,
	light_damage = 0,
	suffocation = 4,
	group_attack = true,
	attack_animals = false,
	knock_back = 1,
	blood_texture="nssm_blood_blue.png",
	immune_to = {
		{"default:sword_iron", -6}, --Flust is immune to iron weapons
		{"default:iron_lump", -8},
		{"default:steel_block", -20},
		{"default:axe_iron", -4},
		{"default:shovel_iron", -4},
		{"default:pick_iron", -6}
	},
	stepheight = 2.1,
	attack_type = "dogfight",
	animation = {
		speed_normal = 20, speed_run = 40,
		stand_start = 10, stand_end = 60,
		walk_start = 140, walk_end = 180,
		run_start = 140, run_end = 180,
		punch_start = 100, punch_end = 130,
		die_start = 70, die_end = 90,
	}
})

