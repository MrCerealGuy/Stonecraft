mobs:register_mob("nssm:icelizard", {
	type = "monster",
	hp_max = 15,
	hp_min = 13,
	collisionbox = {-0.5, 0, -0.5, 0.5, 0.60, 0.5},
	visual = "mesh",
	mesh = "icelizard.x",
	textures = {{"snow_biter.png"}},
	visual_size = {x = 9, y = 9},
	makes_footstep_sound = true,
	view_range = 30,
	rotate = 270,
	mele_number = 2,
	fear_height = 4,
	reach = 1.5,
	walk_velocity = 0.8,
	run_velocity = 3.5,
	sounds = {
		random = "snow_biter",
	},
--	pathfinding = true,
	damage = 4,
	jump = true,
	drops = {
		{name = "nssm:life_energy", chance = 1, min = 2, max = 3},
		{name = "nssm:frosted_amphibian_heart", chance = 2, min = 1, max = 1},
		{name = "nssm:amphibian_ribs", chance = 2, min = 1, max = 1},
		{name = "nssm:little_ice_tooth", chance = 2, min = 0, max = 4},
	},
	armor = 80,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 30,
	light_damage = 0,
	suffocation = 4,
	group_attack = true,
	attack_animals = false,
	knock_back = 2,
	blood_texture = "nssm_blood.png",
	stepheight = 1.1,
	attack_type = "dogfight",
	animation = {
		speed_normal = 20, speed_run = 40, speed_punch = 5,
		stand_start = 0, stand_end = 80,
		walk_start = 110, walk_end = 150,
		run_start = 110, run_end = 150,
		die_start = 80, die_end = 100,
		punch_start = 160, punch_end = 170,
	},

	custom_attack = function(self)

		self.icelizard_timer = self.icelizard_timer or os.time()

		self:set_animation("punch")

		if (os.time() - self.icelizard_timer) > 0.9 then

			local pos = self.object:get_pos()

			mobs:boom(self, pos, 1, 2, "coldest_ice.png")

			self.object:remove()
		end
	end,

	do_custom = function(self)
		nssm:putting_ability(self, "default:ice", self.run_velocity)
	end,
})

