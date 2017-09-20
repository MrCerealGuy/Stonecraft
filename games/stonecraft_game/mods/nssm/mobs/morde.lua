mobs:register_mob("nssm:morde", {
	type = "monster",
	hp_max = 47,
	hp_min = 37,
	collisionbox = {-0.4, -0.1, -0.4, 0.4, 1.6, 0.4},
	visual = "mesh",
	rotate= 270,
	mesh = "morde.x",
	textures = {{"morde.png"}},
	visual_size = {x=10, y=10},
	makes_footstep_sound = true,
	view_range = 20,
	walk_velocity = 0.5,
	reach =3,
	run_velocity = 3.5,
	damage = 6,
	jump = true,
    sounds = {
		random = "morde",
	},
	drops = {
		{name = "nssm:life_energy",
		chance = 1,
		min = 2,
		max = 4,},
		{name = "nssm:proud_soul_fragment",
		chance = 3,
		min = 1,
		max = 1,},
	},
	armor = 60,
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
		speed_run = 25,
		stand_start = 10,
		stand_end = 40,
		walk_start = 50,
		walk_end = 90,
		run_start = 100,
		run_end = 120,
		punch_start = 130,
		punch_end = 160,
	},
	custom_attack = function (self)
		self.morde_timer = (self.morde_timer or os.time())
		if (os.time() - self.morde_timer) > 1 then
			self.morde_timer = os.time()

			local s = self.object:getpos()
			local p = self.attack:getpos()

			set_animation(self, "punch")

			self.health = self.health + (self.damage*2)
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
				self.attack:punch(self.object, 1.0,  {
					full_punch_interval=1.0,
					damage_groups = {fleshy=self.damage}
				}, nil)

				minetest.add_particlespawner(
			        6, --amount
			        1, --time
			        {x=p.x-0.5, y=p.y-0.5, z=p.z-0.5}, --minpos
			        {x=p.x+0.5, y=p.y+0.5, z=p.z+0.5}, --maxpos
			        {x=(s.x-p.x)*m, y=(s.y-p.y+1)*m, z=(s.z-p.z)*m}, --minvel
			        {x=(s.x-p.x)*m, y=(s.y-p.y+1)*m, z=(s.z-p.z)*m}, --maxvel
			        {x=s.x-p.x, y=s.y-p.y+1, z=s.z-p.z}, --minacc
			        {x=s.x-p.x, y=s.y-p.y+1, z=s.z-p.z}, --maxacc
			        0.2, --minexptime
			        0.3, --maxexptime
			        2, --minsize
			        3, --maxsize
			        false, --collisiondetection
			        "morparticle.png" --texture
			    )
			end
		end
	end,
	on_die = function(self)
		local pos = self.object:getpos()
		self.object:remove()
		minetest.add_entity(pos, "nssm:mortick")
	end,
})

minetest.register_entity("nssm:mortick", {
	textures = {"mortick.png"},
	hp_min = 10000,
	hp_max = 10000,
	armor = 100,
	visual = "mesh",
	mesh = "mortick.x",
	visual_size = {x=3, y=3},
	--lifetime = 10,
	damage = 1,
	on_step = function(self, dtime)
		self.mortick_timer = self.mortick_timer or os.time()
		self.timer = self.timer or 0
		self.timer = self.timer+dtime
		local s = self.object:getpos()
		local s1 = {x=s.x, y = s.y-1, z = s.z}

		--[[
		if (os.time()-self.mortick_timer > self.lifetime) then
			self.object:remove()
		end
		]]
		--The mortick dies when he finds himself in the fire
		local name = minetest.env:get_node(s1).name
		if name == "fire:basic_flame" then
			self.object:remove()
		end

		--Find player to attack:
		self.attack = (self.attack or 0)

		local objects = minetest.env:get_objects_inside_radius(s, 8)
		for _,obj in ipairs(objects) do
	        if (obj:is_player()) then
				self.attack = obj
	        end
	    end

		--If found a player follow him
		if self.attack ~= 0 then
			local p = self.attack:getpos()
			local yawp = self.attack:get_look_yaw()
			local pi = math.pi

			p.y = p.y + 1
			p.x = p.x-math.cos(yawp)/2.5
			p.z = p.z-math.sin(yawp)/2.5
			local m = 10
			local v = {x=-(s.x-p.x)*m, y=-(s.y-p.y)*m, z=-(s.z-p.z)*m}
			local yaws = yawp +pi

			--stay attached to players back:
			self.object:setvelocity(v)
			self.object:setyaw(yaws)

			--damage player every ten seconds:
			if (self.timer>10) then
				self.timer = 0
				self.attack:set_hp(self.attack:get_hp() - self.damage)
			end
		end
	end
})
