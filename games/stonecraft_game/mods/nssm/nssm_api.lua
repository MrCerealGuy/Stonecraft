nssm.lessvirulent = minetest.settings:get_bool("nssm.lessvirulent") or false
nssm.safebones = minetest.settings:get_bool("nssm.safebones") or false
nssm.cryosave = minetest.settings:get_bool("nssm.cryosave") or false

local function virulence(mobe)

	if not nssm.lessvirulent then
		return 0
	end

	return math.ceil(100 / mobe.hp_max)
end


function nssm:affectbones(mobe) -- as function for adaptable heuristic
	return not nssm.safebones
end


function nssm:drops(drop)

	if drop then

		drop:set_velocity({
			x = math.random(-10, 10) / 9,
			y = 5,
			z = math.random(-10, 10) / 9
		})
	end
end


local function perpendicular_vector(vec) --returns a vector rotated of 90° in 2D

	local ang = math.pi / 2
	local c = math.cos(ang)
	local s = math.sin(ang)
	local i = vec.x * c - vec.z * s
	local k = vec.x * s + vec.z * c
	local j = 0

	return {x = i, y = j, z = k}
end


function nssm:add_entity_and_particles(entity, pos, particles, multiplier)

	minetest.add_particlespawner({
		amount = 100 * multiplier,
		time = 2,
		minpos = {x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
		maxpos = {x = pos.x + 2, y = pos.y + 4, z = pos.z + 2},
		minvel = {x = 0, y = 0, z = 0},
		maxvel = {x = 1, y = 2, z = 1},
		minacc = {x = -0.5, y = 0.6, z = -0.5},
		maxacc = {x = 0.5, y = 0.7, z = 0.5},
		minexptime = 2,
		maxexptime = 3,
		minsize = 3,
		maxsize = 5,
		collisiondetection = false,
		vertical = false,
		texture = particles
	})

	minetest.add_entity(pos, entity)
end


-- compatibility function
function nssm:node_ok(pos, fallback)
	return mobs:node_ok(pos, fallback)
end


function nssm:dist_pos(p, s)

	local v = {
		x = math.abs(s.x - p.x),
		y = math.abs(s.y - p.y),
		z = math.abs(s.z - p.z)
	}

	return math.sqrt(v.x ^ 2 + v.y ^ 2 + v.z ^ 2)
end


local function round(n)

	if (n > 0) then
		return n % 1 >= 0.5 and math.ceil(n) or math.floor(n)
	else
		n = -n

		local t = n % 1 >= 0.5 and math.ceil(n) or math.floor(n)

		return -t
	end
end


function nssm:explosion_particles(pos, exp_radius)

	minetest.add_particlespawner({
		amount = 100 * exp_radius / 2,
		time = 0.1,
		minpos = {x = pos.x - exp_radius, y = pos.y - exp_radius, z = pos.z - exp_radius},
		maxpos = {x = pos.x + exp_radius, y = pos.y + exp_radius, z = pos.z + exp_radius},
		minvel = {x = 0, y = 0, z = 0},
		maxvel = {x = 0.1, y = 0.3, z = 0.1},
		minacc = {x = -0.5, y = 1, z = -0.5},
		maxacc = {x = 0.5, y = 1, z = 0.5},
		minexptime = 0.1,
		maxexptime = 4,
		minsize = 6,
		maxsize = 12,
		collisiondetection = false,
		texture = "tnt_smoke.png"
	})
end


function nssm:digging_attack(
	self,		--the entity of the mob
	group,		--group of the blocks the mob can dig: nil=everything
	max_vel,	--max velocity of the mob
	dim 		--vector representing the dimensions of the mob
	)

	if self.attack and self.attack:is_player() then

		local s = self.object:get_pos()
		local p = self.attack:get_pos()

		local dir = vector.subtract(p,s)

		dir = vector.normalize(dir)

		local per = perpendicular_vector(dir)
		local posp = vector.add(s,dir)

		posp = vector.subtract(posp,per)

		for j = 1, 3 do

			if minetest.is_protected(posp, "") then
				return
			end

			local pos1 = posp

			for i = 0, dim.y do

				local n = minetest.get_node(pos1).name

				if group == nil then

					if minetest.get_item_group(n, "unbreakable") == 1
					or minetest.is_protected(pos1, "")
					or (n == "bones:bones" and not nssm:affectbones(self) ) then
					else
						minetest.remove_node(pos1)
					end
				else
					if ((minetest.get_item_group(n, group) == 1)
					and (minetest.get_item_group(n, "unbreakable") ~= 1)
					and (n ~= "bones:bones")
					and not (minetest.is_protected(pos1, "")) ) then
						minetest.remove_node(pos1)
					end
				end

				pos1.y = pos1.y + 1
			end

			posp.y = s.y
			posp = vector.add(posp,per)
		end
	end
end


function nssm:putting_ability(		--puts under the mob the block defined as 'p_block'
	self,		--the entity of the mob
	p_block, 	--definition of the block to use
	max_vel	--max velocity of the mob
	)

	local v = self.object:get_velocity() ; if not v then return end
	local dx = 0
	local dz = 0

	if math.abs(v.x) > math.abs(v.z) then

		if (v.x) > 0 then
			dx = 1
		else
			dx = -1
		end
	else
		if (v.z) > 0 then
			dz = 1
		else
			dz = -1
		end
	end

	local pos = self.object:get_pos()
	local pos1

	pos.y = pos.y - 1

	pos1 = {x = pos.x + dx, y = pos.y, z = pos.z + dz}

	local n = minetest.get_node(pos).name
	local n1 = minetest.get_node(pos1).name
	local oldmetainf = {
		minetest.get_meta(pos):to_table(),
		minetest.get_meta(pos1):to_table()
	}

	if n ~= p_block and not minetest.is_protected(pos, "")
	and (n == "bones:bones" and nssm:affectbones(self) )
	and n ~= "air" then

		minetest.set_node(pos, {name=p_block})

		if nssm.cryosave then

			local metai = minetest.get_meta(pos)

			metai:from_table(oldmetainf[1]) -- this is enough to save the meta
			metai:set_string("nssm", n)
		end
	end

	if n1 ~= p_block and not minetest.is_protected(pos1, "")
	and (n == "bones:bones" and nssm:affectbones(self) )
	and n ~= "air" then

		minetest.set_node(pos1, {name = p_block})

		if nssm.cryosave then

			local metai = minetest.get_meta(pos1)

			metai:from_table(oldmetainf[2]) -- this is enough to save the meta
			metai:set_string("nssm", n1)
		end
	end
end


function nssm:webber_ability(		--puts randomly around the block defined as w_block
	self,		--the entity of the mob
	w_block, 	--definition of the block to use
	radius		--max distance the block can be put
	)

	if virulence(self) ~= 0
	and math.random(1, virulence(self)) ~= 1 then return end

	local pos = self.object:get_pos()

	if math.random(55) == 1 then

		local dx = math.random(radius)
		local dz = math.random(radius)
		local p = {x = pos.x + dx, y = pos.y - 1, z = pos.z + dz}
		local t = {x = pos.x + dx, y = pos.y, z = pos.z + dz}
		local n = minetest.get_node(p).name
		local k = minetest.get_node(t).name

		if (n ~= "air" and k == "air")
		and not minetest.is_protected(t, "") then
			minetest.set_node(t, {name = w_block})
		end
	end
end


function nssm:midas_ability(		--ability to transform every blocks it touches in the m_block block
	self,		--the entity of the mob
	m_block,
	max_vel,	--max velocity of the mob
	mult, 		--multiplier of the dimensions of the area around that need the transformation
	height 		--height of the mob
	)

	local v = self.object:get_velocity() ; if not v then return end
	local pos = self.object:get_pos()

	if minetest.is_protected(pos, "") then
		return
	end

	local max = 0
	local yaw = (self.object:get_yaw() + self.rotate) or 0
	local x = math.sin(yaw) * -1
	local z = math.cos(yaw)
	local i = 1
	local i1 = -1
	local k = 1
	local k1 = -1

	local multiplier = mult

	if x > 0 then
		i = round(x * max_vel) * multiplier
	else
		i1 = round(x * max_vel) * multiplier
	end

	if z > 0 then
		k = round(z * max_vel) * multiplier
	else
		k1 = round(z * max_vel) * multiplier
	end

	for dx = i1, i do
		for dy = -1, height do
			for dz = k1, k do

				local p = {x = pos.x + dx, y = pos.y + dy, z = pos.z + dz}
				local n = minetest.get_node(p).name
				local d = minetest.registered_nodes[n]

				if d.drawtype ~= "normal" or n == m_block
				or minetest.get_item_group(n, "unbreakable") == 1
				or minetest.is_protected(p, "")
				or (n == "bones:bones" and not nssm:affectbones(self)) then
					-- do nothing
				else
					minetest.set_node(p, {name = m_block})
				end
			end
		end
	end
end
