mobs:register_mob("nssm:ant_queen", {
	type = "monster",
	hp_max = 220,
	hp_min = 220,
	collisionbox = {-0.6, 0.00, -0.6, 0.6, 1, 0.6},
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
	armor = 40,
	drawtype = "front",
	water_damage = 2,
	lava_damage = 7,
	light_damage = 0,
	blood_texture="nssm_blood_blue.png",
	blood_amount=50,
	stepheight=2.1,
	knock_back=0,
	jump_height=12,
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
		self.ant_queen_counter = (self.ant_queen_counter or 0) + 1
		if self.ant_queen_counter == 4 then
			self.ant_queen_counter = 0
			local counter = 0

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

				local objects = minetest.env:get_objects_inside_radius(s, 10)
			    for _,obj in ipairs(objects) do
			        if (obj:get_luaentity() and obj:get_luaentity().name == "nssm:ant_soldier") then
			        	counter = counter + 1
					end
			    end

				if 	((pos1.x~=s.x) and (pos1.z~=s.z))
				and (minetest.env:get_node(pos1).name == "air")
				and (counter < 4)
				then
					explosion_particles(pos1, 1)
					minetest.add_entity(pos1, "nssm:ant_soldier")
				end
			end
		end
	end
})
