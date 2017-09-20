mobs:register_mob("nssm:morlu", {
	type = "monster",
	hp_max = 36,
	hp_min = 26,
	collisionbox = {-0.3, -0.1, -0.3, 0.3, 0.6, 0.3},
	visual = "mesh",
	rotate= 270,
	mesh = "morlu.x",
	textures = {{"morlu.png"}},
	visual_size = {x=7, y=7},
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
		{name = "nssm:life_energy",
		chance = 1,
		min = 3,
		max = 4,},
		{name = "nssm:lustful_soul_fragment",
		chance = 3,
		min = 1,
		max = 1,},
	},
	armor = 40,
	drawtype = "front",
	water_damage = 0,
	fear_height = 4,
	floats = 1,
	lava_damage = 0,
	light_damage = 0,
	group_attack=true,
	attack_animals=true,
	knock_back=1,
	blood_texture="morparticle.png",
	stepheight=1.1,
	on_rightclick = nil,
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
		punch_end = 130,
	},

	do_custom = function (self)
		self.flag = (self.flag or 0)

		if self.inv_flag ~= 1 then
			self.inventory = {}
			self.invnum = 0
			for i=1,6 do
				self.inventory[i]={name = ''}
			end
		end
		self.inv_flag = (self.inv_flag or 1)

		if self.flag == 1 then
			self.state = ""
			set_animation(self, "run")
			self.object:setyaw(self.dir)
			set_velocity(self, 4)

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
							--[[for i=0,armor_num-1 do
								minetest.chat_send_all("Posizione: "..armor_elements[i].pos.." Oggetto: "..armor_elements[i].name)
							end
							]]

							--minetest.chat_send_all("Selezionato: pos: "..armor_elements[steal_pos].pos.." nome: "..armor_elements[steal_pos].name)
							local cpos = string.find(armor_elements[steal_pos].name, ":")
							--minetest.chat_send_all("Posizione dei due punti: "..cpos)

							local mod_name = string.sub(armor_elements[steal_pos].name, 0, cpos-1)
							local nname = string.sub(armor_elements[steal_pos].name, cpos+1)
							--minetest.chat_send_all("Armor Mod name: "..mod_name)

							if mod_name == "3d_armor" then
								nname = "3d_armor_inv_"..nname..".png"
							elseif mod_name == "nssm" then
								nname = "inv_"..nname..".png"
							else
								nname = "3d_armor_inv_chestplate_diamond.png"
							end
							--minetest.chat_send_all("Nome della texture: "..nname)

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
								if self then

		                            local armor_stack = player_inv:get_stack("armor", armor_elements[steal_pos].pos)
		                            armor_stack:take_item()
		                            player_inv:set_stack('armor', armor_elements[steal_pos].pos, armor_stack)

		                            armor_stack = armor_inv:get_stack("armor", armor_elements[steal_pos].pos)
		                            armor_stack:take_item()
		                            armor_inv:set_stack('armor', armor_elements[steal_pos].pos, armor_stack)

		                            armor:set_player_armor(self.attack, self.attack)
		                            --armor:update_armor(self.attack)
		                            armor:update_inventory(self.attack)
		                            --armor:update_player_visuals(self.attack)

									--Update personal inventory of armors:
									if (self.invnum ~= nil) and (self.invnum <= 5) then
										--minetest.chat_send_all("Invnum: "..self.invnum)
										--minetest.chat_send_all("Salvo: "..armor_elements[steal_pos].name)
										self.invnum = self.invnum + 1
										self.inventory[self.invnum].name = armor_elements[steal_pos].name
									end

									set_animation(self, "run")
									self.flag = 1
									self.morlu_timer = os.time()
									self.curr_attack = self.attack
									self.state = ""
									local pyaw = self.curr_attack: get_look_yaw()
									self.dir = pyaw
									self.object:setyaw(pyaw)
									if self then
										set_velocity(self, 4)
									end
								end
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
		if (self.inventory ~= nil) then
			if self.invnum > 0 then
				for i=1,self.invnum do
					local items = ItemStack(self.inventory[i].name.." 1")
					local obj = minetest.add_item(pos, items)
						obj:setvelocity({
							x = math.random(-1, 1),
							y = 6,
							z = math.random(-1, 1)
						})
				end
			end
		end
		self.object:remove()
	end,
})
