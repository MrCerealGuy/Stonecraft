--= Creatures MOB-Engine (cme) =--
-- Copyright (c) 2015-2016 BlockMen <blockmen2015@gmail.com>
--
-- register.lua
--
-- This software is provided 'as-is', without any express or implied warranty. In no
-- event will the authors be held liable for any damages arising from the use of
-- this software.
--
-- Permission is granted to anyone to use this software for any purpose, including
-- commercial applications, and to alter it and redistribute it freely, subject to the
-- following restrictions:
--
-- 1. The origin of this software must not be misrepresented; you must not
-- claim that you wrote the original software. If you use this software in a
-- product, an acknowledgment in the product documentation is required.
-- 2. Altered source versions must be plainly marked as such, and must not
-- be misrepresented as being the original software.
-- 3. This notice may not be removed or altered from any source distribution.
--

--- MOB Registration
--
--  @module register.lua


local translate_name = dofile(cmer.modpath .. "/misc_functions.lua")


local function translate_def(def)
	local new_def = {
		initial_properties = {
			physical = true,
			collisionbox = def.model.collisionbox or {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
			visual = "mesh",
			visual_size = def.model.scale or {x=1, y=1},
			mesh = def.model.mesh,
			textures = def.model.textures,
			stepheight = 0.6, -- ensure we get over slabs/stairs
			collide_with_objects = def.model.collide_with_objects or true,
			makes_footstep_sound = true,
			automatic_face_movement_dir = def.model.rotation or 0.0,
			backface_culling = def.model.backface_culling or false
		},

		nametag = cmer.nametags and def.nametag or nil,
		ownable = def.ownable,

		stats = def.stats,
		model = def.model,
		sounds = def.sounds,
		combat = def.combat,
		modes = {},
		drops = def.drops,
	}

	-- Tanslate modes to better accessable format
	for mn, def in pairs(def.modes) do
		local name = tostring(mn)
		if name ~= "update_time" then
			new_def.modes[name] = def
			--if name == "attack" then new_def.modes[name].chance = 0 end
		end
	end

	-- Check if the modes have correct sum
	local mode_chance_sum = cmer.sumChances(new_def.modes)
	if mode_chance_sum > 1 then
		throw_warning("Chance of modes too high for MOB: " .. def.name ..
				". Mode chances will be incorrect.")
	elseif mode_chance_sum < 1 then
		throw_warning("Chance of modes too low for MOB: " .. def.name ..
				". Filling up to correct mode chances.")
		new_def.modes["_empty"] = {chance = 1 - mode_chance_sum, duration = 0}
	end

	-- insert special mode "_run" which is used when in panic
	if def.stats.can_panic then
		if def.modes.walk then
			local new = table.copy(new_def.modes["walk"])
			new.chance = 0
			new.duration = 3
			new.moving_speed = new.moving_speed * 2
			if def.modes.panic and def.modes.panic.moving_speed then
				new.moving_speed = def.modes.panic.moving_speed
			end
			new.update_yaw = 0.7
			new_def.modes["_run"] = new
			local new_anim = def.model.animations.panic
			if not new_anim then
				new_anim = table.copy(def.model.animations.walk)
				new_anim.speed = new_anim.speed * 2
			end
			new_def.model.animations._run = new_anim
		end
	end

	if def.stats.can_jump and type(def.stats.can_jump) == "number" then
		if def.stats.can_jump > 0 then
			new_def.initial_properties.stepheight = def.stats.can_jump + 0.1
		end
	end

	if def.stats.sneaky or def.stats.can_fly then
		new_def.initial_properties.makes_footstep_sound = false
	end


	new_def.get_staticdata = function(self)
		local main_tab = cmer.get_staticdata(self)
		-- is own staticdata function defined? If so, merge results
		if def.get_staticdata then
			local data = def.get_staticdata(self)
			if data and type(data) == "table" then
				for s, w in pairs(data) do
					main_tab[s] = w
				end
			end
		end

		-- return data serialized
		return core.serialize(main_tab)
	end

	new_def.on_activate = function(self, staticdata, dtime_s)

		-- Add everything we need as basis for the engine
		self.mob_name = def.name
		self.hp = def.stats.hp
		self.hostile = def.stats.hostile
		self.mode = ""
		self.stunned = false -- if knocked back or hit do nothing else

		if def.stats.has_kockback ~= nil then
			cmer.log("warning",
				def.name
				.. ": \"def.stats.has_kockback\" is deprecated, please use \"def.stats.has_knockback\"")
		end

		self.has_knockback = def.stats.has_knockback or def.stats.has_kockback -- backward compat
		self.has_falldamage = def.stats.has_falldamage
		self.can_swim = def.stats.can_swim
		self.can_fly = def.stats.can_fly
		self.can_burn = def.stats.can_burn
		self.can_panic = def.stats.can_panic == true and def.modes.walk ~= nil
		--self.is_tamed = nil
		--self.target = nil
		self.dir = {x = 0, z = 0}

		--self.last_pos = nil (was nullVec)
		--self.last_node = nil
		--self.last_llvl = 0
		self.fall_dist = 0
		self.air_cnt = 0


		-- Timers
		self.lifetimer = 0
		self.modetimer = math.random() -- 0
		self.soundtimer = math.random()
		self.nodetimer = 2 -- ensure we get the first step
		self.yawtimer = math.random() * 2 -- 0
		self.followtimer = 0
		if self.can_swim then
			self.swimtimer = 2 -- ensure we get the first step
			-- self.in_water = nil
		end
		if self.hostile then
			self.attacktimer = 0
		end
		if self.hostile or def.modes.follow then
			self.searchtimer = 0
		end
		if self.can_burn or not def.stats.can_swim or self.has_falldamage then
			self.env_damage = true
			self.envtimer = 0
		end

		-- Other things

		if staticdata then
			local tab = core.deserialize(staticdata)
			if tab and type(tab) == "table" then
				for s, w in pairs(tab) do
					self[tostring(s)] = w
				end
			end
		end

		-- check we got a valid mode
		if not new_def.modes[self.mode] or (new_def.modes[self.mode].chance or 0) <= 0 then
			self.mode = "idle"
		end

		if not self.can_fly then
			if not self.in_water then
				self.object:set_acceleration({x = 0, y = -15, z = 0})
			end
		end

		-- check if falling and set velocity only 0 when not falling
		if self.fall_dist == 0 then
			self.object:set_velocity(nullVec)
		end

		self.object:set_hp(self.hp)

		if not cmer.enable_damage then
			self.hostile = false
		end

		-- immortal is needed to disable clientside smokepuff
		self.object:set_armor_groups({fleshy=100, immortal=1})

		if self.nametag then
			local nt_attrib = self.object:get_nametag_attributes()
			if self.hostile then
				nt_attrib.color = {a=255, r=255, g=0, b=0}
			else
				nt_attrib.color = {a=255, r=0, g=255, b=0}
			end

			self.object:set_nametag_attributes(nt_attrib)
		end

		-- call custom on_activate if defined
		if def.on_activate then
			def.on_activate(self, staticdata, dtime_s)
		end
	end

	new_def.on_punch = function(self, puncher, tflp, tc, dir, damage)
		if def.on_punch and def.on_punch(self, puncher, tflp, tc, dir, damage) == true then
			return
		end

		cmer.on_punch(self, puncher, tflp, tc, dir, damage)
	end

	new_def.on_death = function(self, killer)
		if def.on_death and def.on_death(self, killer) == true then
			return
		end

		cmer.on_death(self, killer)
	end

	new_def.on_rightclick = function(self, clicker)
		if def.on_rightclick and def.on_rightclick(self, clicker) == true then
			return
		end

		cmer.on_rightclick(self, clicker)
	end

	new_def.on_step = function(self, dtime)
		if def.on_step and def.on_step(self, dtime) == true then
			return
		end

		cmer.on_step(self, dtime)
	end

	return new_def
end


function cmer.register_mob(def) -- returns true if sucessfull
	if not def or not def.name then
		throw_error("Can't register mob. No name or Definition given.")
		return false
	end

	local mob_def = translate_def(def)

	core.register_entity(def.name, mob_def)

	-- register spawn
	if def.spawning and not (def.stats.hostile and not cmer.allow_hostile) then
		local spawn_def = def.spawning
		spawn_def.mob_name = def.name
		spawn_def.mob_size = def.model.collisionbox
		if cmer.register_spawn(spawn_def) ~= true then
			throw_error("Couldn't register spawning for '" .. translate_name(def.name) .. "'")
		end

		if spawn_def.spawner then
			local spawner_def = def.spawning.spawner
			spawner_def.mob_name = def.name
			spawner_def.range = spawner_def.range or 4
			spawner_def.number = spawner_def.number or 6
			spawner_def.model = def.model
			cmer.register_spawner(spawner_def)
		end
	end

	return true
end


local function inRange(min_max, value)
	if not value or not min_max or not min_max.min or not min_max.max then
		return false
	end
	if (value >= min_max.min and value <= min_max.max) then
		return true
	end
	return false
end

local function checkSpace(pos, height)
	for i = 0, height do
		local n = core.get_node_or_nil({x = pos.x, y = pos.y + i, z = pos.z})
		if not n or n.name ~= "air" then
			return false
		end
	end
	return true
end

local time_taker = 0
local function step(tick)
	core.after(tick, step, tick)
	time_taker = time_taker + tick
end
step(0.5)

local function stopABMFlood()
	if time_taker == 0 then
		return true
	end
	time_taker = 0
end

local function groupSpawn(pos, mob, group, nodes, range, max_loops)
	local cnt = 0
	local cnt2 = 0

	local nodes = core.find_nodes_in_area({x = pos.x - range, y = pos.y - range, z = pos.z - range},
		{x = pos.x + range, y = pos.y, z = pos.z + range}, nodes)
	local number = #nodes - 1
	if max_loops and type(max_loops) == "number" then
		number = max_loops
	end
	while cnt < group and cnt2 < number do
		cnt2 = cnt2 + 1
		local p = nodes[math.random(1, number)]
		p.y = p.y + 1
		if checkSpace(p, mob.size) == true then
			cnt = cnt + 1
			if not core.add_entity(p, mob.name) then
				cmer.log("error", "could not spawn entity: " .. tostring(mob.name))
			elseif cmer.debug then
				print("Spawned entity: " .. tostring(mob.name) .. " number " .. tostring(cnt))
			end
		end
	end
	if cnt < group then
		return false
	end

	return true
end

function cmer.register_spawn(spawn_def)
	if not spawn_def or not spawn_def.abm_nodes then
		throw_error("No valid definition for given.")
		return false
	end

	if not spawn_def.abm_nodes.neighbors then
		spawn_def.abm_nodes.neighbors = {}
	end
	if #spawn_def.abm_nodes.neighbors == 0 then
		-- only add "air" if neighbors empty
		table.insert(spawn_def.abm_nodes.neighbors, "air")
	end

	local mob_name = translate_name(spawn_def.mob_name)

	if cmer.debug then
		print("\nregistering spawn for: " .. tostring(mob_name))
	end

	core.register_abm({
		nodenames = spawn_def.abm_nodes.spawn_on,
		neighbors = spawn_def.abm_nodes.neighbors,
		interval = spawn_def.abm_interval or 44,
		chance = spawn_def.abm_chance or 7000,
		catch_up = false,
		action = function(pos, node, active_object_count, active_object_count_wider)
			-- prevent abm-"feature"
			if stopABMFlood() == true then
				return
			end

			if cmer.debug then
				print("ABM reached: " .. tostring(mob_name))
			end

			-- time check
			local tod = core.get_timeofday() * 24000
			if spawn_def.time_range then
				local wanted_res = false
				local range = table.copy(spawn_def.time_range)
				if range.min > range.max and range.min <= tod then
					wanted_res = true
				end
				if inRange(range, tod) == wanted_res then
					return
				end
			end

			-- position check
			if spawn_def.height_limit and not inRange(spawn_def.height_limit, pos.y) then
				return
			end

			-- light check
			pos.y = pos.y + 1
			local llvl = core.get_node_light(pos)
			if spawn_def.light and not inRange(spawn_def.light, llvl) then
				return
			end

			-- creature count check
			local max
			if active_object_count_wider > (spawn_def.max_number or 1) then
				local mates_num = #cmer.findTarget(nil, pos, 16, "mate", mob_name, true)
				if not spawn_def.max_number or (mates_num or 0) >= spawn_def.max_number then
					return
				else
					max = spawn_def.max_number - mates_num
				end
			end

			-- ok everything seems fine, spawn creature
			local height_min = (spawn_def.mob_size[5] or 2) - (spawn_def.mob_size[2] or 0)
			height_min = math.ceil(height_min)

			local number = 0
			if type(spawn_def.number) == "table" then
				number = math.random(spawn_def.number.min, spawn_def.number.max)
			else
				number = spawn_def.number or 1
			end

			if max and number > max then
				number = max
			end

			if number > 1 then
				groupSpawn(pos, {name=mob_name, size=height_min}, number, spawn_def.abm_nodes.spawn_on, 5)
			else
			-- space check
				if not checkSpace(pos, height_min) then
					return
				end
				if not core.add_entity(pos, mob_name) then
					cmer.log("error", "could not spawn entity: " .. tostring(mob_name))
				elseif cmer.debug then
					print("Spawned entity: " .. tostring(mob_name))
				end
			end
		end,
	})

	return true
end


local function makeSpawnerEntiy(mob_name, model)
	local t_name = translate_name(mob_name)

	core.register_entity(mob_name .. "_spawner_dummy", {
		initial_properties = {
			hp_max = 1,
			physical = false,
			collisionbox = nullVec,
			visual = "mesh",
			visual_size = {x = 0.42, y = 0.42},
			mesh = model.mesh,
			textures = model.textures,
			collide_with_objects = false,
			makes_footstep_sound = false
		},
		automatic_rotate = math.pi * -2.9,
		mob_name = "_" .. t_name .. "_dummy",

		on_activate = function(self)
			self.timer = 0
		  self.object:set_velocity(nullVec)
		  self.object:set_acceleration(nullVec)
		  self.object:set_armor_groups({immortal = 1})
			--self.object:set_bone_position("Root", nullVec, {x=45,y=0,z=0})
	   end,

		 on_step = function(self, dtime)
			 self.timer = self.timer + dtime
			 if self.timer > 30 then
				 self.timer = 0
				 local n = core.get_node_or_nil(self.object:get_pos())
				 if n and n.name and n.name ~= t_name .. "_spawner" then
					 self.object:remove()
				 end
			 end
		 end
		})
end

local function spawnerSpawn(pos, spawner_def)
	local mob_name = translate_name(spawner_def.mob_name)

	local mates = cmer.findTarget(nil, pos, spawner_def.range, "mate", mob_name, true) or {}
	if #mates >= spawner_def.number then
		return false
	end
	local number_max = spawner_def.number - #mates

	local rh = math.floor(spawner_def.range/2)
	local area = {
		min = {x = pos.x - rh, y=pos.y - rh, z = pos.z - rh},
		max = {x = pos.x + rh, y=pos.y + rh - spawner_def.height - 1, z = pos.z + rh}
	}

	local height = area.max.y - area.min.y
	local cnt = 0
	for i = 0, height do
		if cnt >= number_max then
			break
		end
		local p = {x = math.random(area.min.x, area.max.x), y = area.min.y + i, z = math.random(area.min.z, area.max.z)}
		local n = core.get_node_or_nil(p)
		if n and n.name then
			local walkable = core.registered_nodes[n.name].walkable or false
			p.y = p.y + 1
			if walkable and checkSpace(p, spawner_def.height) == true then
				local llvl = core.get_node_light(p)
				if not spawner_def.light or (spawner_def.light and inRange(spawner_def.light, llvl)) then
					cnt = cnt + 1
					core.add_entity(p, mob_name)
				end
			end
		end
	end
end


local spawner_timers = {}
function cmer.register_spawner(spawner_def)
	if not spawner_def or not spawner_def.mob_name or not spawner_def.model then
		throw_error("Can't register Spawner. Not enough parameters given.")
		return false
	end

	makeSpawnerEntiy(spawner_def.mob_name, spawner_def.model)

	local mob_name = translate_name(spawner_def.mob_name)

	core.register_node(spawner_def.mob_name .. "_spawner", {
		description = spawner_def.description or mob_name .. " spawner",
		paramtype = "light",
		tiles = {"creatures_spawner.png"},
		is_ground_content = true,
		drawtype = "glasslike",
		groups = {cracky = 1, level = 1},
		drop = "",
		on_construct = function(pos)
				pos.y = pos.y - 0.3
				core.add_entity(pos, mob_name .. "_spawner_dummy")
		end,
		on_destruct = function(pos)
			for _,obj in ipairs(core.get_objects_inside_radius(pos, 1)) do
				local entity = obj:get_luaentity()
				if obj and entity and entity.mob_name == "_" .. mob_name .. "_dummy" then
					obj:remove()
				end
			end
		end
	})

	local box = spawner_def.model.collisionbox
	local height = (box[5] or 2) - (box[2] or 0)
	spawner_def.height = height

	if spawner_def.player_range and type(spawner_def.player_range) == "number" then
		core.register_abm({
			nodenames = {mob_name .. "_spawner"},
		  interval = 2,
		  chance = 1,
		  catch_up = false,
		  action = function(pos)
				local id = core.pos_to_string(pos)
				if not spawner_timers[id] then
					spawner_timers[id] = os.time()
				end
				local time_from_last_call = os.time() - spawner_timers[id]
				local mobs,player_near = cmer.findTarget(nil, pos, spawner_def.player_range, "player", nil, true, true)
				if player_near == true and time_from_last_call > 10 and (math.random(1, 5) == 1 or (time_from_last_call ) > 27) then
					spawner_timers[id] = os.time()

					spawnerSpawn(pos, spawner_def)
				end
			end
		})
	else
		core.register_abm({
			nodenames = {mob_name .. "_spawner"},
		  interval = 10,
		  chance = 3,
		  action = function(pos)

				spawnerSpawn(pos, spawner_def)
			end
		})
	end

	return true
end

local function register_alias_entity(old_mob, new_mob)
	core.register_entity(":" .. old_mob, {
		initial_properties = {
			physical = false,
			collisionbox = {0, 0, 0, 0, 0, 0},
			visual = "sprite",
			visual_size = {x = 0, y = 0},
			textures = {"creatures_spawner.png"}, -- dummy texture
			makes_footstep_sound = false
		},

		on_activate = function(self)
			local pos = self.object:get_pos()
			if pos then
				core.add_entity(pos, new_mob)
			end
			if self.object then
				self.object:remove()
			end
		end,
	})
end


function cmer.register_alias(old_mob, new_mob)
	local def = core.registered_entities[new_mob]
	if not def then
		throw_error("No valid definition for given.")
		return false
	end

	register_alias_entity(old_mob, new_mob)

	if core.registered_nodes[new_mob .. "_spawner"] then
		register_alias_entity(old_mob .. "_spawner_dummy", new_mob .. "_spawner_dummy")
		core.register_alias(old_mob .. "_spawner", new_mob .. "_spawner")
	end

	return true
end


--- Registers a new mob.
--
--  @function cmer.register_mob
--  @tparam CreatureDef def Creature definition table.
--  @treturn bool `true` if successfule.

--- Registers an alias for other mob, e.g. from other mods or removed ones.
--
--  @function cmer.register_alias
--  @tparam string old_mob Name of mob to be replaced. E.g. "creatures:oerrki"
--  @tparam string new_mob Name of mob that will replace instances old one. E.g. "creatures:oerkki"
--  @treturn bool `true` if successful.


--- Creature definition table.
--
--  @table CreatureDef
--  @tfield string name E.g. "creatures:sheep".
--  @tfield[opt] string nametag String to be displayed in entity's nametag.
--  @tfield[opt] bool ownable Flag for defining if entity is ownable by players (default: *false*).
--  @tfield StatsDef stats Stats definitions.
--  @tfield ModeDef modes Entity bahavior defintions.
--  @tfield ModelDef model Model definitions.
--  @tfield[opt] table sounds Table of `SoundDef`. Additionally, `play_default_hit` can be set to `false` here to disable default "hit" sound.
--  @tfield[opt] table drops List of item `DropDef`. Can also be a function. receives "self" reference.
--  @tfield[opt] CombatDef combat Specifies behavior of hostile mobs in "attack" mode.
--  @tfield[opt] SpawnDef spawning Defines spawning in world.
--  @tfield callback on_activate see: `CreatureDef.on_activate`
--  @tfield callback on_step see: `CreatureDef.on_step`
--  @tfield callback on_punch see: `CreatureDef.on_punch`
--  @tfield callback on_rightclick see: `CreatureDef.on_rightclick`
--  @tfield callback on_death see: `CreatureDef.on_death`
--  @tfield callback get_staticdata see: `CreatureDef.get_staticdata`


--- Definition Tables
--
--  @section defs

--- Stats definition table.
--
--  @table StatsDef
--  @tparam int hp Full health level (1 HP = 1/2 player heart).
--  @tparam[opt] bool hostile Is mob hostile (required for mode "attack") (default: `false`).
--  @tparam[opt] int lifetime After which time mob despawns, in seconds.
--  @tparam[opt] bool dies_when_tamed Stop despawn when tamed (default: `false`).
--  @tparam[opt] int can_jump Height in nodes (default: 0).
--  @tparam[opt] bool can_swim Can mob swim or will it drown (default: `false`).
--  @tparam[opt] bool can_fly Allows to fly (requires mode "fly") and disable step sounds (default: `false`).
--  @tparam[opt] bool can_burn Takes damage of lava (default: `false`).
--  @tparam[opt] bool can_panic Runs fast around when hit (requires mode "walk") (default: `false`).
--  @tparam[opt] bool has_falldamage Deals damage if falling more than 3 blocks (default: `false`).
--  @tparam[opt] bool has_knockback Get knocked back when hit (default: `false`).
--  @tparam[opt] bool sneaky Disables step sounds if `true` (default: `false`).
--  @tparam[opt] table light Which light level will burn creature (requires can_burn = true).
--
--  Example:
--
--    light = {min=10, max=15}

--- Modes definition table.
--
--  Entity behavior definition. Behavior types are ***idle***, ***walk***, ***attack***, ***follow***, ***eat***, ***death***, & ***panic***. The sum of all modes must be 1.0.
--
--  Example:
--
--    modes = {
--      idle = {chance=0.3,},
--      walk = {chance=0.7, moving_speed=1,},
--    }
--
--  @table ModeDef
--  @tfield float chance Number between 0.0 and 1.0 (***NOTE:** sum of all modes MUST be 1.0*). If chance is 0 then mode is not chosen automatically.
--  @tfield int duration Time in seconds until the next mode is chosen (depending on chance).
--  @tfield[opt] int moving_speed Moving speed (walking/flying/swimming).
--  @tfield[opt] int update_yaw Timer in seconds until the looking dir is changed. If moving_speed > 0 then the moving direction is also changed.
--  @tfield int radius *(follow & eat modes only)* Search distance in blocks/nodes for player.
--  @tfield int timer *(follow & eat modes only)* Time in seconds between each check for player.
--  @tfield table items *(follow & eat modes only)* Table of items to make mob follow in format {&lt;Itemname&gt;, &lt;Itemname&gt;}; e.g. {"farming:wheat"}.
--  @tfield table nodes *(eat mode only)* Eatable nodes in format {&lt;Itemname&gt;, &lt;Itemname&gt;}; e.g. {"default:dirt\_with\_grass"}.

--- Model definition table.
--
--  @table ModelDef
--  @tfield string mesh Mesh name (see Minetest Documentation for supported filetypes).
--  @tfield table textures Table of textures (see Minetest Documentation).
--  @tfield[opt] NodeBox collisionbox Defines mesh collision box (see Minetest Documentation).
--  @tfield[opt] table scale Sets visual scale (default: {x=1, y=1}).
--  @tfield[opt] float rotation Sets rotation offset when moving (default: 0.0).
--  @tfield[opt] bool backface_culling Set to `true` to enable backface culling.
--  @tfield[opt] table animations Table of `AnimationDef` used if defined.
--  @tfield[opt] bool collide_with_objects Collide with other objects (default: `true`).

--- Animations defiintion table.
--
--  Animations coincide with modes. E.g. ***idle***, ***walk***, etc.
--
--  Example:
--
--    animations = {
--      idle = {start=25, stop=75, speed=15,},
--      walk = {start=75, stop=100, speed=15,},
--    }
--
--  @table AnimationDef
--  @tfield int start Start frame.
--  @tfield int stop End frame.
--  @tfield int speed Animation speed.
--  @tfield[opt] bool loop If `false`, animation if just played once (default: `true`).
--  @tfield[opt] int duration *(death mode only)* Sets time the animation needs until mob is removed.

--- Sounds definition table.
--
--  Sounds can be defined for these actions: ***on_damage***, ***on_death***, ***swim***, & ***random***.
--
--  ***random*** is a table of `SoundDef` that will be played randomly during the modes for which they are set.
--
--  Example:
--
--    sounds = {
--      on_damage = {name="creatures_horse_neigh_02", gain=1.0},
--      on_death = {name="creatures_horse_snort_02", gain=1.0},
--      random = {
--        idle = {name="creatures_horse_snort_01", gain=1.0},
--        follow = {name="creatures_horse_neigh_01", gain=1.0, time_min=10},
--      },
--    }
--
--  @table SoundsDef
--  @tparam[opt] SoundDef on_damage Sound played when entity is hit.
--  @tparam[opt] SoundDef on_death Sound played when entity dies.
--  @tparam[opt] SoundDef swim Sound played while entity is swimming.
--  @tparam[opt] table Random Sounds that will play randomly during specified modes. E.g. ***idle***, ***walk***, etc.

--- Sound definition.
--
--  @table SoundDef
--  @tfield string name Sound file name without file type extension (e.g. "my_sound", not "my_sound.ogg") (see Minetest documentation).
--  @tfield float gain Sound gain (see Minetest documentation).
--  @tfield[opt] int distance Distance in blocks/nodes at which sound can be heard.
--  @tfield[opt] int time_min *(random mode only)* Minimum time in seconds between sounds.
--  @tfield[opt] int time_max *(random mode only)* Maximum time in seconds between sounds.

--- Item drops definition table.
--
--  Example:
--
--    drops = {
--      {"default:wood"}, -- 1 item with 100% chance
--      {"default:wool", 1, chance=0.3}, -- 1 item with 30% chance
--      {"default:stick", {min=2, max=3}, chance=0.2}, -- between 2-3 items with 20% chance
--    }
--
--  @table DropDef

--- Combat definition table.
--
--  @table CombatDef
--  @tfield int attack_damage How much damage is dealt on each hit.
--  @tfield[opt] float attack_speed Time in seconds between hits (default: 1.0).
--  @tfield float attack_radius Distance in blocks mob can reach to hit.
--  @tfield bool search_enemy `true` to search enemies to attack.
--  @tfield[opt] int search_timer Time in seconds to search an enemy (only if none found yet) (default: 2).
--  @tfield int search_radius Radius in blocks within enemies are searched.
--  @tfield string search_type What enemy is being searched (see types at `cmer.findTarget`).

--- Spawning definition table.
--
--  @table SpawnDef
--  @tfield ABMNodesDef abm_nodes On what nodes mob can spawn.
--  @tfield[opt] int abm_interval Time in seconds until Minetest tries to find a node with set specs (default: 44).
--  @tfield[opt] int abm_chance Chance is 1/&lt;chance&gt; (default: 7000).
--  @tfield int max_number Maximum mobs of this kind per mapblock (16x16x16).
--  @tfield int number How many mobs are spawned if found suitable spawn position. Can be `int` or `table`: number = {min=&lt;value&gt;, max=&lt;value&gt;}
--  @tfield[opt] table time_range Time range in time of day format (0-24000) (table with *min* & *max* values).
--  @tfield[opt] table light Min and max lightvalue at spawn position (table with *min* & *max* values).
--  @tfield[opt] table height_limit Min and max height (world Y coordinate) (table with *min* & *max* values).
--  @tfield[opt] SpawnerDef spawner Is set a spawner_node is added to creative inventory.

--- ABM nodes definition table.
--
--  @table ABMNodesDef
--  @tfield[opt] table spawn_on List of nodes on which the mob can spawn.
--  @tfield[opt] table neighbors List of nodes that should be neighbors where mob can spawn. Can be nil or table as above (default: {"air"}).

--- Spawner definition table.
--
--  @table SpawnerDef
--  @tfield int range Defines an area (in blocks/nodes) within mobs are spawned.
--  @tfield int number Maxmimum number of mobs spawned in area defined via range.
--  @tfield[opt] string description Item description as string.
--  @tfield[opt] table light Min and max lightvalue at spawn position.


--- Callbacks
--
--  @section callbacks

--- Called when mob (re-)activated.
--
--  Note: staticdata is deserialized by MOB-Engine (including custom values).
--
--  @function CreatureDef.on_activate
--  @param self
--  @tparam string staticdata Formatted string data to be deserialized.
--  @tparam int dtime_s The time passed since the object was unloaded, which can be used for updating the entity state.

--- Called each server step, after movement and collision processing.
--
--  @function CreatureDef.on_step
--  @param self
--  @tparam float dtime Usually 0.1 seconds, as per the `dedicated_server_step` setting in `minetest.conf`.
--  @treturn bool Prevents default action when returns `true`.

--- Called when mob is punched.
--
--  @function CreatureDef.on_punch
--  @param self
--  @tparam ObjectRef puncher
--  @param time_from_last_punch Meant for disallowing spamming of clicks.
--  @tparam table tool_capabilities See: http://minetest.gitlab.io/minetest/tools.html
--  @param dir Unit vector of direction of punch. Always defined. Points from the puncher to the punched.
--  @tparam int damage Damage that will be done to entity.
--  @treturn bool Prevents default action when returns `true`.

--- Called when mob is right-clicked.
--
--  @function CreatureDef.on_rightclick
--  @param self
--  @tparam ObjectRef clicker Entity that did the punching.
--  @treturn bool Prevents default action when returns `true`.

--- Called when mob dies.
--
--  @function CreatureDef.on_death
--  @param self
--  @tparam ObjectRef killer (can be `nil`)

--- Must return a table to save mob data (serialization is done by MOB-Engine).
--
--  e.g:
--
--    return {
--      custom_mob_data = self.my_value,
--    }
--
--  @function CreatureDef.get_staticdata
--  @param self
--  @treturn table
