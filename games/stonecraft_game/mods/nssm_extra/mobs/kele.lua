mobs:register_mob("nssm:kele", {
	type = "monster",
	hp_max = 36,
	hp_min = 27,
	collisionbox = {-0.4, 0, -0.4, 0.4, 2, 0.4},
	visual = "mesh",
	mesh = "kele.x",
	textures = {{"kele.png"}},
	visual_size = {x = 5, y = 5},
	makes_footstep_sound = true,
	view_range = 30,
	walk_velocity = 1,
	rotate = 270,
	fear_height = 4,
	run_velocity = 5,
--	sounds = {
--		random = "kele",
--	},
	damage = 4,
	jump = true,
	drops = {
		{name = "nssm:life_energy", chance = 1, min = 3, max = 4},
	},
	armor = 60,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 15,
	light_damage = 0,
	suffocation = 4,
--	group_attack = true,
--	attack_animals = true,
	knock_back = 1,
	blood_texture = "nssm_blood.png",
	stepheight = 2.1,
	attack_type = "dogfight",
	specific_attack = {"player", "nssm:felucco"},
	animation = {
		speed_normal = 20, speed_run = 25,
		stand_start = 200, stand_end = 250,
		walk_start = 40, walk_end = 80,
		run_start = 10, run_end = 30,
		punch_start = 130, punch_end = 160,
		punch2_start = 90, punch2_end = 120,
		die_start = 170, die_end = 190,
	},

	custom_attack = function (self)

		self.kele_timer = (self.kele_timer or os.time())

		if (os.time() - self.kele_timer) > 1 then

			self.kele_timer = os.time()

			local s = self.object:get_pos()
			local p = self.attack:get_pos()

			if minetest.line_of_sight(
					{x = p.x, y = p.y +1.5, z = p.z},
					{x = s.x, y = s.y +1.5, z = s.z}) == true then

				if self.health > 10 then
					self:set_animation("punch")
				else
					self:set_animation("punch2")
					self.health = self.health + (self.damage * 2)
				end

				-- play attack sound
				if self.sounds.attack then
					minetest.sound_play(self.sounds.attack, {
						object = self.object,
						max_hear_distance = self.sounds.distance
					}, true)
				end
				-- punch player
				self.attack:punch(self.object, 1.0, {
					full_punch_interval=1.0,
					damage_groups = {fleshy = self.damage}
				}, nil)
			end
		end
	end,
})

