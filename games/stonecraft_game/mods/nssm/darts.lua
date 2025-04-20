local function duck_explosion(pos)

	if minetest.is_protected(pos, "") then
		return
	end

	pos.y = pos.y + 1

	minetest.add_particlespawner({
		amount = 10,
		time = 0.2,
		minpos = {x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},
		maxpos = {x = pos.x + 1, y = pos.y + 4, z = pos.z + 1},
		minvel = {x = 0, y = 0, z = 0},
		maxvel = {x = 1, y = 1, z = 1},
		minacc = {x = -0.5, y = 5, z = -0.5},
		maxacc = {x = 0.5, y = 5, z = 0.5},
		minexptime = 1,
		maxexptime = 3,
		minsize = 4,
		maxsize = 6,
		collisiondetection = false,
		vertical = false,
		texture = "duck_egg_fragments.png"
	})

	minetest.after(0.4, function()

		for dx = -1, 1 do

			pos = {x = pos.x + dx, y = pos.y, z = pos.z + dx}

			minetest.add_particlespawner({
				amount = 100,
				time = 0.2,
				minpos = {x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},
				maxpos = {x = pos.x + 1, y = pos.y + 4, z = pos.z + 1},
				minvel = {x = 0, y = 0, z = 0},
				maxvel = {x = 1, y = 5, z = 1},
				minacc = {x = -0.5, y = 5, z = -0.5},
				maxacc = {x = 0.5, y = 5, z = 0.5},
				minexptime = 1,
				maxexptime = 3,
				minsize = 2,
				maxsize = 4,
				collisiondetection = false,
				vertical = false,
				texture = "tnt_smoke.png"
			})

			minetest.add_entity(pos, "nssm:duck")
		end
	end)
end


-- arrow (duck_arrow)
mobs:register_arrow("nssm:duck_father", {
	visual = "sprite",
	visual_size = {x = 1, y = 1},
	textures = {"duck_egg.png"},
	velocity = 8,

	-- direct hit
	hit_player = function(self, player)

		local pos = self.object:get_pos()

		duck_explosion(pos)
	end,

	hit_mob = function(self, player)

		local pos = self.object:get_pos()

		duck_explosion(pos)
	end,

	hit_node = function(self, pos, node)
		duck_explosion(pos)
	end
})


local function ice_explosion(pos)

	for i = pos.x - math.random(0, 1), pos.x + math.random(0, 1), 1 do

		for j = pos.y - 1, pos.y + 4, 1 do

			for k = pos.z - math.random(0, 1), pos.z + math.random(0, 1), 1 do

				local p = {x = i, y = j, z = k}
				local n = minetest.get_node(p).name

				if minetest.get_item_group(n, "unbreakable") == 1
				or minetest.is_protected(p, "")
				or (n == "bones:bones" and not nssm:affectbones(self)) then
				else
					minetest.set_node({x = i, y = j, z = k}, {name = "default:ice"})
				end
			end
		end
	end
end


-- snow_arrow
mobs:register_arrow("nssm:snow_arrow", {
	visual = "sprite",
	visual_size = {x = 1, y = 1},
	textures = {"transparent.png"},
	velocity = 20,

	-- direct hit
	hit_player = function(self, player)

		local pos = self.object:get_pos()

		ice_explosion(pos)
	end,

	hit_mob = function(self, player)

		local pos = self.object:get_pos()

		ice_explosion(pos)
	end,

	hit_node = function(self, pos, node)
		ice_explosion(pos)
	end
})


-- arrow manticore
mobs:register_arrow("nssm:spine", {
	visual = "sprite",
	visual_size = {x = 1, y = 1},
	textures = {"manticore_spine_flying.png"},
	velocity = 10,

	-- direct hit
	hit_player = function(self, player)

		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 2}
		}, nil)
	end,

	hit_mob = function(self, player)

		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 2}
		}, nil)
	end,

	hit_node = function(self, pos, node)
	end
})


-- morbat arrow
mobs:register_arrow("nssm:morarrow", {
	visual = "sprite",
	visual_size = {x = 0.5, y = 0.5},
	textures = {"morarrow.png"},
	velocity= 13,

	hit_player = function(self, player)

		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 3}
		}, nil)
	end,

	hit_node = function(self, pos, node)
	end
})


local function explosion_web(pos, webnode)

	pos = vector.round(pos)

	if minetest.is_protected(pos, "") then
		return
	end

	for i = pos.x - 1, pos.x + 1, 1 do
		for j = pos.y - 3, pos.y, 1 do
			for k = pos.z - 1, pos.z + 1, 1 do

				local p = {x = i, y = j, z = k}
				local k = {x = i, y = j + 1, z = k}
				local current = minetest.get_node(p).name
				local ontop  = minetest.get_node(k).name

				if current ~= "air"
				and current ~= webnode
				and ontop == "air"
				and not minetest.is_protected(p, "")
				and not minetest.is_protected(k, "") then
					minetest.set_node(k, {name = webnode})
				end
			end
		end
	end
end


-- web arrow
mobs:register_arrow("nssm:webball", {
	visual = "sprite",
	visual_size = {x = 1, y = 1},
	textures = {"web_ball.png"},
	velocity = 8,

	-- direct hit
	hit_player = function(self, player)

		local p = player:get_pos()

		explosion_web(p, "nssm:web")
	end,

	hit_mob = function(self, player)

		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 1}
		}, nil)
	end,

	hit_node = function(self, pos, node)
		explosion_web(pos, "nssm:web")
	end
})


-- thick_web arrow
mobs:register_arrow("nssm:thickwebball", {
	visual = "sprite",
	visual_size = {x = 2, y = 2},
	textures = {"thick_web_ball.png"},
	velocity = 8,

	-- direct hit
	hit_player = function(self, player)
		local p = player:get_pos()
		explosion_web(p, "nssm:thick_web")
	end,

	hit_mob = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 6}
		}, nil)
	end,

	hit_node = function(self, pos, node)
		explosion_web(pos, "nssm:thick_web")
	end
})


-- arrow=>phoenix arrow
mobs:register_arrow("nssm:phoenix_arrow", {
	visual = "sprite",
	visual_size = {x = 1, y = 1},
	textures = {"transparent.png"},
	velocity = 8,

	-- direct hit
	hit_player = function(self, player)
	end,

	on_step = function(self, dtime)

		local pos = self.object:get_pos()

		if minetest.is_protected(pos, "") then
			return
		end

		local n = minetest.get_node(pos).name

		if self.timer == 0 then
			self.timer = os.time()
		end

		if os.time() - self.timer > 5 or minetest.is_protected(pos, "")
		or ((n ~= "air") and (n ~= "nssm:phoenix_fire")) then
			self.object:remove()
		end

		if math.random(2) == 2 then
			minetest.set_node(pos, {name = "nssm:phoenix_fire"})
		end

		if math.random(6) == 1 then

			local p = {
				x = pos.x + math.random(-1, 1),
				y = pos.y + math.random(-1, 1),
				z = pos.z + math.random(-1, 1)
			}

			local n = minetest.get_node(p).name

			if n == "air" then
				minetest.set_node(p, {name = "nssm:phoenix_fire"})
			end
		end
	end
})


local function gas_explosion(pos)

	if minetest.is_protected(pos, "") then
		return
	end

	for dx = -2, 2 do
		for dy = -1, 4 do
			for dz = -2, 2 do

				local p = {x = pos.x + dx, y = pos.y + dy, z = pos.z + dz}

				if minetest.is_protected(p, "") then
					return
				end

				local n = minetest.get_node(p).name

				if n == "air" then
					minetest.set_node(p, {name = "nssm:venomous_gas"})
				end
			end
		end
	end
end


mobs:register_arrow("nssm:super_gas", {
	visual = "sprite",
	visual_size = {x = 1, y = 1},
	textures = {"tnt_smoke.png^[colorize:green:170"},
	velocity = 8,

	-- direct hit
	hit_player = function(self, player)

		local p = player:get_pos()

		gas_explosion(p)
	end,

	hit_node = function(self, pos, node)
		gas_explosion(pos)
	end
})


mobs:register_arrow("nssm:roar_of_the_dragon", {
	visual = "sprite",
	visual_size = {x = 1, y = 1},
	textures = {"transparent.png"},
	velocity = 10,

	on_step = function(self, dtime)

		local pos = self.object:get_pos()
		local n = minetest.get_node(pos).name

		if self.timer == 0 then
			self.timer = os.time()
		end

		if os.time() - self.timer > 8 or minetest.is_protected(pos, "") then
			self.object:remove()
		end

		local objects = minetest.get_objects_inside_radius(pos, 1)

		for _,obj in ipairs(objects) do

			local ent = obj and obj:get_luaentity()
			local name = ent and ent.name

			if name and name ~= "nssm:roar_of_the_dragon"
			and name ~= "nssm:mese_dragon" then

				obj:set_hp(obj:get_hp() - 0.05)

				if obj:get_hp() <= 0 then

					if (not obj:is_player())
					and name ~= self.object:get_luaentity().name then
						obj:remove()
					end
				end
			end
		end

		minetest.set_node(pos, {name = "air"})

		if math.random(2) == 1 then

			local p = {
				x = pos.x + math.random(-1, 1),
				y = pos.y + math.random(-1, 1),
				z = pos.z + math.random(-1, 1)
			}

			if not minetest.is_protected(p, "") then
				minetest.set_node(p, {name = "air"})
			end
		end
	end
})


mobs:register_arrow("nssm:lava_arrow", {
	visual = "sprite",
	visual_size = {x = 1, y = 1},
	textures = {"transparent.png"},
	velocity = 10,

	-- direct hit
	hit_player = function(self, player)

		local pos = self.object:get_pos()

		if minetest.is_protected(pos, "") then
			return
		end

		for dy = -1, 6, 1 do
			for dx = -1, 1, 2 do
				for dz = -1, 1, 2 do

					local p = {x = pos.x + dx, y = pos.y + dy, z = pos.z + dz}
					local n = minetest.get_node(p).name

					if n ~= "default:lava_flowing"
					and not minetest.is_protected(p, "") then
						minetest.set_node(p, {name = "default:lava_flowing"})
					end
				end
			end
		end
	end,

	hit_node = function(self, pos, node)
	end
})
