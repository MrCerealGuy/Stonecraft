nssm:register_mob("nssm:ant_queen", {
	type = "monster",
	hp_max = 120,
	hp_min = 120,
	collisionbox = {-1, 0.00, -1, 1, 1, 1},
	visual = "mesh",
	mesh = "ant_queen.x",
	textures = {{"ant_queen.png"}},
	visual_size = {x=6, y=6},
	makes_footstep_sound = true,
	view_range = 30,
	fear_height = 5,
	walk_velocity = 1.5,
	run_velocity = 2,
	lifetimer = 300,
  	rotate = 270,
    sounds = {
		random = "ant",
		attack = "ant",
	},
	damage = 4,
	jump = true,
	drops = {
		{name = "nssm:life_energy",
		chance = 1,
		min = 5,
		max = 7,},
		{name = "nssm:ant_queen_abdomen",
		chance = 1,
		min = 1,
		max = 1,},
		{name = "nssm:ant_leg",
		chance = 2,
		min = 1,
		max = 6,},
		{name = "nssm:ant_mandible",
		chance = 3,
		min = 1,
		max = 2,},
	},
	reach = 8,
	armor = 70,
	drawtype = "front",
	water_damage = 2,
	lava_damage = 7,
	light_damage = 0,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 20,
		speed_run = 25,
		stand_start = 1,
		stand_end = 50,
		walk_start = 120,
		walk_end = 160,
		run_start = 120,
		run_end = 160,
		punch_start = 170,
		punch_end = 190,
	},

	custom_attack = function(self)
		if self.timer >4 then
			self.timer = 0

			local s = self.object:getpos()
			local p = self.attack:getpos()

			p.y = p.y + 1.5
			s.y = s.y + 1.5
			if line_of_sight_water(self, p, s) == true then
				-- play attack sound
				if self.sounds.attack then
					minetest.sound_play(self.sounds.attack, {
					object = self.object,
					max_hear_distance = self.sounds.distance
					})
				end
				local pos1 = {x=s.x+math.random(-3,3), y=s.y-1, z=s.z+math.random(-3,3)}

				if pos1.x~=s.x and pos1.z~=s.z then
					nssm:explosion_particles(pos1, 1)
					minetest.add_entity(pos1, "nssm:ant_soldier")
				end
			end
		end
	end

})
