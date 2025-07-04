mobs:register_mob("nssm:black_widow", {
	type = "monster",
	hp_max = 26,
	hp_min = 19,
	collisionbox = {-0.4, 0.00, -0.4, 0.4, 0.8, 0.4},
	visual = "mesh",
	mesh = "black_widow.x",
	textures = {{"black_widow.png"}},
	visual_size = {x = 2, y = 2},
	makes_footstep_sound = true,
	view_range = 15,
	fear_height = 4,
	walk_velocity = 0.8,
	run_velocity = 2.5,
	rotate = 270,
	sounds = {
		random = "black_widow"
	},
	damage = 4,
	reach = 2,
	jump = true,
	drops = {
		{name = "nssm:life_energy", chance = 1, min = 1, max = 2},
		{name = "nssm:spider_leg", chance = 3, min = 1, max = 8},
		{name = "nssm:silk_gland", chance = 4, min = 1, max = 3},
		{name = "nssm:spider_meat", chance = 4, min = 1, max = 2}
	},
	armor = 70,
	drawtype = "front",
	water_damage = 1,
	lava_damage = 7,
	fire_damage = 7,
	group_attack = true,
	attack_animals = true,
	knock_back = 2,
	blood_texture = "nssm_blood_blue.png",
	stepheight = 1.1,
	light_damage = 0,
	attack_type = "dogfight",
	animation = {
		speed_normal = 20,
		speed_run = 25,
		stand_start = 1,
		stand_end = 70,
		walk_start = 80,
		walk_end = 120,
		run_start = 120,
		run_end = 140,
		punch_start = 150,
		punch_end = 160
	},

	do_custom = function(self, dtime)

		self.web_timer = (self.web_timer or 0) + dtime
		if self.web_timer < 5 then return end
		self.web_timer = 0

		if nssm.spiders_litter_web then
			nssm:webber_ability(self, "nssm:web", 2)
		end
	end
})
