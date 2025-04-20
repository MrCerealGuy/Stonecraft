mobs:register_mob("nssm:sandworm", {
	type = "monster",
	hp_max = 40,
	hp_min = 25,
	collisionbox = {-0.4, -0.2, -0.4, 0.4, 1.90, 0.4},
	visual = "mesh",
	mesh = "sandworm.x",
	textures = {
		{"sandworm.png"}
	},
	visual_size = {x = 4, y = 4},
	makes_footstep_sound = false,
	view_range = 17,
	rotate = 270,
	reach = 2,
	fear_height = 3,
	walk_velocity = 2,
	run_velocity = 2,
	damage = 6,
	sounds = {
		random = "sandworm",
		distance = 40
	},
	jump = false,
	drops = {
		{name = "nssm:worm_flesh", chance = 2, min = 1, max = 3},
		{name = "nssm:sandworm_skin", chance = 2, min = 1, max = 3},
		{name = "nssm:life_energy", chance = 1, min = 2, max = 3}
	},
	armor = 60,
	drawtype = "front",
	water_damage = 5,
	lava_damage = 10,
	fire_damage = 10,
	light_damage = 0,
	group_attack = true,
	attack_animals = true,
	knock_back = 2,
	blood_texture = "nssm_blood_blue.png",
	stepheight = 1.1,
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
	},

	do_custom = function(self)
		nssm:digging_attack(self, "sand", self.run_velocity, {x = 0, y = 3, z = 0})
	end
})
