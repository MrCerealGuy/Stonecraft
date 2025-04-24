mobs:register_mob("nssm:tartacacia", {
	type = "monster",
	hp_max = 360,
	hp_min = 360,
	collisionbox = {-2, 0, -2, 2, 3, 2},
	visual = "mesh",
	mesh = "tartacacia.x",
	textures = {{"tartacacia.png"}},
	visual_size = {x = 10, y = 10},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 0.6,
	rotate = 270,
	reach=10,
	fear_height = 4,
	run_velocity = 1.2,
--	sounds = {
--		random = "tartacacia",
--	},
	damage = 1,
	jump = true,
	drops = {
		{name = "nssm:life_energy", chance = 1, min = 33, max = 43},
		{name = "nssm:earth_sword", chance = 1, min = 1, max = 1},
	},
	armor = 50,
	drawtype = "front",
	water_damage = 2,
	lava_damage = 5,
	light_damage = 0,
--	group_attack = true,
--	attack_animals = true,
	knock_back = 0,
	blood_texture = "nssm_blood.png",
	stepheight = 2.1,
	attack_type = "dogfight",
	animation = {
		speed_normal = 20, speed_run = 40,
		stand_start = 10, stand_end = 60,
		walk_start = 70, walk_end = 150,
		run_start = 70, run_end = 150,
		punch_start = 190, punch_end = 220,
		punch2_start = 230, punch2_end = 250,
		die_start = 160, die_end = 180, speed_die = 10,
	},

	custom_attack = function (self)

		local s = self.object:get_pos()
		local p = self.attack:get_pos()
		local d = vector.subtract (p,s)
		local l = vector.length(d)

		if math.random(5) == 1 then

			if l <= 6 then

				self:set_animation("punch")

				for y = 0,3 do
					p.y = p.y - y
					minetest.remove_node(p)
				end

				self.attack:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups = {fleshy = self.damage}
				}, nil)
			end
		else
			self:set_animation("punch2")

			self.attack:punch(self.object, 1.0, {
				full_punch_interval = 1.0,
				damage_groups = {fleshy = self.damage}
			}, nil)

			if l < 4 then
				self.attack:set_pos(vector.subtract(p, {x = 0, y = 2, z = 0}))
			end
		end
	end,
})

