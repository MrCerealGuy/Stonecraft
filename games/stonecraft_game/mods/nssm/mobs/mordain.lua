mobs:register_mob("nssm:mordain", {
	type = "monster",
	hp_max = 32,
	hp_min = 23,
	collisionbox = {-0.5, -0.3, -0.5, 0.5, 2.7, 0.5},
	visual = "mesh",
	mesh = "mordain.x",
	textures = {{"mordain.png"}},
	visual_size = {x=3.5, y=3.5},
	makes_footstep_sound = false,
	view_range = 30,
	fear_height = 4,
	walk_velocity = 1,
	run_velocity = 3.5,
    rotate = 270,
    sounds = {
		random = "mordain",
	},
	damage = 6,
	jump = true,
	drops = {
		{name = "nssm:life_energy",
		chance = 1,
		min = 1,
		max = 1,},
		{name = "nssm:slothful_soul_fragment",
		chance = 3,
		min = 1,
		max = 1,},
	},
	armor = 80,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 1,
	group_attack=true,
	attack_animals=true,
	knock_back=1,
	blood_texture="morparticle.png",
	stepheight=1.1,
	--light_damage = 2,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 20,
		stand_start = 10,
		stand_end = 90,
		walk_start = 100,
		walk_end = 140,
		run_start = 170,
		run_end = 200,
		punch_start = 210,
		punch_end = 225,
	},
	--pathfinding = 1,
	custom_attack = function(self)
		self.mordain_timer = (self.mordain_timer or os.time())
		if (os.time() - self.mordain_timer) > 1 then
			self.mordain_timer = os.time()
			local s = self.object:getpos()
			local p = self.attack:getpos()

			set_animation(self, "punch")

			if minetest.line_of_sight({x = p.x, y = p.y +1.5, z = p.z}, {x = s.x, y = s.y +1.5, z = s.z}) == true then
				-- play attack sound
				if self.sounds.attack then
					minetest.sound_play(self.sounds.attack, {
						object = self.object,
						max_hear_distance = self.sounds.distance
					})
				end
				-- punch player
				self.attack:punch(self.object, 1.0,  {
					full_punch_interval=1.0,
					damage_groups = {fleshy=self.damage}
				}, nil)
			end

			minetest.after(1, function()
				local ty = s.y
				local flag = 0
				local m = 3

				local v = {x=(p.x-s.x)*m, y = ty, z = (p.z-s.z)*m}
				local d = {x=s.x+v.x, y = ty, z = s.z+v.z}

				d.y = ty

				for j = -3,3 do
					ty = d.y + j
					local current = minetest.env:get_node({x = d.x, y = ty, z = d.z}).name
					local up = minetest.env:get_node({x = d.x, y = ty+1, z = d.z}).name
					if up == "air" and current ~= "air" then
						d.y = d.y + j+1.5
						flag = 1
						break
					end
				end

				while flag ~= 1 do
					d.x = p.x + math.random(-m,m)
					d.z = p.z + math.random(-m,m)
					d.y = p.y
					local dist = dist_pos(d, p)
					if dist>=2 then
						for j = -3,3 do
							ty = d.y + j
							local current = minetest.env:get_node({x = d.x, y = ty, z = d.z}).name
							local up = minetest.env:get_node({x = d.x, y = ty+1, z = d.z}).name
							if up == "air" and current ~= "air" then
								d.y = d.y + j+1.5
								flag = 1
								break
							end
						end
					end
				end
				self.object:setpos(d)
			end)
		end
	end
})
