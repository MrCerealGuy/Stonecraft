mobs:register_mob("nssm:morgut", {
	type = "monster",
	hp_max = 35,
	hp_min = 28,
	collisionbox = {-0.3, -0.1, -0.3, 0.3, 1.8, 0.3},
	visual = "mesh",
	rotate= 270,
	mesh = "morgut.x",
	textures = {{"morgut.png"}},
	visual_size = {x=5, y=5},
	makes_footstep_sound = true,
	view_range = 26,
	walk_velocity = 0.5,
	reach =2,
	run_velocity = 4,
	damage = 4,
	runaway = true,
	jump = true,
    sounds = {
		random = "morgut",
	},
	drops = {
		{name = "nssm:life_energy",
		chance = 1,
		min = 1,
		max = 3,},
		{name = "nssm:gluttonous_soul_fragment",
		chance = 3,
		min = 1,
		max = 1,},
	},
	armor = 70,
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
		run_start = 100,
		run_end = 120,
		punch_start = 130,
		punch_end = 160,
	},

	do_custom = function (self)
		self.flag = (self.flag or 0)

		if self.inv_flag ~= 1 then
			self.inventory = {}
			for i=1,32 do
				self.inventory[i]={name = '', num = 0}
			end
		end
		self.inv_flag = (self.inv_flag or 1)

		if self.flag == 1 then
			self.state = ""
			set_animation(self, "run")
			self.object:setyaw(self.dir)
			set_velocity(self, 4)

			if os.time() - self.morgut_timer > 3 then
				self.flag = 0
				self.state = "stand"
			end
		end

	end,
	custom_attack = function (self)
		self.curr_attack = (self.curr_attack or self.attack)
		self.morgut_timer = (self.morgut_timer or os.time())

		self.dir = (self.dir or 0)
		if (os.time() - self.morgut_timer) > 1 then
			if self.attack then
				local s = self.object:getpos()
				local p = self.attack:getpos()
				set_animation(self, "punch")
				local m = 2

				minetest.add_particlespawner(
					6, --amount
					1, --time
					{x=p.x-0.5, y=p.y-0.5, z=p.z-0.5}, --minpos
					{x=p.x+0.5, y=p.y+0.5, z=p.z+0.5}, --maxpos
					{x=(s.x-p.x)*m, y=(s.y-p.y)*m, z=(s.z-p.z)*m}, --minvel
					{x=(s.x-p.x)*m, y=(s.y-p.y)*m, z=(s.z-p.z)*m}, --maxvel
					{x=s.x-p.x, y=s.y-p.y, z=s.z-p.z}, --minacc
					{x=s.x-p.x, y=s.y-p.y, z=s.z-p.z}, --maxacc
					0.2, --minexptime
					0.3, --maxexptime
					2, --minsize
					3, --maxsize
					false, --collisiondetection
					"roasted_duck_legs.png" --texture
				)

				minetest.after(1, function (self)
					if self then
						if self.attack:is_player() then
							local pname = self.attack:get_player_name()
							local player_inv = minetest.get_inventory({type='player', name = pname})

							if player_inv:is_empty('main') then
								--minetest.chat_send_all("Inventory empty")
							else
								for i = 1,32 do
									--minetest.chat_send_all("Inventory is not empty")
									local items = player_inv:get_stack('main', i)
									local n = items:get_name()
									if minetest.get_item_group(n, "eatable")==1 then
										local index
										local found = 0
										for j = 1,32 do
											if found == 0 then
												if self.inventory[j].num == 0 then
													--found an empty place
													found = 2
													index = j
												else
													--found a corrsponding itemstack
													if self.inventory[j].name == n then
														self.inventory[j].num = self.inventory[j].num +1
														found = 1
													end
												end
											end
										end
										if found == 2  then
											self.inventory[index].name = n
											self.inventory[index].num = 1
										end
										items:take_item()
										player_inv:set_stack('main', i, items)
									end
								end
							end
							set_animation(self, "run")
							self.flag = 1
							self.morgut_timer = os.time()
							self.curr_attack = self.attack
							self.state = ""
							local pyaw = self.curr_attack: get_look_yaw()
							self.dir = pyaw
							self.object:setyaw(pyaw)
							if self then
								set_velocity(self, 4)
							end
						end
					end
				end,self)
			end
		end
	end,
	on_die = function(self)
		local pos = self.object:getpos()
		if (self.inventory ~= nil) then
			local elem
			for i = 1,32 do
				if self.inventory[i].num~=0 then
					local items = ItemStack(self.inventory[i].name.." "..self.inventory[i].num)
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
