mobs:register_mob("nssm:lava_titan", {
	type = "monster",
	hp_max = 180,
	hp_min = 180,
	collisionbox = {-0.45, -0.05, -0.45, 0.45, 1.8, 0.45},
	visual = "mesh",
	mesh = "lava_titan.x",
	textures = {{"lava_titan.png"}},
	visual_size = {x=2.7, y=2.7},
	makes_footstep_sound = true,
	view_range = 20,
	fear_height = 4,
	lifetimer = 500,
	walk_velocity = 0.5,
	run_velocity = 1.3,
	floats = 1,
	sounds = {
		random = "lava_titan",
	},
	damage = 8,
	jump = false,
	jump_height=0,
	drops = {
		{name = "nssm:life_energy",
		chance = 1,
		min = 7,
		max = 9,},
		{name = "nssm:lava_titan_eye",
		chance = 1,
		min = 1,
		max = 1,},
		{name = "bucket:bucket_lava",
		chance = 2,
		min = 1,
		max = 3,},
	},
	armor = 20,
	drawtype = "front",
	water_damage = 25,
  	rotate = 270,
	light_damage = 0,
	lava_damage = 0,
	on_rightclick = nil,
	floats = 0,
	blood_texture="stone_blood.png",
	blood_amount=50,
	knock_back=0,
	attack_type = "dogshoot",
	dogshoot_switch = true,
  	arrow = "nssm:lava_arrow",
  	shoot_interval = 2,
  	shoot_offset = 0,
	--[[
	on_dist_attack = function(self, player)
		local pos = player:getpos()
		for dy=-1, 6, 1 do
			for dx=-1, 1, 2 do
				for dz=-1, 1, 2 do
					local p = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
					local n = minetest.env:get_node(p).name
					if n~="default:lava_flowing" and not minetest.is_protected(p, "") then
						minetest.set_node(p, {name="default:lava_flowing"})
					end
				end
			end
		end
	end,
	]]
	animation = {
		speed_normal = 25,
		speed_run = 45,
		stand_start = 120,
		stand_end = 300,
		walk_start = 10,
		walk_end = 110,
		run_start = 10,
		run_end = 110,
		punch_start = 301,
		punch_end = 340,
    	shoot_start =340,
    	shoot_end=400,
	},
	do_custom = function (self)
		digging_attack(self, nil, self.run_velocity, {x=0, y=4, z=0})
		--digging_ability(self, nil, self.run_velocity, {x=0, y=5, z=0})
		--putting_ability(self, "default:lava_source", self.run_velocity)
	end,
	--[[
	custom_attack = function (self)
		digging_attack
		set_animation(self, "punch")
		local p2 = p
		local s2 = s

		p2.y = p2.y + 1.5
		s2.y = s2.y + 1.5

		if line_of_sight_water(self, p2, s2) == true then

			-- play attack sound
			if self.sounds.attack then

				minetest.sound_play(self.sounds.attack, {
					object = self.object,
					max_hear_distance = self.sounds.distance
				})
			end

			-- punch player
			self.attack:punch(self.object, 1.0, {
				full_punch_interval = 1.0,
				damage_groups = {fleshy = self.damage}
			}, nil)
		end
	end,
	]]--
})
