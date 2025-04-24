mobs:register_mob("nssm:silver_sandonisc", {
	type = "monster",
	hp_max = 23,
	hp_min = 21,
	collisionbox = {-0.4, -0.2, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	mesh = "silver_sandonisc.x",
	textures = {{"silver_sandonisc.png"}},
	visual_size = {x = 8, y = 8},
	makes_footstep_sound = false,
	view_range = 24,
	rotate = 270,
	reach = 5,
	fear_height = 3,
	walk_velocity = 0.6,
	run_velocity = 5,
	damage = 5,
--	sounds = {
--		random = "silver_sandonisc",
--		distance = 40,
--	},
	jump = false,
	drops = {
		{name = "nssm:life_energy", chance = 1, min = 2, max = 3},
	},
	armor = 30,
	drawtype = "front",
	water_damage = 5,
	lava_damage = 15,
	light_damage = 0,
	group_attack = true,
	attack_animals = false,
	knock_back = 1,
	blood_texture = "nssm_blood_blue.png",
	stepheight = 1.1,
	attack_type = "dogfight",
	animation = {
		speed_normal = 20, speed_run = 30,
		stand_start = 170, stand_end = 230,
		walk_start = 80, walk_end = 120,
		run_start = 40, run_end = 70,
		punch_start = 130, punch_end = 160,
		punch2_start = 40, punch2_end = 70, speed_punch2 = 40,
		die_start = 235, die_end = 255,
	},

	do_custom = function (self)

		if self.other_state and self.other_state == "charge" then
			nssm:do_charge(self)
		end
	end,

	custom_attack = function (self)
		nssm:charge_attack(self)
	end,
})

