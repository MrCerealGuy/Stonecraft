-- set content id's
local c_air = minetest.get_content_id("air")
local c_ignore = minetest.get_content_id("ignore")
local c_obsidian = minetest.get_content_id("default:obsidian")
local c_brick = minetest.get_content_id("default:obsidianbrick")
local c_chest = minetest.get_content_id("default:chest_locked")

nssm.lessvirulent = minetest.settings:get_bool("nssm.lessvirulent") or false
nssm.safebones = minetest.settings:get_bool("nssm.safebones") or false
nssm.cryosave = minetest.settings:get_bool("nssm.cryosave") or false

function nssm:virulence(mobe)

	if not nssm.lessvirulent then
		return 0
	end

	return math.ceil(100 / mobe.hp_max)
end


function nssm:affectbones(mobe) -- as function for adaptable heuristic
	return not nssm.safebones
end


function drops(drop)

	if drop then

		drop:setvelocity({
			x = math.random(-10, 10) / 9,
			y = 5,
			z = math.random(-10, 10) / 9,
		})
	end
end


function perpendicular_vector(vec) --returns a vector rotated of 90° in 2D

	local ang = math.pi / 2
	local c = math.cos(ang)
	local s = math.sin(ang)
	local i = vec.x * c - vec.z * s
	local k = vec.x * s + vec.z * c
	local j = 0

	return {x = i, y = j, z = k}
end


function add_entity_and_particles(entity, pos, particles, multiplier)

	minetest.add_particlespawner({
		amount = 100*multiplier,
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
		texture = particles,
	})

	minetest.add_entity(pos, entity)
end


-- get node but use fallback for nil or unknown
function node_ok(pos, fallback)

	fallback = fallback or "default:dirt"

	local node = minetest.get_node_or_nil(pos)

	if not node then
		return minetest.registered_nodes[fallback]
	end

	if minetest.registered_nodes[node.name] then
		return node
	end

	return minetest.registered_nodes[fallback]
end


function dist_pos(p, s)
	local v = {
		x = math.abs(s.x - p.x),
		y = math.abs(s.y - p.y),
		z = math.abs(s.z - p.z)
	}

	return math.sqrt(v.x ^ 2 + v.y ^ 2 + v.z ^ 2)
end


--check_for_death functions customized for monsters who respawns (Masticone)
function check_for_death_hydra(self)

	local hp = self.object:get_hp()

	if hp > 0 then

		self.health = hp

		if self.sounds.damage ~= nil then
			minetest.sound_play(self.sounds.damage,{
				object = self.object,
				max_hear_distance = self.sounds.distance
			})
		end

		return false
	end

	local pos = self.object:get_pos()
	local obj = nil

	if self.sounds.death ~= nil then
		minetest.sound_play(self.sounds.death,{
			object = self.object,
			max_hear_distance = self.sounds.distance
		})
	end

	self.object:remove()

	return true
end


function round(n)

	if (n > 0) then
		return n % 1 >= 0.5 and math.ceil(n) or math.floor(n)
	else
		n = -n
		local t = n % 1 >= 0.5 and math.ceil(n) or math.floor(n)
		return -t
	end
end


function explosion_particles(pos, exp_radius)

	minetest.add_particlespawner(
		100*exp_radius/2, --amount
		0.1, --time
		{x=pos.x-exp_radius, y=pos.y-exp_radius, z=pos.z-exp_radius}, --minpos
		{x=pos.x+exp_radius, y=pos.y+exp_radius, z=pos.z+exp_radius}, --maxpos
		{x=0, y=0, z=0}, --minvel
		{x=0.1, y=0.3, z=0.1}, --maxvel
		{x=-0.5,y=1,z=-0.5}, --minacc
		{x=0.5,y=1,z=0.5}, --maxacc
		0.1, --minexptime
		4, --maxexptime
		6, --minsize
		12, --maxsize
		false, --collisiondetection
		"tnt_smoke.png" --texture
	)
end


function digging_attack(
	self,		--the entity of the mob
	group,		--group of the blocks the mob can dig: nil=everything
	max_vel,	--max velocity of the mob
	dim 		--vector representing the dimensions of the mob
	)

	--if math.random(1,nssm:virulence(self)) ~= 1 then return end
	if self.attack and self.attack:is_player() then

		local s = self.object:get_pos()
		local p = self.attack:get_pos()

		local dir = vector.subtract(p,s)

		dir = vector.normalize(dir)

		local per = perpendicular_vector(dir)
		local posp = vector.add(s,dir)

		--minetest.chat_send_all("La mia posizione:"..minetest.pos_to_string(s))
		--minetest.chat_send_all("La posizione davanti:"..minetest.pos_to_string(posp))
		posp = vector.subtract(posp,per)

		for j = 1,3 do
			--minetest.chat_send_all("pos1:"..minetest.pos_to_string(posp).." per.y= "..dim.y)
			if minetest.is_protected(posp, "") then
				return
			end

			local pos1 = posp

			for i = 0, dim.y do

				--minetest.chat_send_all("pos2:"..minetest.pos_to_string(posp).." per.y= "..per.y)

				local n = minetest.get_node(pos1).name
				--local up = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}

				if group == nil then

					if minetest.get_item_group(n, "unbreakable") == 1
					or minetest.is_protected(pos1, "")
					or (n == "bones:bones" and not nssm:affectbones(self) ) then
					else
						--minetest.set_node(p, {name="air"})
						minetest.remove_node(pos1)
					end
				else
					if ((minetest.get_item_group(n, group)==1)
					and (minetest.get_item_group(n, "unbreakable") ~= 1)
					and (n ~= "bones:bones")
					and not (minetest.is_protected(pos1, "")) ) then
						--minetest.set_node(p, {name="air"})
						minetest.remove_node(pos1)
					end
				end

				pos1.y = pos1.y + 1
			end
			posp.y = s.y
			posp = vector.add(posp,per)
			--minetest.chat_send_all("pos3:"..minetest.pos_to_string(posp).." per.y= "..per.y)
		end
	end
end


function putting_ability(		--puts under the mob the block defined as 'p_block'
	self,		--the entity of the mob
	p_block, 	--definition of the block to use
	max_vel	--max velocity of the mob
	)
	--if math.random(1,nssm:virulence(self)) ~= 1 then return end

	local v = self.object:get_velocity()
	local dx = 0
	local dz = 0

	if (math.abs(v.x)>math.abs(v.z)) then
		if (v.x)>0 then
			dx = 1
		else
			dx = -1
		end
	else
		if (v.z)>0 then
			dz = 1
		else
			dz = -1
		end
	end

	local pos = self.object:get_pos()
	local pos1

	pos.y=pos.y - 1

	pos1 = {x = pos.x + dx, y = pos.y, z = pos.z + dz}

	local n = minetest.get_node(pos).name
	local n1 = minetest.get_node(pos1).name
	local oldmetainf = {
		minetest.get_meta(pos):to_table(),
		minetest.get_meta(pos1):to_table()
	}

	if n ~= p_block and not minetest.is_protected(pos, "")
	and (n == "bones:bones"
	and nssm:affectbones(self) )
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
			metai:set_string("nssm",n1)
		end
	end
end


function webber_ability(		--puts randomly around the block defined as w_block
	self,		--the entity of the mob
	w_block, 	--definition of the block to use
	radius		--max distance the block can be put
	)

	if (nssm:virulence(self) ~= 0)
	and (math.random(1, nssm:virulence(self)) ~= 1) then return end

	local pos = self.object:get_pos()

	if (math.random(1, 55) == 1) then

		local dx = math.random(1, radius)
		local dz = math.random(1, radius)
		local p = {x = pos.x + dx, y = pos.y - 1, z = pos.z + dz}
		local t = {x = pos.x + dx, y = pos.y, z = pos.z + dz}
		local n = minetest.get_node(p).name
		local k = minetest.get_node(t).name

		if ((n ~= "air")
		and(k == "air"))
		and not minetest.is_protected(t, "") then
			minetest.set_node(t, {name = w_block})
		end
	end
end


function midas_ability(		--ability to transform every blocks it touches in the m_block block
	self,		--the entity of the mob
	m_block,
	max_vel,	--max velocity of the mob
	mult, 		--multiplier of the dimensions of the area around that need the transformation
	height 		--height of the mob
	)
	--if math.random(1,nssm:virulence(self)) ~= 1 then return end

	local v = self.object:get_velocity()
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

				if minetest.get_item_group(n, "unbreakable") == 1
				or minetest.is_protected(p, "") or n=="air"
				or (n == "bones:bones" and not nssm:affectbones(self))
				or n==m_block then
				else
					minetest.set_node(p, {name = m_block})
				end
			end
		end
	end
end



--	NEW EXPLOSION FUNCTION

-- loss probabilities array (one in X will be lost)
local loss_prob = {}

loss_prob["default:cobble"] = 3
loss_prob["default:dirt"] = 4

local tnt_radius = tonumber(minetest.settings:get("tnt_radius") or 3)
local cid_data = {}

minetest.after(0, function()

	for name, def in pairs(minetest.registered_nodes) do
		cid_data[minetest.get_content_id(name)] = {
			name = name,
			drops = def.drops,
			flammable = def.groups.flammable,
			on_blast = def.on_blast,
		}
	end
end)


local function rand_pos(center, pos, radius)

	local def
	local reg_nodes = minetest.registered_nodes
	local i = 0

	repeat
		-- Give up and use the center if this takes too long
		if i > 4 then
			pos.x, pos.z = center.x, center.z
			break
		end

		pos.x = center.x + math.random(-radius, radius)
		pos.z = center.z + math.random(-radius, radius)

		def = reg_nodes[minetest.get_node(pos).name]

		i = i + 1

	until def and not def.walkable
end


local function add_effects(pos, radius, drops)

	minetest.add_particle({
		pos = pos,
		velocity = vector.new(),
		acceleration = vector.new(),
		expirationtime = 0.4,
		size = radius * 10,
		collisiondetection = false,
		vertical = false,
		texture = "tnt_boom.png",
	})

	minetest.add_particlespawner({
		amount = 64,
		time = 0.5,
		minpos = vector.subtract(pos, radius / 2),
		maxpos = vector.add(pos, radius / 2),
		minvel = {x = -10, y = -10, z = -10},
		maxvel = {x = 10, y = 10, z = 10},
		minacc = vector.new(),
		maxacc = vector.new(),
		minexptime = 1,
		maxexptime = 2.5,
		minsize = radius * 3,
		maxsize = radius * 5,
		texture = "tnt_smoke.png",
	})

	-- we just dropped some items. Look at the items entities and pick
	-- one of them to use as texture
	local texture = "tnt_blast.png" --fallback texture
	local most = 0

	for name, stack in pairs(drops) do

		local count = stack:get_count()

		if count > most then

			most = count

			local def = minetest.registered_nodes[name]

			if def and def.tiles and def.tiles[1] then
				texture = def.tiles[1]
			end
		end
	end

	minetest.add_particlespawner({
		amount = 64,
		time = 0.1,
		minpos = vector.subtract(pos, radius / 2),
		maxpos = vector.add(pos, radius / 2),
		minvel = {x = -3, y = 0, z = -3},
		maxvel = {x = 3, y = 5,  z = 3},
		minacc = {x = 0, y = -10, z = 0},
		maxacc = {x = 0, y = -10, z = 0},
		minexptime = 0.8,
		maxexptime = 2.0,
		minsize = radius * 0.66,
		maxsize = radius * 2,
		texture = texture,
		collisiondetection = true,
	})
end


local function eject_drops(drops, pos, radius)

	local drop_pos = vector.new(pos)

	for _, item in pairs(drops) do

		local count = math.min(item:get_count(), item:get_stack_max())

		while count > 0 do

			local take = math.max(1,math.min(radius * radius,
					count,
					item:get_stack_max()))

			rand_pos(pos, drop_pos, radius)

			local dropitem = ItemStack(item)

			dropitem:set_count(take)

			local obj = minetest.add_item(drop_pos, dropitem)

			if obj then
				obj:get_luaentity().collect = true
				obj:set_acceleration({x = 0, y = -10, z = 0})
				obj:set_velocity({x = math.random(-3, 3),
						y = math.random(0, 10),
						z = math.random(-3, 3)})
			end

			count = count - take
		end
	end
end


local function calc_velocity(pos1, pos2, old_vel, power)

	-- Avoid errors caused by a vector of zero length
	if vector.equals(pos1, pos2) then
		return old_vel
	end

	local vel = vector.direction(pos1, pos2)

	vel = vector.normalize(vel)
	vel = vector.multiply(vel, power)

	-- Divide by distance
	local dist = vector.distance(pos1, pos2)

	dist = math.max(dist, 1)
	vel = vector.divide(vel, dist)

	-- Add old velocity
	vel = vector.add(vel, old_vel)

	-- randomize it a bit
	vel = vector.add(vel, {
		x = math.random() - 0.5,
		y = math.random() - 0.5,
		z = math.random() - 0.5,
	})

	-- Limit to terminal velocity
	dist = vector.length(vel)

	if dist > 250 then
		vel = vector.divide(vel, dist / 250)
	end

	return vel
end


local function entity_physics(pos, radius, drops)

	local objs = minetest.get_objects_inside_radius(pos, radius)

	for _, obj in pairs(objs) do

		local obj_pos = obj:get_pos()
		local dist = math.max(1, vector.distance(pos, obj_pos))
		local damage = (4 / dist) * radius

		if obj:is_player() then
			-- currently the engine has no method to set
			-- player velocity. See #2960
			-- instead, we knock the player back 1.0 node, and slightly upwards
			local dir = vector.normalize(vector.subtract(obj_pos, pos))
			local moveoff = vector.multiply(dir, dist + 1.0)
			local newpos = vector.add(pos, moveoff)

			newpos = vector.add(newpos, {x = 0, y = 0.2, z = 0})

			obj:set_pos(newpos)

			obj:set_hp(obj:get_hp() - damage)
		else
			local do_damage = true
			local do_knockback = true
			local entity_drops = {}
			local luaobj = obj:get_luaentity()
			local objdef = minetest.registered_entities[luaobj.name]
			local name = luaobj.name

			if objdef and objdef.on_blast then

				if ((name == "nssm:pumpking")
				or (name == "nssm:morvalar0")
				or (name== "nssm:morvalar5")) then
					do_damage = false
					do_knockback = false
				else
					do_damage, do_knockback, entity_drops = objdef.on_blast(luaobj, damage)
				end
			end

			if do_knockback then

				local obj_vel = obj:get_velocity()

				obj:set_velocity(calc_velocity(pos, obj_pos,
						obj_vel, radius * 10))
			end

			if do_damage then

				if not obj:get_armor_groups().immortal then

					obj:punch(obj, 1.0, {
						full_punch_interval = 1.0,
						damage_groups = {fleshy = damage},
					}, nil)
				end
			end

			for _, item in pairs(entity_drops) do
				add_drop(drops, item)
			end
		end
	end
end


local function add_drop(drops, item)

	item = ItemStack(item)

	local name = item:get_name()

	if loss_prob[name] ~= nil and math.random(1, loss_prob[name]) == 1 then
		return
	end

	local drop = drops[name]

	if drop == nil then
		drops[name] = item
	else
		drop:set_count(drop:get_count() + item:get_count())
	end
end


local function destroy(drops, npos, cid, c_air, c_fire, on_blast_queue, ignore_protection, ignore_on_blast)

	if not ignore_protection and minetest.is_protected(npos, "") then
		return cid
	end

	local def = cid_data[cid]

	if not def then
		return c_air
	elseif not ignore_on_blast and def.on_blast then
		on_blast_queue[#on_blast_queue + 1] = {pos = vector.new(npos), on_blast = def.on_blast}
		return cid
	elseif def.flammable then
		return c_fire
	else
		local node_drops = minetest.get_node_drops(def.name, "")
		for _, item in pairs(node_drops) do
			add_drop(drops, item)
		end
		return c_air
	end
end


local function tnt_explode(pos, radius, ignore_protection, ignore_on_blast)

	pos = vector.round(pos)

	-- scan for adjacent TNT nodes first, and enlarge the explosion
	local vm1 = VoxelManip()
	local p1 = vector.subtract(pos, 2)
	local p2 = vector.add(pos, 2)
	local minp, maxp = vm1:read_from_map(p1, p2)
	local a = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
	local data = vm1:get_data()
	local count = 0
	local c_tnt
	local c_tnt_burning = minetest.get_content_id("tnt:tnt_burning")
	local c_tnt_boom = minetest.get_content_id("tnt:boom")
	local c_air = minetest.get_content_id("air")

	if minetest.registered_nodes["tnt:tnt"] then
		c_tnt = minetest.get_content_id("tnt:tnt")
	else
		c_tnt = tnt_burning
	end

	for z = pos.z - 2, pos.z + 2 do
	for y = pos.y - 2, pos.y + 2 do

		local vi = a:index(pos.x - 2, y, z)

		for x = pos.x - 2, pos.x + 2 do

			local cid = data[vi]

			if cid == c_tnt or cid == c_tnt_boom or cid == c_tnt_burning then
				count = count + 1
				data[vi] = c_air
			end

			vi = vi + 1
		end
	end
	end

	vm1:set_data(data)
	vm1:write_to_map()

	-- recalculate new radius
	radius = math.floor(radius * math.pow(count, 1/3))

	-- perform the explosion
	local vm = VoxelManip()
	local pr = PseudoRandom(os.time())

	p1 = vector.subtract(pos, radius)
	p2 = vector.add(pos, radius)
	minp, maxp = vm:read_from_map(p1, p2)
	a = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
	data = vm:get_data()

	local drops = {}
	local on_blast_queue = {}
	local c_fire = minetest.get_content_id("fire:basic_flame")

	for z = -radius, radius do
	for y = -radius, radius do

	local vi = a:index(pos.x + (-radius), pos.y + y, pos.z + z)

	for x = -radius, radius do

		local r = vector.length(vector.new(x, y, z))

		if (radius * radius) / (r * r) >= (pr:next(80, 125) / 100) then

			local cid = data[vi]
			local p = {x = pos.x + x, y = pos.y + y, z = pos.z + z}

			if cid ~= c_air then
				data[vi] = destroy(drops, p, cid, c_air, c_fire,
					on_blast_queue, ignore_protection,
					ignore_on_blast)
			end
		end

		vi = vi + 1
	end
	end
	end

	vm:set_data(data)
	vm:write_to_map()
	vm:update_map()
	vm:update_liquids()

	-- call nodeupdate for everything within 1.5x blast radius
	for y = -radius * 1.5, radius * 1.5 do
	for z = -radius * 1.5, radius * 1.5 do
	for x = -radius * 1.5, radius * 1.5 do

		local rad = {x = x, y = y, z = z}
		local s = vector.add(pos, rad)
		local r = vector.length(rad)

		if r / radius < 1.4 then
			--nodeupdate_single(s)
			core.check_single_for_falling(s)
		end
	end
	end
	end

	for _, queued_data in pairs(on_blast_queue) do

		local dist = math.max(1, vector.distance(queued_data.pos, pos))
		local intensity = (radius * radius) / (dist * dist)
		local node_drops = queued_data.on_blast(queued_data.pos, intensity)

		if node_drops then

			for _, item in pairs(node_drops) do
				add_drop(drops, item)
			end
		end
	end

	return drops, radius
end


function tnt_boom_nssm(pos, def)

	minetest.sound_play("tnt_explode", {pos = pos, gain = 1.5, max_hear_distance = 2*64})
	minetest.set_node(pos, {name = "tnt:boom"})

	local drops, radius = tnt_explode(pos, def.radius, def.ignore_protection,
			def.ignore_on_blast)

	-- append entity drops
	local damage_radius = (radius / def.radius) * def.damage_radius

	entity_physics(pos, damage_radius, drops)

	if not def.disable_drops then
		eject_drops(drops, pos, radius)
	end

	add_effects(pos, radius, drops)
end
