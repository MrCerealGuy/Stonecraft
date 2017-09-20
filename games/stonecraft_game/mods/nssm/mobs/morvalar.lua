local time_limit = 120
posmorvalarblock = {x=827, y=-30094, z=-817}

function respawn_block(self)
	--start a timer if it doesn't exist
	self.stop_timer = self.stop_timer or os.time()

	--create a variable to record the hp if it doesn't exist
	self.hp_record = self.hp_record or self.health

	if self.hp_record ~= self.health then
		self.stop_timer = os.time()
		self.hp_record = self.health
	else
		if os.time() - self.stop_timer > time_limit then
			minetest.chat_send_all("Time is over!")
			self.object:remove()
			minetest.set_node(posmorvalarblock, {name="nssb:morvalar_block"})
		end
	end
end

mobs:register_mob("nssm:morvalar", {
	type = "monster",
	hp_max = 100,
	hp_min = 100,
	collisionbox = {-0.4, -0.1, -0.4, 0.4, 1.8, 0.4},
	visual = "mesh",
	--rotate= 270,
	mesh = "morvalar.x",
	textures = {{"morvalar.png"}},
	visual_size = {x=5, y=5},
	makes_footstep_sound = true,
	view_range = 50,
	walk_velocity = 1.6,
	reach =3,
	run_velocity = 3.2,
	damage = 8,
	runaway = true,
	jump = true,
    sounds = {
		random = "morvalar7",
	},
	armor = 50,
	drawtype = "front",
	water_damage = 0,
	fear_height = 4,
	floats = 1,
	lava_damage = 0,
	blood_texture="morparticle.png",
	blood_amount=10,
	knock_back=0,
	light_damage = 0,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 30,
		stand_start = 5,
		stand_end = 6,
		walk_start = 10,
		walk_end = 50,
		run_start = 10,
		run_end = 50,
		punch_start = 55,
		punch_end = 80,
	},

	do_custom = function(self)
		respawn_block(self)
	end,

	custom_attack = function (self)
		self.curr_attack = (self.curr_attack or self.attack)
		self.morvalar_timer = (self.morvalar_timer or os.time())

		self.dir = (self.dir or 0)
		if (os.time() - self.morvalar_timer) > 2 then

			local s = self.object:getpos()
			local p = self.attack:getpos()
			set_animation(self, "punch")
			local m = 1

			if self.attack:is_player() then
				if minetest.get_modpath("3d_armor") then
					local pname, player_inv, armor_inv, ppos = armor:get_valid_player(self.attack, "[set_player_armor]")
					local pname = self.attack:get_player_name()
					local player_inv = minetest.get_inventory({type='player', name = pname})
					if player_inv:is_empty('armor') then
						-- punch player if he doesn't own an armor
						self.attack:punch(self.object, 1.0, {
							full_punch_interval = 1.0,
							damage_groups = {fleshy = self.damage}
						}, nil)
					else
						local armor_elements = {}
						local armor_num = 0
						local steal_pos

						for i=1,6 do
							local armor_stack = player_inv:get_stack("armor", i)
							local armor_item = armor_stack:get_name()
							if armor_stack:get_count() > 0 then
								armor_elements[armor_num]={name=armor_item, pos=i}
								armor_num = armor_num + 1
							end
						end
						if armor_num > 0 then
							steal_pos = math.random(1,armor_num)
							steal_pos = steal_pos-1
							local cpos = string.find(armor_elements[steal_pos].name, ":")
							local mod_name = string.sub(armor_elements[steal_pos].name, 0, cpos-1)
							local nname = string.sub(armor_elements[steal_pos].name, cpos+1)

							if mod_name == "3d_armor" then
								nname = "3d_armor_inv_"..nname..".png"
							elseif mod_name == "nssm" then
								nname = "inv_"..nname..".png"
							else
								nname = "3d_armor_inv_chestplate_diamond.png"
							end

							minetest.add_particlespawner(
								1, --amount
								1, --time
								{x=p.x, y=p.y+1, z=p.z}, --minpos
								{x=p.x, y=p.y+1, z=p.z}, --maxpos
								{x=(s.x-p.x)*m, y=(s.y-p.y)*m, z=(s.z-p.z)*m}, --minvel
								{x=(s.x-p.x)*m, y=(s.y-p.y)*m, z=(s.z-p.z)*m}, --maxvel
								{x=s.x-p.x, y=s.y-p.y-1, z=s.z-p.z}, --minacc
								{x=s.x-p.x, y=s.y-p.y-1, z=s.z-p.z}, --maxacc
								0.5, --minexptime
								0.5, --maxexptime
								10, --minsize
								10, --maxsize
								false, --collisiondetection
								nname --texture
							)

							minetest.after(1, function (self)

	                            local armor_stack = player_inv:get_stack("armor", armor_elements[steal_pos].pos)
	                            armor_stack:take_item()
	                            player_inv:set_stack('armor', armor_elements[steal_pos].pos, armor_stack)

	                            armor_stack = armor_inv:get_stack("armor", armor_elements[steal_pos].pos)
	                            armor_stack:take_item()
	                            armor_inv:set_stack('armor', armor_elements[steal_pos].pos, armor_stack)

	                            armor:set_player_armor(self.attack, self.attack)
	                            armor:update_inventory(self.attack)
							end,self)
						end
					end
				else
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
				end
			end
		end
	end,
	on_die = function(self)
		local pos = self.object:getpos()
		self.object:remove()
		add_entity_and_particles("nssm:morvalar6", pos, "morparticle.png", 10)
	end,
})

mobs:register_mob("nssm:morvalar6", {
	type = "monster",
	hp_max = 120,
	hp_min = 120,
	collisionbox = {-0.4, -0.1, -0.4, 0.4, 1.8, 0.4},
	visual = "mesh",
	--rotate= 270,
	mesh = "morvalar.x",
	textures = {{"morvalar.png"}},
	visual_size = {x=5, y=5},
	makes_footstep_sound = true,
	view_range = 50,
	walk_velocity = 1.6,
	reach =4,
	run_velocity = 3.2,
	damage = 8,
	runaway = true,
	jump = true,
    sounds = {
		random = "morvalar6",
	},
	armor = 50,
	drawtype = "front",
	water_damage = 0,
	fear_height = 4,
	floats = 1,
	lava_damage = 0,
	light_damage = 0,
	blood_texture="morparticle.png",
	blood_amount=10,
	knock_back=0,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 30,
		stand_start = 85,
		stand_end = 86,
		walk_start = 90,
		walk_end = 130,
		run_start = 90,
		run_end = 130,
		punch_start = 132,
		punch_end = 162,
	},
	do_custom = function(self)
		respawn_block(self)
	end,
	custom_attack = function (self)
		self.morvalar6_timer = (self.morvalar6_timer or os.time())

		self.dir = (self.dir or 0)
		if (os.time() - self.morvalar6_timer) > 1 then

			local s = self.object:getpos()
			local p = self.attack:getpos()
			set_animation(self, "punch")
			local m = 2



			minetest.after(1, function (self)
				if self.attack:is_player() then
					local pname = self.attack:get_player_name()
					local player_inv = minetest.get_inventory({type='player', name = pname})

					if player_inv:is_empty('main') then
						--minetest.chat_send_all("Inventory empty")
					else
						local imhungry = 0
						for i = 1,32 do
							--minetest.chat_send_all("Inventory is not empty")
							local items = player_inv:get_stack('main', i)
							local n = items:get_name()
							if minetest.get_item_group(n, "eatable")==1 then
								imhungry = 1
								for t = 0,2 do
									items:take_item()
								end
								player_inv:set_stack('main', i, items)
							end
						end
						if imhungry == 0 then
							self.attack:punch(self.object, 1.0, {
								full_punch_interval = 1.0,
								damage_groups = {fleshy = self.damage}
							}, nil)
						else
							s.y = s.y+1.8
							minetest.add_particlespawner(
								1, --amount
								1, --time
								{x=p.x, y=p.y+1, z=p.z}, --minpos
								{x=p.x, y=p.y+1, z=p.z}, --maxpos
								{x=(s.x-p.x)*m, y=(s.y-p.y)*m, z=(s.z-p.z)*m}, --minvel
								{x=(s.x-p.x)*m, y=(s.y-p.y)*m, z=(s.z-p.z)*m}, --maxvel
								{x=s.x-p.x, y=s.y-p.y-1, z=s.z-p.z}, --minacc
								{x=s.x-p.x, y=s.y-p.y-1, z=s.z-p.z}, --maxacc
								0.5, --minexptime
								0.5, --maxexptime
								10, --minsize
								10, --maxsize
								false, --collisiondetection
								"roasted_duck_legs.png" --texture
							)
						end
						self.morvalar6_timer = os.time()
					end
				end

			end,self)
		end
	end,
	on_die = function(self)
		local pos = self.object:getpos()
		self.object:remove()
		add_entity_and_particles("nssm:morvalar5", pos, "morparticle.png", 10)
	end,
})


mobs:register_mob("nssm:morvalar5", {
	type = "monster",
	hp_max = 130,
	hp_min = 130,
	collisionbox = {-0.4, -0.1, -0.4, 0.4, 1.8, 0.4},
	visual = "mesh",
	--rotate= 270,
	mesh = "morvalar.x",
	textures = {{"morvalar.png"}},
	visual_size = {x=5, y=5},
	makes_footstep_sound = true,
	view_range = 50,
	walk_velocity = 1.6,
	reach =6,
	run_velocity = 3.2,
	damage = 4,
	runaway = true,
	jump = true,
    sounds = {
		random = "morvalar5",
	},
	armor = 40,
	drawtype = "front",
	water_damage = 0,
	fear_height = 4,
	floats = 1,
	lava_damage = 0,
	light_damage = 0,
	blood_texture="morparticle.png",
	blood_amount=10,
	knock_back=0,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 30,
		stand_start = 165,
		stand_end = 166,
		walk_start = 170,
		walk_end = 210,
		run_start = 170,
		run_end = 210,
		punch_start = 215,
		punch_end = 245,
	},
	do_custom = function(self)
		respawn_block(self)
	end,
	custom_attack = function (self)
		self.morvalar5_timer = (self.morvalar5_timer or os.time())

		self.dir = (self.dir or 0)
		if (os.time() - self.morvalar5_timer) > 2 then

			local s = self.object:getpos()
			local p = self.attack:getpos()
			minetest.after(2, function(self)
				set_animation(self, "punch")
				tnt_boom_nssm(p, {damage_radius=6,radius=5,ignore_protection=false})
				self.morvalar5_timer = os.time()
			end,self)
		end
	end,
	on_die = function(self)
		local pos = self.object:getpos()
		self.object:remove()
		add_entity_and_particles("nssm:morvalar4", pos, "morparticle.png", 10)
	end,
})


mobs:register_mob("nssm:morvalar4", {
	type = "monster",
	hp_max = 100,
	hp_min = 100,
	collisionbox = {-0.4, -0.1, -0.4, 0.4, 1.8, 0.4},
	visual = "mesh",
	--rotate= 270,
	mesh = "morvalar.x",
	textures = {{"morvalar.png"}},
	visual_size = {x=5, y=5},
	makes_footstep_sound = true,
	view_range = 50,
	walk_velocity = 1.6,
	reach = 3,
	run_velocity = 3.2,
	damage = 4,
	runaway = true,
	jump = true,
    sounds = {
		random = "morvalar4",
	},
	armor = 30,
	drawtype = "front",
	water_damage = 0,
	fear_height = 4,
	floats = 1,
	lava_damage = 0,
	light_damage = 0,
	blood_texture="morparticle.png",
	blood_amount=10,
	knock_back=0,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 30,
		stand_start = 250,
		stand_end = 251,
		walk_start = 255,
		walk_end = 295,
		run_start = 255,
		run_end = 295,
		punch_start = 300,
		punch_end = 320,
	},
	do_custom = function(self)
		respawn_block(self)
	end,
	custom_attack = function(self)
		self.morvalar4_timer = (self.morvalar4_timer or os.time())
		if (os.time() - self.morvalar4_timer) > 1 then
			self.morvalar4_timer = os.time()
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

			minetest.after(1.4, function()
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
	end,
	on_die = function(self)
		local pos = self.object:getpos()
		self.object:remove()
		add_entity_and_particles("nssm:morvalar3", pos, "morparticle.png", 10)
	end,
})

mobs:register_mob("nssm:morvalar3", {
	type = "monster",
	hp_max = 120,
	hp_min = 120,
	collisionbox = {-0.4, -0.1, -0.4, 0.4, 1.8, 0.4},
	visual = "mesh",
	--rotate= 270,
	mesh = "morvalar.x",
	textures = {{"morvalar.png"}},
	visual_size = {x=5, y=5},
	makes_footstep_sound = true,
	view_range = 50,
	walk_velocity = 1.6,
	reach = 3,
	run_velocity = 3.2,
	damage = 16,
	runaway = true,
	jump = true,
    sounds = {
		random = "morvalar3",
	},
	armor = 30,
	drawtype = "front",
	water_damage = 0,
	fear_height = 4,
	floats = 1,
	lava_damage = 0,
	light_damage = 0,
	blood_texture="morparticle.png",
	blood_amount=10,
	knock_back=0,
	on_rightclick = nil,
	attack_type = "dogshoot",
	dogshoot_switch = true,
    arrow = "nssm:morarrow",
    shoot_interval = 2,
    shoot_offset = 0,
	animation = {
		speed_normal = 15,
		speed_run = 30,
		stand_start = 325,
		stand_end = 326,
		walk_start = 330,
		walk_end = 370,
		run_start = 330,
		run_end = 370,
		punch_start = 375,
		punch_end = 395,
		shoot_start = 400,
    	shoot_end = 450,
	},
	do_custom = function(self)
		respawn_block(self)
	end,
	on_die = function(self)
		local pos = self.object:getpos()
		self.object:remove()
		add_entity_and_particles("nssm:morvalar2", pos, "morparticle.png", 10)
	end,
})

mobs:register_mob("nssm:morvalar2", {
	type = "monster",
	hp_max = 90,
	hp_min = 90,
	collisionbox = {-0.4, -0.1, -0.4, 0.4, 1.8, 0.4},
	visual = "mesh",
	--rotate= 270,
	mesh = "morvalar.x",
	textures = {{"morvalar.png"}},
	visual_size = {x=5, y=5},
	makes_footstep_sound = true,
	view_range = 50,
	walk_velocity = 1.6,
	reach = 6,
	run_velocity = 3.2,
	damage = 4,
	runaway = true,
	jump = true,
    sounds = {
		random = "morvalar2",
	},
	armor = 50,
	drawtype = "front",
	water_damage = 0,
	fear_height = 4,
	floats = 1,
	lava_damage = 0,
	light_damage = 0,
	blood_texture="morparticle.png",
	blood_amount=10,
	knock_back=0,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 30,
		stand_start = 455,
		stand_end = 456,
		walk_start = 460,
		walk_end = 500,
		run_start = 460,
		run_end = 500,
		punch_start = 505,
		punch_end = 545,
	},
	do_custom = function(self)
		respawn_block(self)
	end,
	custom_attack = function(self)
		self.morvalar2_timer = (self.morvalar2_timer or os.time())
		if (os.time() - self.morvalar2_timer) > 1 then
			self.morvalar2_timer = os.time()
			local s = self.object:getpos()
			local p = self.attack:getpos()

			local counter = 0
			local objects = minetest.env:get_objects_inside_radius(s, 7)
			for _,obj in ipairs(objects) do
				if obj:get_luaentity() then
					local name = obj:get_luaentity().name
					if (name == "nssm:mordain" or name == "nssm:morde" or name == "nssm:morgut" or name == "nssm:morgre" or name == "nssm:morlu" or name == "nssm:morwa" or name == "nssm:morvy") then
						counter = counter + 1
					end
				end
			end
			minetest.chat_send_all("Ne ho contati: "..counter)
			if counter < 2 then
				set_animation(self, "punch")

				local v = vector.subtract(p,s)
				--local v = {x = s.x-p.x, y = s.y-p.y , z= s.z-p.z}
				v = vector.normalize(v)
				local per = perpendicular_vector(v)
				local p1 = vector.add(s,v)
				p1 = vector.subtract(p1,vector.multiply(per,4))

				add_entity_and_particles("nssm:morwa", p1, "morparticle.png", 1)
				p1 = vector.add(p1,per)
				add_entity_and_particles("nssm:mordain", p1, "morparticle.png", 1)
				p1 = vector.add(p1,per)
				add_entity_and_particles("nssm:morgre", p1, "morparticle.png", 1)
				p1 = vector.add(p1,per)
				add_entity_and_particles("nssm:morlu", p1, "morparticle.png", 1)
				p1 = vector.add(p1,per)
				add_entity_and_particles("nssm:morgut", p1, "morparticle.png", 1)
				p1 = vector.add(p1,per)
				add_entity_and_particles("nssm:morde", p1, "morparticle.png", 1)
				p1 = vector.add(p1,per)
				add_entity_and_particles("nssm:morvy", p1, "morparticle.png", 1)
				p1 = vector.add(p1,per)
			end
		end
	end,
	on_die = function(self)
		local pos = self.object:getpos()
		self.object:remove()
		add_entity_and_particles("nssm:morvalar1", pos, "morparticle.png", 10)
	end,
})

mobs:register_mob("nssm:morvalar1", {
	type = "monster",
	hp_max = 160,
	hp_min = 160,
	collisionbox = {-0.4, -0.1, -0.4, 0.4, 1.8, 0.4},
	visual = "mesh",
	--rotate= 270,
	mesh = "morvalar.x",
	textures = {{"morvalar.png"}},
	visual_size = {x=5, y=5},
	makes_footstep_sound = true,
	view_range = 50,
	walk_velocity = 1.6,
	reach = 6,
	run_velocity = 3.2,
	damage = 4,
	runaway = true,
	jump = true,
    sounds = {
		random = "morvalar1",
	},
	armor = 20,
	drawtype = "front",
	water_damage = 0,
	fear_height = 4,
	floats = 1,
	lava_damage = 0,
	light_damage = 0,
	blood_texture="morparticle.png",
	blood_amount=10,
	knock_back=0,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 30,
		stand_start = 550,
		stand_end = 551,
		walk_start = 560,
		walk_end = 600,
		run_start = 560,
		run_end = 600,
		punch_start = 610,
		punch_end = 640,
	},
	do_custom = function(self)
		respawn_block(self)
	end,
	custom_attack = function (self)
		self.morvalar1_timer = (self.morvalar1_timer or os.time())
		if (os.time() - self.morvalar1_timer) > 3 then
			self.morvalar1_timer = os.time()

			local s = self.object:getpos()
			local p = self.attack:getpos()

			set_animation(self, "punch")

			local m = 3

			if minetest.line_of_sight({x = p.x, y = p.y +1.5, z = p.z}, {x = s.x, y = s.y +1.5, z = s.z}) == true then
				-- play attack sound
				if self.sounds.attack then
					minetest.sound_play(self.sounds.attack, {
						object = self.object,
						max_hear_distance = self.sounds.distance
					})
				end
				-- punch player
				self.health = self.health + (self.damage*3)
				self.attack:punch(self.object, 1.0,  {
					full_punch_interval=1.0,
					damage_groups = {fleshy=self.damage}
				}, nil)
			end
		end
	end,
	on_die = function(self)
		local pos = self.object:getpos()
		self.object:remove()
		add_entity_and_particles("nssm:morvalar0", pos, "morparticle.png", 10)
	end,
})

mobs:register_mob("nssm:morvalar0", {
	type = "monster",
	hp_max = 100,
	hp_min = 100,
	collisionbox = {-0.4, -0.1, -0.4, 0.4, 1.8, 0.4},
	visual = "mesh",
	--rotate= 270,
	mesh = "morvalar.x",
	textures = {{"morvalar.png"}},
	visual_size = {x=5, y=5},
	makes_footstep_sound = true,
	view_range = 50,
	walk_velocity = 1.6,
	reach = 16,
	run_velocity = 3.2,
	damage = 4,
	runaway = true,
	jump = true,
    sounds = {
		random = "kamehameha",
	},
	drops = {
		{name = "nssm:death_scythe",
		chance = 1,
		min = 1,
		max = 1,},
	},
	armor = 30,
	drawtype = "front",
	water_damage = 0,
	fear_height = 4,
	floats = 1,
	lava_damage = 0,
	light_damage = 0,
	blood_texture="morparticle.png",
	blood_amount=10,
	knock_back=0,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 30,
		stand_start = 645,
		stand_end = 646,
		walk_start = 650,
		walk_end = 690,
		run_start = 650,
		run_end = 690,
		punch_start = 700,
		punch_end = 750,
	},
	do_custom = function(self)
		respawn_block(self)
	end,
	custom_attack = function (self)
		self.morvalar1_timer = (self.morvalar1_timer or os.time())
		if (os.time() - self.morvalar1_timer) > 1 then
			self.morvalar1_timer = os.time()

			local s = self.object:getpos()
			local p = self.attack:getpos()

			set_animation(self, "punch")

			local m = 5 	--velocity of the kamehameha
			local obj = minetest.add_entity(s, "nssm:kamehameha_bad")

			s.y = s.y+0.5
			p.y = p.y+0.9
			local dir = {x=(p.x-s.x)*m, y=(p.y-s.y)*m, z=(p.z-s.z)*m} --direction of the kamehameha
			obj:setvelocity(dir)
		end
	end,
	on_die = function(self)
		local pos = self.object:getpos()
		self.object:remove()
		minetest.add_particlespawner({
			amount = 500,
			time = 2,
			minpos = {x=pos.x-2, y=pos.y-1, z=pos.z-2},
			maxpos = {x=pos.x+2, y=pos.y+4, z=pos.z+2},
			minvel = {x=0, y=0, z=0},
			maxvel = {x=1, y=2, z=1},
			minacc = {x=-0.5,y=0.6,z=-0.5},
			maxacc = {x=0.5,y=0.7,z=0.5},
			minexptime = 2,
			maxexptime = 3,
			minsize = 3,
			maxsize = 5,
			collisiondetection = false,
			vertical = false,
			texture = "morparticle.png",
		})
		minetest.set_node(posmorvalarblock, {name="nssb:dis_morvalar_block"})
		--minetest.add_entity(pos, "nssm:morvalar3")
	end,
})

minetest.register_entity("nssm:kamehameha_bad", {
	textures = {"kamehameha.png"},
	on_step = function(self, dtime)
		local pos = self.object:getpos();
		if self.timer == 0 then
			self.timer = os.time()
		end

		if os.time() - self.timer > self.life_time then
			self.object:remove()
		end

		local objects = minetest.env:get_objects_inside_radius(pos, 2)
		for _,obj in ipairs(objects) do
			if obj:is_player() then
				minetest.chat_send_all("Dentro il raggio grande")
				obj:set_hp(obj:get_hp()-5)
			end
			if obj:get_luaentity() then
				local name = obj:get_luaentity().name
				if name ~= "nssm:morvalar0" and name ~="nssm:kamehameha_bad" then
		            obj:set_hp(obj:get_hp()-5)
		            if (obj:get_hp() <= 0) then
		                if (not obj:is_player()) then
		                    obj:remove()
		                end
		            end
				end
	        end
		end
		local objects = minetest.env:get_objects_inside_radius(pos, 1)
		for _,obj in ipairs(objects) do
			if obj:is_player() then
				tnt_boom_nssm(pos, {damage_radius=6,radius=5,ignore_protection=false})
				self.object:remove()
				minetest.chat_send_all("Dentro il raggio piccolo")
			end
			if obj:get_luaentity() then
				local name = obj:get_luaentity().name
				if name ~= "nssm:morvalar0" and name ~="nssm:kamehameha_bad" then
					tnt_boom_nssm(pos, {damage_radius=6,radius=5,ignore_protection=false})
					self.object:remove()
				end
			end
		end

		local nodename = minetest.env:get_node(pos).name
		if nodename ~= "air" then
			explosion(pos, 5, 0, 1, true)
			self.object:remove()
		end
	end,
	life_time = 40,
	timer = 0,
	custom_timer = 0,
})


--[[
7 code: ruba l'armatura come il morlu, ma poi non scappa e ti attacca normalmente. O un po' un po' o prima ruba e poi ti ara e basta.

6 code: stand: 85-86 walk: 90-130 attack: 132-162
Attacca come prima con 7 ma ruba il cibo come il morvalar6 al posto dell'armatura, e non scappa ma attacca.

5 code: stand: 165-166 walk: 170-210 attack: 215-245
Fa esplodere un po' la sua coda come un Morgre fa esplodere se stesso.

4 code: stand: 250-251 walk: 255-295 attack: 300-320
Attacca esattamente come un Mordain

3 code: stand: 325-326 walk: 330-370 attack: 375-395(punch) 400-450(shoot)
Dogshoot con lo stesso intervel del Morwa, che mi pare sia 2.

2 code: stand: 455-456 walk: 460-500 attack: 505-545
Evoca intorno a s� i 7 mostri del Morlendor contemporaneamente, non fa nulla fino a quando sono nel suo raggio visivo, quando muoiono ne evoca altri 7 e cos� via fino a che non lo abbatti, sei libero di reinterpretare questo attacco in base alle tue capacit�.

1 code: stand: 550-551 walk: 560-600 attack: 610-640
Attacca assorbendo la vita come un morde, si ricarica in questo modo, ma di pi� del numero che assorbe.

0 code: stand: 645-646 walk: 650-690 attack: 700-750
Shoota delle kamehameha
]]--
