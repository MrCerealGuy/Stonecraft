-------------------------------------------------------------------------------
-- Animal Resources Mod by Sapier
--
--! @file weapons.lua
--! @brief definition of some weapons used by animals modpack
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @defgroup weapons Weapons
--! @brief weapon entitys examples used by animals modpack
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------
assert(weapons_spacer == nil)
local weapons_spacer = {} --unused to fix lua doxygen bug only

-------------------------------------------------------------------------------
-- name: do_area_damage(pos,immune,damage_groups,range)
--
--! @brief damage all objects within a certain range
--
--! @param pos cennter of damage area
--! @param immune object immune to damage
--! @param damage_groups list of damage groups to do damage to
--! @param range range around pos
-------------------------------------------------------------------------------
local function do_area_damage(pos,immune,damage_groups,range)
	--damage objects within inner blast radius
	assert(type(range) ~= "table")

	local objs = minetest.get_objects_inside_radius(pos, range)
	for k, obj in pairs(objs) do

		--don't do damage to issuer
		if obj ~= immune and obj ~= nil then

			--TODO as long as minetest still crashes without puncher use this workaround

			local worst_damage = 0
			if type(damage_groups) == "table" then
				for k,v in pairs(damage_groups) do
					if v > worst_damage then
						worst_damage = v
					end
				end
			elseif type(damage_groups) == "number" then
				worst_damage =  damage_groups
			else
				assert("invalid damage_groups" == "selected")
			end


			local current_hp = obj:get_hp()
			obj:set_hp(current_hp - worst_damage)

			--punch
			--obj:punch(nil, 1.0, {
			--	full_punch_interval=1.0,
			--	damage_groups = damage_groups,
			--}, nil)
		end
	end
end


-------------------------------------------------------------------------------
-- name: do_node_damage(pos,immune_list,range,chance)
--
--! @brief damage all nodes within a certain range
--
--! @param pos center of area
--! @param immune_list list of nodes immune to damage
--! @param range range to do damage
--! @param chance chance damage is done to a node
-------------------------------------------------------------------------------
local function do_node_damage(pos,immune_list,range,chance)
	--do node damage
	for i=pos.x-range, pos.x+range, 1 do
		for j=pos.y-range, pos.y+range, 1 do
			for k=pos.z-range,pos.z+range,1 do
				--TODO create a little bit more sophisticated blast resistance
				if math.random() < chance then
					local toremove = core.get_node({x=i,y=j,z=k})

					if toremove ~= nil then
						local immune = false

						if immune_list ~= nil then
							for i,v in ipairs(immune_list) do
								if (toremove.name == v) then
									immune = true
								end
							end
						end


						if immune ~= true then
							core.remove_node({x=i,y=j,z=k})
						end
					end
				end
			end
		end
	end
end

--! @class AR_FIREBALL_ENTITY
--! @ingroup weapons
--! @brief a fireball weapon entity
local AR_FIREBALL_ENTITY = {
	physical = false,
	textures = {"animal_resources_fireball.png"},
	collisionbox = {0,0,0,0,0,0},

	damage_range = 4,
	velocity = 3,
	gravity = -0.01,

	damage_outer = {
					fleshy=4,
					},
	damage_inner = {
					fleshy=8,
					},

	owner = 0,
	lifetime = 30,
	created = -1,
}


-------------------------------------------------------------------------------
-- name: AR_FIREBALL_ENTITY.on_activate = function(self, staticdata)
--
--! @brief onactivate callback for fireball
--! @memberof AR_FIREBALL_ENTITY
--! @private
--
--! @param self fireball itself
--! @param staticdata
-------------------------------------------------------------------------------
function AR_FIREBALL_ENTITY.on_activate(self,staticdata)
	self.created = os.clock()
end

-------------------------------------------------------------------------------
-- name: AR_FIREBALL_ENTITY.surfacefire = function(self, staticdata)
--
--! @brief place fire on surfaces around pos
--! @memberof AR_FIREBALL_ENTITY
--! @private
--
--! @param pos position to place fire around
--! @param range square around pos to set on fire
-------------------------------------------------------------------------------
function AR_FIREBALL_ENTITY.surfacefire(pos,range)

	if mobf_rtd ~= nil and mobf_rtd.fire_enabled then
		--start fire on any surface within inner damage range
		for i=pos.x-range/2, pos.x+range/2, 1 do
		for j=pos.y-range/2, pos.y+range/2, 1 do
		for k=pos.z-range/2, pos.z+range/2, 1 do

			local current = core.get_node({x=i,y=j,z=k})
			local ontop  = core.get_node({x=i,y=j+1,z=k})

			--print("put fire? " .. printpos({x=i,y=j,z=k}) .. " " .. current.name .. " " ..ontop.name)

			if (current.name ~= "air") and
				(current.name ~= "fire:basic_flame") and
				(ontop.name == "air") then
				core.set_node({x=i,y=j+1,z=k}, {name="fire:basic_flame"})
			end

		end
		end
		end
	else
		core.log("error","AMR: A fireball without fire mod??!? You're kidding!!")
	end
end

-------------------------------------------------------------------------------
-- name: AR_FIREBALL_ENTITY.on_step = function(self, dtime)
--
--! @brief onstep callback for fireball
--! @memberof AR_FIREBALL_ENTITY
--! @private
--
--! @param self fireball itself
--! @param dtime time since last callback
-------------------------------------------------------------------------------
function AR_FIREBALL_ENTITY.on_step(self, dtime)
	local pos = self.object:getpos()
	local node = core.get_node(pos)


	--detect hit
	local objs=core.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 1)

	local hit = false

	for k, obj in pairs(objs) do
		if obj:get_entity_name() ~= "animal_resources:fireball_entity" and
			obj ~= self.owner then
			hit=true
		end
	end


	if hit then
		--damage objects within inner blast radius
		do_area_damage(pos,self.owner,self.damage_outer,self.damage_range/4)

		--damage all objects within blast radius
		do_area_damage(pos,self.owner,self.damage_inner,self.damage_range/2)

		AR_FIREBALL_ENTITY.surfacefire(pos,self.damage_range)

		self.object:remove()
	end

	-- vanish when hitting a node
	if node.name ~= "air" then
		AR_FIREBALL_ENTITY.surfacefire(pos,self.damage_range)
		self.object:remove()
	end

	--remove after lifetime has passed
	if self.created > 0 and
		self.created + self.lifetime < os.clock() then
		self.object:remove()
	end
end

--! @class AR_PLASMABALL_ENTITY
--! @ingroup weapons
--! @brief a plasmaball weapon entity
local AR_PLASMABALL_ENTITY = {
	physical = false,
	textures = {"animal_resources_plasmaball.png"},
	lastpos={},
	collisionbox = {0,0,0,0,0,0},

	damage_range = 2,
	velocity = 4,
	gravity = -0.001,

	damage = {
			fleshy=4,
			},

	damage_pass = {
			fleshy=2,
			},

	owner = 0,
	lifetime = 30,
	created = -1,
}

-------------------------------------------------------------------------------
-- name: AR_PLASMABALL_ENTITY.on_activate = function(self, staticdata)
--
--! @brief onactivate callback for plasmaball
--! @memberof AR_PLASMABALL_ENTITY
--! @private
--
--! @param self fireball itself
--! @param staticdata
-------------------------------------------------------------------------------
function AR_PLASMABALL_ENTITY.on_activate(self,staticdata)
	self.created = os.clock()
end


-------------------------------------------------------------------------------
-- name: AR_PLASMABALL_ENTITY.on_step = function(self, dtime)
--
--! @brief onstep callback for plasmaball
--! @memberof AR_PLASMABALL_ENTITY
--! @private
--
--! @param self plasmaball itself
--! @param dtime time since last callback
-------------------------------------------------------------------------------
function AR_PLASMABALL_ENTITY.on_step(self, dtime)
	local pos = self.object:getpos()
	local node = core.get_node(pos)


	--detect hit
	local objs=core.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 1)

	local hit = false

	for k, obj in pairs(objs) do
		if obj:get_entity_name() ~= "animal_resources:plasmaball_entity" and
			obj ~= self.owner then
			hit=true
		end
	end

	--damage all objects not hit but at least passed
	do_area_damage(pos,self.owner,self.damage_pass,2)

	if hit then
		--damage objects within inner blast radius
		do_area_damage(pos,self.owner,self.damage,self.damage_range/4)

		--damage all objects within blast radius
		do_area_damage(pos,self.owner,self.damage,self.damage_range/2)
	end

	-- vanish when hitting a node
	if node.name ~= "air" or
		hit then

		--replace this loop by minetest.find_node_near?
		--do node damage
		for i=pos.x-1, pos.x+1, 1 do
			for j=pos.y-1, pos.y+1, 1 do
				for k=pos.z-1,pos.z+1,1 do
					--TODO create a little bit more sophisticated blast resistance
					if math.random() < 0.5 then
						local toremove = minetest.get_node({x=i,y=j,z=k})

						if toremove ~= nil and
							toremove.name ~= "default:stone" and
							toremove.name ~= "default:cobble" then

							core.remove_node({x=i,y=j,z=k})
						end
					end
				end
			end
		end

		self.object:remove()
	end

	--remove after lifetime has passed
	if self.created > 0 and
		self.created + self.lifetime < mobf_get_current_time() then
		self.object:remove()
	end
end

-- -----------------------------------------------------------------------------
-- Code Below is by far extent taken from throwing mod by PilzAdam
-- -----------------------------------------------------------------------------
--! @class AR_ARROW_ENTITY
--! @ingroup weapons
--! @brief a arrow entity
local AR_ARROW_ENTITY={
	physical = false,
	timer=0,
	visual = "wielditem",
	visual_size = {x=0.1, y=0.1},
	textures = {"animal_resources:arrow_box"},
	lastpos={},
	collisionbox = {0,0,0,0,0,0},

	velocity =6,
	damage_groups = {
					fleshy=3,
					daemon=1.5
					},
	gravity  =9.81,
}

-------------------------------------------------------------------------------
-- name: AR_ARROW_ENTITY.on_step = function(self, dtime)
--
--! @brief onstep callback for arrow
--! @memberof AR_ARROW_ENTITY
--! @private
--
--! @param self arrow itself
--! @param dtime time since last callback
-------------------------------------------------------------------------------
AR_ARROW_ENTITY.on_step = function(self, dtime)
	self.timer=self.timer+dtime
	local pos = self.object:getpos()
	local node = core.get_node(pos)

	if self.timer>0.2 then
		local objs = core.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil and
				obj ~= self.owner then
				if obj:get_luaentity().name ~= "animal_resources:arrow_entity" and
					obj:get_luaentity().name ~= "__builtin:item" then
					obj:punch(self.object, 1.0, {
						full_punch_interval=1.0,
						damage_groups = self.damage_groups,
					}, nil)
					self.object:remove()
				end
			else
				--punch a player
				obj:punch(self.object, 1.0, {
					full_punch_interval=1.0,
					damage_groups = self.damage_groups,
				}, nil)
				self.object:remove()
			end
		end
	end

	if self.lastpos.x~=nil then
		if node.name ~= "air" then
			core.add_item(self.lastpos, 'animal_resources:arrow')
			self.object:remove()
		end
	end
	self.lastpos={x=pos.x, y=pos.y, z=pos.z}
end

-------------------------------------------------------------------------------
-- name: ar_init_weapons = function(self, dtime)
--
--! @brief initialize weapons handled by mobf mod
--
-------------------------------------------------------------------------------
function ar_init_weapons()
	core.register_entity(":animal_resources:fireball_entity", AR_FIREBALL_ENTITY)
	core.register_entity(":animal_resources:plasmaball_entity", AR_PLASMABALL_ENTITY)
	core.register_entity(":animal_resources:arrow_entity", AR_ARROW_ENTITY)
end


-- moved due to doxygen problems
core.register_node("animal_resources:arrow_box", {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- Shaft
			{-6.5/17, -1.5/17, -1.5/17, 6.5/17, 1.5/17, 1.5/17},
			--Spitze
			{-4.5/17, 2.5/17, 2.5/17, -3.5/17, -2.5/17, -2.5/17},
			{-8.5/17, 0.5/17, 0.5/17, -6.5/17, -0.5/17, -0.5/17},
			--Federn
			{6.5/17, 1.5/17, 1.5/17, 7.5/17, 2.5/17, 2.5/17},
			{7.5/17, -2.5/17, 2.5/17, 6.5/17, -1.5/17, 1.5/17},
			{7.5/17, 2.5/17, -2.5/17, 6.5/17, 1.5/17, -1.5/17},
			{6.5/17, -1.5/17, -1.5/17, 7.5/17, -2.5/17, -2.5/17},

			{7.5/17, 2.5/17, 2.5/17, 8.5/17, 3.5/17, 3.5/17},
			{8.5/17, -3.5/17, 3.5/17, 7.5/17, -2.5/17, 2.5/17},
			{8.5/17, 3.5/17, -3.5/17, 7.5/17, 2.5/17, -2.5/17},
			{7.5/17, -2.5/17, -2.5/17, 8.5/17, -3.5/17, -3.5/17},
		}
	},
	tiles = {"animal_resources_arrow.png", "animal_resources_arrow.png",
			"animal_resources_arrow_back.png", "animal_resources_arrow_front.png",
			 "animal_resources_arrow_2.png", "animal_resources_arrow.png"},
	groups = {not_in_creative_inventory=1},
})

local mods = core.get_modnames()

for i,v in ipairs(mods) do
	if v == element then
		print("AR: throwing mod found!")
		core.register_alias("animal_resources:arrow", "throwing:arrow")
	end
end
