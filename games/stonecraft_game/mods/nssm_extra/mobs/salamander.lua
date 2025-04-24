mobs:register_mob("nssm:salamander", {
	type = "monster",
	hp_max = 35,
	hp_min = 24,
	collisionbox = {-0.4, 0, -0.4, 0.4, 0.4, 0.4},
	visual = "mesh",
	mesh = "salamander.x",
	textures = {{"salamander.png"}},
	visual_size = {x = 10, y = 10},
	fear_height = 4,
	makes_footstep_sound = true,
	view_range = 24,
	walk_velocity = 1,
	run_velocity = 2.2,
	damage = 6,
	jump = true,
	drops = {
		{name = "nssm:life_energy", chance = 1, min = 1, max = 2},
	},
	armor = 80,
	drawtype = "front",
	water_damage = 10,
	lava_damage = 0,
	light_damage = 0,
	follow = {"farming:wheat"},
	group_attack = true,
	attack_animals = true,
	knock_back = 2,
	blood_texture = "nssm_blood.png",
	stepheight = 1.1,
	dogshoot_switch = true,
	attack_type = "dogshoot",
	arrow = "nssm:lava_block_bomb",
	reach = 2,
	shoot_interval = 2,
	shoot_offset = 2,
	animation = {
		speed_normal = 25, speed_run = 35,
		stand_start = 0, stand_end = 80,
		walk_start = 110, walk_end = 150,
		run_start = 110, run_end = 150,
		punch_start = 160, punch_end = 180,
		shoot_start = 200, shoot_end = 250,
		die_start = 80, die_end = 100,
--		swim_start = 260, swim_end = 300,
	},

	custom_attack = function(self)

		local p = self.attack:get_pos()
		local s = self.object:get_pos()
		local ss = {x = s.x, y = s.y +0.5, z = s.z}
		local pp = {x = p.x, y = p.y +1.5, z = p.z}
		local vel = vector.subtract(pp,ss)

		self:set_animation("punch")

		if minetest.line_of_sight(
				{x = p.x, y = p.y +1.5, z = p.z},
				{x = s.x, y = s.y +1.5, z = s.z}) == true then

			-- play attack sound
			if self.sounds.attack then

				minetest.sound_play(self.sounds.attack, {
					object = self.object,
					max_hear_distance = self.sounds.distance
				}, true)
			end

			-- punch player
			self.attack:punch(self.object, 1.0,  {
				full_punch_interval=1.0,
				damage_groups = {fleshy=self.damage}
			}, nil)
		end

		minetest.add_particlespawner({
			amount = 25,
			time = 0.5,
			minpos = ss,
			maxpos = ss,
			minvel = vector.multiply(vel, 2),
			maxvel = vector.multiply(vel, 4),
			minacc = {x = 0, y = 0, z = 0},
			maxacc = {x = 0, y = 0, z = 0},
			minexptime = 1,
			maxexptime = 1.5,
			minsize = 5,
			maxsize = 10,
			collisiondetection = true,
			texture = "phoenix_fire.png"
		})
	end,

	do_custom = function(self, dtime)

		-- set needed values if not already present
		if not self.v2 then
			self.v2 = 0
			self.max_speed_forward = 5
			self.max_speed_reverse = 2
			self.accel = 6
			self.terrain_type = 3
			self.driver_attach_at = {x = 0, y = 0.4, z = -0.8}
			self.driver_eye_offset = {x = 0, y = -2, z = 0}
			self.driver_scale = {x = 0.09, y = 0.09}
		end

		-- if driver present allow control of mob
		if self.driver then

			--mobs.fly(self, dtime, 6, true, "nssm:lava_block_bomb", "run", "stand")
			mobs.drive(self, "run", "stand", false, dtime)

			return false -- skip rest of mob functions
		end

		return true
	end,

	on_die = function(self, pos)

		-- drop saddle when mob is killed while riding and detatch properly
		if self.driver then
			minetest.add_item(pos, "mobs:saddle")
			mobs.detach(self.driver, {x = 1, y = 0, z = 1})
		end

	end,

	on_rightclick = function(self, clicker)

		-- make sure player is clicking
		if not clicker or not clicker:is_player() then
			return
		end

		-- feed, tame or heal
		if mobs:feed_tame(self, clicker, 10, true, true) then
			return
		end

		-- make sure tamed mob is being clicked by owner only
		if self.tamed and self.owner == clicker:get_player_name() then

			local inv = clicker:get_inventory()

			-- detatch player already riding horse
			if self.driver and clicker == self.driver then

				mobs.detach(clicker, {x = 1, y = 0, z = 1})

				-- add saddle back to inventory
				if inv:room_for_item("main", "mobs:saddle") then
					inv:add_item("main", "mobs:saddle")
				else
					minetest.add_item(clicker.getpos(), "mobs:saddle")
				end

			-- attach player
			elseif not self.driver
			and clicker:get_wielded_item():get_name() == "mobs:saddle" then

				self.object:set_properties({stepheight = 1.1})
				mobs.attach(self, clicker)

				-- take saddle from inventory
				inv:remove_item("main", "mobs:saddle")
			end
		end

		-- used to capture horse with magic lasso
--		mobs:capture_mob(self, clicker, 0, 0, 80, false, nil)
	end
})

