mobs:register_mob("nssm:morlu", {
	type = "monster",
	hp_max = 36,
	hp_min = 26,
	collisionbox = {-0.3, -0.1, -0.3, 0.3, 0.6, 0.3},
	visual = "mesh",
	rotate= 270,
	mesh = "morlu.x",
	textures = {
		{"morlu.png"}
	},
	visual_size = {x = 7, y = 7},
	makes_footstep_sound = true,
	view_range = 28,
	walk_velocity = 0.5,
	reach =2,
	run_velocity = 4,
	damage = 4,
	runaway = true,
	jump = true,
	sounds = {
		random = "morlu1",
		random = "morlu2"
	},
	drops = {
		{name = "nssm:life_energy", chance = 1, min = 3, max = 4},
		{name = "nssm:lustful_soul_fragment", chance = 3, min = 1, max = 1}
	},
	armor = 40,
	drawtype = "front",
	water_damage = 0,
	fear_height = 4,
	floats = 1,
	lava_damage = 0,
	fire_damage = 0,
	light_damage = 0,
	group_attack = true,
	attack_animals = true,
	knock_back = 1,
	blood_texture = "morparticle.png",
	stepheight = 1.1,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 30,
		stand_start = 10,
		stand_end = 40,
		walk_start = 50,
		walk_end = 90,
		run_start = 50,
		run_end = 90,
		punch_start = 100,
		punch_end = 130
	},

	do_custom = function (self)

		self.flag = (self.flag or 0)

		if self.inv_flag ~= 1 then

			self.inventory = {}
			self.invnum = 0

			for i = 1, 6 do
				self.inventory[i] = {name = ""}
			end
		end

		self.inv_flag = (self.inv_flag or 1)

		if self.flag == 1 then

			self.state = ""

			self:set_animation("run")

			self:set_yaw(self.dir)

			self:set_velocity(4)

			if os.time() - self.morlu_timer > 3 then
				self.flag = 0
				self.state = "stand"
			end
		end

	end,

	custom_attack = function (self)

		self.curr_attack = (self.curr_attack or self.attack)
		self.morlu_timer = (self.morlu_timer or os.time())

		self.dir = (self.dir or 0)

		if (os.time() - self.morlu_timer) > 1 then

			local s = self.object:get_pos()
			local p = self.attack:get_pos()

			self:set_animation("punch")

			local m = 1

			if self.attack:is_player() then

				if minetest.get_modpath("3d_armor") then

					local pname, player_inv = armor:get_valid_player(
							self.attack, "[set_player_armor]")

					local pname = self.attack:get_player_name()
					local player_inv = minetest.get_inventory({
							type = "player", name = pname})
					local armor_inv = minetest.get_inventory({
							type = 'detached', name = pname.."_armor"})

					if armor_inv:is_empty("armor") then

						-- punch player if he doesn't own an armor
						self.attack:punch(self.object, 1.0, {
							full_punch_interval = 1.0,
							damage_groups = {fleshy = self.damage}
						}, nil)
					else
						local armor_elements = {}
						local armor_num = 0
						local steal_pos

						for i = 1, 6 do

							local armor_stack = armor_inv:get_stack("armor", i)
							local armor_item = armor_stack:get_name()

							if armor_stack:get_count() > 0 then
								armor_elements[armor_num] = {name=armor_item, pos=i}
								armor_num = armor_num + 1
							end
						end

						if armor_num > 0 then

							steal_pos = math.random(armor_num)
							steal_pos = steal_pos - 1

							local cpos = string.find(armor_elements[steal_pos].name, ":")
							local target_armor = armor_elements[steal_pos].name
							local mod_name = string.sub(target_armor, 0, cpos - 1)
							local nname = string.sub(target_armor, cpos + 1)

							if target_armor:find("admin") then
								nname = "greedy_soul_fragment.png"
							elseif mod_name == "3d_armor" then
								nname = "3d_armor_inv_" .. nname .. ".png"
							elseif mod_name == "nssm" then
								nname = "inv_" .. nname .. ".png"
							else
								nname = "3d_armor_inv_chestplate_diamond.png"
							end

							minetest.add_particlespawner({
								amount = 1,
								time = 1,
								minpos = {x = p.x, y = p.y + 1, z = p.z},
								maxpos = {x = p.x, y = p.y + 1, z = p.z},
								minvel = {
									x = (s.x - p.x) * m,
									y = (s.y - p.y) * m,
									z = (s.z - p.z) * m
								},
								maxvel = {
									x = (s.x - p.x) * m,
									y = (s.y - p.y) * m,
									z = (s.z - p.z) * m
								},
								minacc = {x = s.x - p.x, y = s.y - p.y - 1, z = s.z - p.z},
								maxacc = {x = s.x - p.x, y = s.y - p.y - 1, z = s.z - p.z},
								minexptime = 0.5,
								maxexptime = 0.5,
								minsize = 10,
								maxsize = 10,
								collisiondetection = false,
								texture = nname
							})

							if target_armor:find("admin") then
								return
							end

							minetest.after(1, function (self)

								if self then

									local armor_stack = armor_inv:get_stack("armor",
											armor_elements[steal_pos].pos)
									armor_stack:take_item()
									armor_inv:set_stack("armor",
											armor_elements[steal_pos].pos, armor_stack)
									armor_stack = armor_inv:get_stack("armor",
											armor_elements[steal_pos].pos)
									armor_stack:take_item()
									armor_inv:set_stack("armor",
											armor_elements[steal_pos].pos, armor_stack)

									armor:set_player_armor(self.attack, self.attack)
									--armor:update_armor(self.attack)
									armor:update_inventory(self.attack)
									--armor:update_player_visuals(self.attack)

									--Update personal inventory of armors:
									if self.invnum ~= nil and self.invnum <= 5 then
										self.invnum = self.invnum + 1
										self.inventory[self.invnum].name =
												armor_elements[steal_pos].name
									end

									self:set_animation("run")

									self.flag = 1
									self.morlu_timer = os.time()
									self.curr_attack = self.attack
									self.state = ""

									local pyaw = self.curr_attack:get_look_horizontal() +
											math.pi / 2

									self.dir = pyaw
									self.object:set_yaw(pyaw)

									if self then
										self:set_velocity(4)
									end
								end
							end, self)
						end
					end
				else
					local s = self.object:get_pos()
					local p = self.attack:get_pos()

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
						self.attack:punch(self.object, 1.0, {
							full_punch_interval = 1.0,
							damage_groups = {fleshy = self.damage}
						}, nil)
					end
				end
			end
		end
	end,

	on_die = function(self)

		local pos = self.object:get_pos()

		if (self.inventory ~= nil) then

			if self.invnum > 0 then

				for i = 1, self.invnum do

					local items = ItemStack(self.inventory[i].name .. " 1")
					local obj = minetest.add_item(pos, items)

					obj:set_velocity({
						x = math.random(-1, 1),
						y = 6,
						z = math.random(-1, 1)
					})
				end
			end
		end

		self.object:remove()
	end
})
