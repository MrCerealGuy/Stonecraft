mobs:register_mob("nssm:morvy", {
	type = "monster",
	hp_max = 39,
	hp_min = 21,
	collisionbox = {-0.3, -0.1, -0.3, 0.3, 2.3, 0.3},
	visual = "mesh",
	mesh = "morvy.x",
	textures = {
		{"morvy.png"}
	},
	visual_size = {x = 6, y = 6},
	makes_footstep_sound = true,
	view_range = 35,
	fear_height = 5,
	walk_velocity = 0.7,
	run_velocity = 2,
	rotate = 270,
	damage = 4,
	sounds = {
		random = "morvy"
	},
	jump = true,
	drops = {
		{name = "nssm:life_energy", chance = 1, min = 5, max = 7},
		{name = "nssm:envious_soul_fragment", chance = 3, min = 1, max = 1}
	},
	reach = 8,
	armor = 60,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 0,
	light_damage = 0,
	fire_damage = 0,
	group_attack = true,
	attack_animals = true,
	knock_back = 1,
	blood_texture = "morparticle.png",
	stepheight = 1.1,
	attack_type = "dogfight",
	animation = {
		speed_normal = 20,
		speed_run = 25,
		stand_start = 10,
		stand_end = 40,
		walk_start = 50,
		walk_end = 90,
		run_start = 50,
		run_end = 90,
		punch_start = 100,
		punch_end = 130
	},

	custom_attack = function(self)

		self:set_animation("stand")

		self.morvy_counter = (self.morvy_counter or 0) + 1

		if self.morvy_counter == 4 then

			self:set_animation("punch")

			self.morvy_counter = 0

			local counter = 0
			local s = self.object:get_pos()
			local p = self.attack:get_pos()

			p.y = p.y + 1.5
			s.y = s.y + 1.5

			if mobs:line_of_sight(self, p, s) == true then
				--[[play attack sound
				if self.sounds.attack then
					minetest.sound_play(self.sounds.attack, {
					object = self.object,
					max_hear_distance = self.sounds.distance
					})
				end]]

				local pos1 = {
					x = s.x + math.random(-0.5, 0.5),
					y = s.y + 0.2,
					z = s.z + math.random(-0.5, 0.5)
				}

				local objects = minetest.get_objects_inside_radius(s, 10)

				for _,obj in ipairs(objects) do

					if (obj:get_luaentity()
					and ((obj:get_luaentity().name == "nssm:morbat1")
					or (obj:get_luaentity().name == "nssm:morbat2")
					or (obj:get_luaentity().name == "nssm:morbat3"))) then
						counter = counter + 1
					end
				end

				if minetest.get_node(pos1).name == "air"
				and counter < 5 then

					local bat
					local which = math.random(1, 3)

					if which == 1 then
						bat = "nssm:morbat1"
					elseif which == 2 then
						bat = "nssm:morbat2"
					elseif which == 3 then
						bat = "nssm:morbat3"
					end

					if (bat=="nssm:morbat3") then
						pos1.y = pos1.y + 1.5
					end

					minetest.add_entity(pos1, bat)

					minetest.add_particlespawner({
						amount = 20,
						time = 0.1,
						minpos = {x = pos1.x - 0.2, y = pos1.y - 0.2, z = pos1.z - 0.2},
						maxpos = {x = pos1.x + 0.2, y = pos1.y + 0.2, z = pos1.z + 0.2},
						minvel = {x = 0, y = 0, z = 0},
						maxvel = {x = 0.1, y = 0.3, z = 0.1},
						minacc = {x = -0.5, y = 1, z = -0.5},
						maxacc = {x = 0.5, y = 1, z = 0.5},
						minexptime = 0.1,
						maxexptime = 4,
						minsize = 2,
						maxsize = 6,
						collisiondetection = false,
						texture = "morparticle.png"
					})
				end
			end
		end
	end
})

--Morbats

mobs:register_mob("nssm:morbat1", {
	type = "monster",
	hp_max = 15,
	hp_min = 13,
	collisionbox = {-0.1, 0.2, -0.1, 0.1, 0.4, 0.1},
	visual = "mesh",
	mesh = "morbat.x",
	textures = {
		{"morbat1.png"}
	},
	visual_size = {x = 2, y = 2},
	view_range = 40,
	walk_velocity = 0.5,
	run_velocity = 3,
	fall_speed = 0,
	stepheight = 3,
--[[	sounds = {
		random = "duck",
	},]]
	damage = 4,
	reach = 2,
	jump = true,
	rotate = 270,
	drops = {
		{name = "nssm:life_energy", chance = 1, min = 1, max = 2}
	},
	armor = 80,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 0,
	fire_damage = 0,
	light_damage = 0,
	blood_texture="morparticle.png",
	fly = true,
	attack_type = "dogfight",
	animation = {
		speed_normal = 25,
		speed_run = 35,
		stand_start = 60,
		stand_end = 90,
		walk_start = 10,
		walk_end = 50,
		run_start = 10,
		run_end = 50,
		punch_start = 100,
		punch_end = 115
	}
})

mobs:register_mob("nssm:morbat2", {
	type = "monster",
	hp_max = 13,
	hp_min = 5,
	collisionbox = {-0.1, 0.2, -0.1, 0.1, 0.4, 0.1},
	visual = "mesh",
	mesh = "morbat.x",
	textures = {
		{"morbat2.png"}
	},
	visual_size = {x = 2, y = 2},
	view_range = 40,
	walk_velocity = 0.5,
	run_velocity = 3,
	fall_speed = 0,
	stepheight = 3,
--[[	sounds = {
		random = "duck",
	},]]
	damage = 4,
	reach = 1,
	jump = true,
	rotate = 270,
	drops = {
		{name = "nssm:life_energy", chance = 1, min = 1, max = 2}
	},
	armor = 100,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 0,
	fire_damage = 0,
	light_damage = 0,
	blood_texture="morparticle.png",
	fly = true,
	attack_type = "explode",
	explosion_radius = 3,
	animation = {
		speed_normal = 25,
		speed_run = 35,
		stand_start = 60,
		stand_end = 90,
		walk_start = 10,
		walk_end = 50,
		run_start = 10,
		run_end = 50,
		punch_start = 100,
		punch_end = 115
	}
})


mobs:register_mob("nssm:morbat3", {
	type = "monster",
	hp_max = 13,
	hp_min = 12,
	collisionbox = {-0.1, 0.2, -0.1, 0.1, 0.4, 0.1},
	visual = "mesh",
	mesh = "morbat.x",
	textures = {
		{"morbat3.png"}
	},
	visual_size = {x = 2, y = 2},
	view_range = 40,
	walk_velocity = 0.5,
	run_velocity = 3,
	fall_speed = 0,
	stepheight = 3,
--[[	sounds = {
		random = "duck",
	},]]
	damage = 4,
	reach = 1,
	jump = true,
	rotate = 270,
	drops = {
		{name = "nssm:life_energy", chance = 1, min = 1, max = 2}
	},
	armor = 100,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 0,
	fire_damage = 0,
	light_damage = 0,
	blood_texture = "morparticle.png",
	fly = true,
	attack_type = "shoot",
	arrow = "nssm:morarrow",
	shoot_interval = 3,
	animation = {
		speed_normal = 25,
		speed_run = 35,
		stand_start = 60,
		stand_end = 90,
		walk_start = 10,
		walk_end = 50,
		run_start = 10,
		run_end = 50,
		punch_start = 100,
		punch_end = 115
	}
})
