mobs:register_mob("nssm:black_scorpion", {
	type = "monster",
	hp_max = 45,
	hp_min = 40,
	docile_by_day = true,
	collisionbox = {-0.3, 0.00, -0.3, 0.3, 0.6, 0.3},
	visual = "mesh",
	mesh = "scorpion.x",
	textures = {{"scorpion.png"}},
	visual_size = {x = 7, y = 7},
	makes_footstep_sound = true,
	view_range = 22,
	walk_velocity = 1,
	fear_height = 4,
	run_velocity = 2.5,
--[[	sounds = {
		random = "black_scorpion",
	},]]
	damage = 6,
	reach = 4,
	jump = true,
	drops = {
		{name = "nssm:life_energy", chance = 1, min = 1, max = 8},
	},
	armor = 50,
	drawtype = "front",
	follow = {"farming:wheat"},
	water_damage = 2,
	suffocation = 4,
	lava_damage = 10,
	light_damage = 0,
	group_attack = false,
	attack_animals = true,
	blood_texture="nssm_blood_blue.png",
	stepheight = 1.1,
--	double_melee_attack = true,
	attack_type = "dogfight",
	animation = {
		speed_normal = 20, speed_run = 30,
		stand_start = 10, stand_end = 60,
		walk_start = 70, walk_end = 110,
		run_start = 70, run_end = 110,
		punch_start = 160, punch_end = 180,
		punch2_start = 120, punch2_end = 150,
		die_start = 190, die_end = 210,
	},

	custom_attack = function (self)

		if math.random(30) == 1 then

			self:set_animation("punch2")

			self.attack:punch(self.object, 1.0, {
				full_punch_interval = 1.0,
				damage_groups = {fleshy = self.damage * 10}
			}, nil)
		else
			self:set_animation("punch")

			self.attack:punch(self.object, 1.0, {
				full_punch_interval = 1.0,
				damage_groups = {fleshy = self.damage}
			}, nil)
		end
	end,

	do_custom = function(self, dtime)

		-- set needed values if not already present
		if not self.v2 then
			self.v2 = 0
			self.max_speed_forward = 5
			self.max_speed_reverse = 2
			self.accel = 6
			self.terrain_type = 3
			self.driver_attach_at = {x = 0, y = 0.65, z = 0}
			self.driver_eye_offset = {x = 0, y = -2, z = 0}
			self.driver_scale = {x = 0.09, y = 0.09}
		end

		-- if driver present allow control of horse
		if self.driver then

			mobs.drive(self, "run", "stand", false, dtime)

			return false -- skip rest of mob functions
		end

		return true
	end,

	on_die = function(self, pos)

		-- drop saddle when mob is killed while riding and detach player
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

			-- detatch player already riding mob
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

