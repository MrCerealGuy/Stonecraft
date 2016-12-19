-------------------------------------------------------------------------------
-- advanced spawning mod
--
--@license WTFP
--@copyright Sapier
--@author Sapier
--@date 2013-12-05
--
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] seed_step
-- @param self spawner entity
-- @param dtime time since last call
--------------------------------------------------------------------------------
function adv_spawning.seed_step(self,dtime)
	if not self.activated then
		local starttime = adv_spawning.gettime()
		adv_spawning.seed_activate(self)
		adv_spawning.check_time(starttime, "Initializing spawner on_step took way too much time")
		return
	end

	self.mydtime = self.mydtime + dtime

	if (self.mydtime < 1/adv_spawning.max_spawning_frequency_hz) then
		return
	end
	
	--check if we did finish initialization of our spawner list by now
	if not adv_spawning.seed_scan_for_applyable_spawners(self) then
		return
	end
	
	if adv_spawning.quota_enter() then
		self.pending_spawners = {}

		adv_spawning.seed_countdown_spawners(self,self.mydtime)
		
		self.mydtime = 0

		--check quota again
		adv_spawning.quota_leave()
		if not adv_spawning.quota_enter() then
			return
		end

		local per_step_count = 0
		local key = nil
		
		local starttime = adv_spawning.gettime()

		while #self.pending_spawners > 0 and
			per_step_count < adv_spawning.max_spawns_per_spawner and
			(not adv_spawning.time_over(10)) do
			

			local rand_spawner = math.random(1,#self.pending_spawners)
			key = self.pending_spawners[rand_spawner]

			local tries = 1

			if adv_spawning.spawner_definitions[key].spawns_per_interval ~= nil then
				tries = adv_spawning.spawner_definitions[key].spawns_per_interval
			end

			while tries > 0 do
				local successfull, permanent_error, reason =
					adv_spawning.handlespawner(key,self.object:getpos())

				if successfull then
					self.spawning_data[key] =
						adv_spawning.spawner_definitions[key].spawn_interval
					self.spawn_fail_reasons[key] = "successfull spawned"
				else
					self.spawning_data[key] =
						adv_spawning.spawner_definitions[key].spawn_interval/4
					self.spawn_fail_reasons[key] = reason
				end

				--check quota again
				if not adv_spawning.quota_leave() then
					adv_spawning.dbg_log(2, "spawner " .. key .. " did use way too much time")
				end
				if not adv_spawning.quota_enter() then
					return
				end

				tries = tries -1
			end
			
			
			starttime = adv_spawning.check_time(starttime, key .. " for " .. 
				adv_spawning.spawner_definitions[key].spawnee .. " did use way too much time")
			
			table.remove(self.pending_spawners,rand_spawner)
			per_step_count = per_step_count +1
		end

--		if (#self.pending_spawners > 0) then
--			adv_spawning.dbg_log(3, "Handled " .. per_step_count .. " spawners, spawners left: " .. #self.pending_spawners)
--		end
		if not adv_spawning.quota_leave() then
			adv_spawning.dbg_log(2, "spawner " .. key .. " did use way too much time")
		end
	end
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] seed_activate
-- @param self spawner entity
--------------------------------------------------------------------------------
function adv_spawning.seed_activate(self)
	if adv_spawning.quota_enter() then

		if adv_spawning.seed_check_for_collision(self) then
			adv_spawning.quota_leave()
			return
		end

		if self.serialized_data ~= nil then
			self.spawning_data = minetest.deserialize(self.serialized_data)
		end

		if self.spawning_data == nil then
			self.spawning_data = {}
		end

		adv_spawning.seed_validate_spawndata(self)
		
		self.pending_spawners = {}
		self.spawn_fail_reasons = {}
		self.initialized_spawners = 0
		self.activated = true
		
		-- fix unaligned own pos
		local pos = self.object:getpos()
		
		pos.x = math.floor(pos.x + 0.5)
		pos.y = math.floor(pos.y + 0.5)
		pos.z = math.floor(pos.z + 0.5)
		
		self.object:setpos(pos)

		if not adv_spawning.quota_leave() then
			adv_spawning.dbg_log(2, "on activate  " .. self.name .. " did use way too much time")
		end
	end
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] on_rightclick
-- @param self spawner entity
-- @param clicker (unused)
--------------------------------------------------------------------------------
function adv_spawning.on_rightclick(self, clicker)
	if adv_spawning.debug then
		print("ADV_SPAWNING: time till next spawn: " .. self.mydtime)
		print("ADV_SPAWNING: pending spawners: " .. #self.pending_spawners)
		print("ADV_SPAWNING: Spawner may spawn " .. adv_spawning.table_count(self.spawning_data) .. " mobs:")
		local index = 1
		for key,value in pairs(self.spawning_data) do
			local reason = "unknown"
			
			if self.spawn_fail_reasons[key] then
			  reason = self.spawn_fail_reasons[key]
			end  
			
			print(string.format("%3d:",index) .. string.format("%30s ",key) .. string.format("%3d s (", value) .. reason .. ")")
			index = index +1
		end
	end
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] seed_initialize
--------------------------------------------------------------------------------
function adv_spawning.seed_initialize()

	local spawner_texture = "adv_spawning_invisible.png^[makealpha:128,0,0^[makealpha:128,128,0"
	local spawner_collisionbox = { 0.0,0.0,0.0,0.0,0.0,0.0}

	if adv_spawning.debug then
		spawner_texture = "adv_spawning_spawner.png"
		spawner_collisionbox = { -0.5,-0.5,-0.5,0.5,0.5,0.5 }
	end

	minetest.register_entity("adv_spawning:spawn_seed",
		{
			collisionbox    = spawner_collisionbox,
			visual          = "sprite",
			textures        = { spawner_texture },
			physical        = false,
			groups          = { "immortal" },
			on_activate     = function(self,staticdata,dtime_s)
									self.activated = false
									self.mydtime = dtime_s
									self.serialized_data = staticdata
									self.object:set_armor_groups({ immortal=100 })
									adv_spawning.seed_activate(self)
								end,
			on_step         = adv_spawning.seed_step,
			get_staticdata  = function(self)
									return minetest.serialize(self.spawning_data)
								end,
			on_rightclick   = adv_spawning.on_rightclick
		}
	)
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] seed_validate_spawndata
-- @param self spawner entity
--------------------------------------------------------------------------------
function adv_spawning.seed_validate_spawndata(self)
	for key,value in pairs(self.spawning_data) do
		if adv_spawning.spawner_definitions[key] == nil then
			self.spawning_data[key] = nil
		end
	end
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] seed_countdown_spawners
-- @param self spawner entity
-- @param dtime time to decrement spawners
--------------------------------------------------------------------------------
function adv_spawning.seed_countdown_spawners(self,dtime)

	for key,value in pairs(self.spawning_data) do
		self.spawning_data[key] = self.spawning_data[key] - dtime

		if self.spawning_data[key] < 0 then
			table.insert(self.pending_spawners,key)
		end
	end
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] seed_check_for_collision
-- @param self spawner entity
-- @return true/false
--------------------------------------------------------------------------------
function adv_spawning.seed_check_for_collision(self)
	assert(self ~= nil)
	local pos = self.object:getpos()
	local objects = minetest.get_objects_inside_radius(pos, 0.5)
	
	if objects == nil then
		return false
	end
	
	-- check if any of those found objects is a spawning seed
	for k,v in ipairs(objects) do
		local entity = v:get_luaentity()
		
		if entity ~= nil then
			if entity.name == "adv_spawning:spawn_seed" and
				entity.object ~= self.object then
				self.object:remove()
				return true
			end
		end
	end
	
	return false
end


function adv_spawning.init_spawner(self, pos, name, spawnerdef)
	local starttime = adv_spawning.gettime()

	if self.spawner_init_state ~= nil then
		self.spawner_init_state = "initial"
	end
	
	local starttime = adv_spawning.gettime()
	if self.spawner_init_state == "initial" then
		
		--check if cyclic spawning is enabled
		if spawnerdef.cyclic_spawning ~= nil and
			spawnerdef.cyclic_spawning == false then
			self.spawning_data[name] = nil
			return true
		end
		self.spawner_init_state = "abs_height"
	end
	
	starttime = adv_spawning.check_time(starttime, name  .. "cyclic check")	
	if self.spawner_init_state == "abs_height" then
		--if spawner is far away from spawn area don't even try to spawn
		if spawnerdef.absolute_height ~= nil then
			if spawnerdef.absolute_height.min ~= nil and
				spawnerdef.absolute_height.min
				> pos.y + (adv_spawning.spawner_distance/2) then
				self.spawning_data[name] = nil
				return true
			end

			if spawnerdef.absolute_height.max ~= nil
				and spawnerdef.absolute_height.max
				< pos.y - (adv_spawning.spawner_distance/2) then
				self.spawning_data[name] = nil
				return true
			end
		end
		self.spawner_init_state = "environment"
	end	
	
	starttime = adv_spawning.check_time(starttime, name  .. "height check")
	if self.spawner_init_state == "environment" then
	
		local runidx = 1
		local radius = adv_spawning.spawner_distance / 2
	
		if self.spawnerinit_env_radius ~= nil then
			runidx = self.spawnerinit_env_radius
		end
		
		local found = false
		
		for i = runidx , radius, 1 do
			adv_spawning.quota_leave()
			
			if not adv_spawning.quota_enter() then
				self.spawnerinit_env_radius = runidx
				return false
			end
			
			if spawnerdef.spawn_inside == nil then
				print(name .. " tries to spawn within nil")
				assert(false)
			end
			
			local resultpos = adv_spawning.find_nodes_in(pos, runidx, runidx, spawnerdef.spawn_inside)
			
			if (resultpos ~= nil) then
				local node = minetest.get_node_or_nil(resultpos)
				found = true
				break
			end
		end
		
		starttime = adv_spawning.check_time(starttime, name ..
			" at environment check radius was: " .. radius ..
				" env: " .. dump(spawnerdef.spawn_inside))
				
		if not found then
			self.spawning_data[name] = nil
		end
	end	
	
	self.spawner_init_state = "initial"
	self.spawning_data[name] = spawnerdef.spawn_interval * math.random()
	return true
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] seed_scan_for_applyable_spawners
-- @param self spawner entity
-- @return true/false
--------------------------------------------------------------------------------
function adv_spawning.seed_scan_for_applyable_spawners(self)

	if self.initialized_spawners >=
			adv_spawning.table_count(adv_spawning.spawner_definitions) then
		return true
	end

	local runindex = 0
	
	if self.spawner_init_idx ~= nil then
		runindex = self.spawner_init_idx
	end
	
	local pos = self.object:getpos()
	for key,value in pairs(adv_spawning.spawner_definitions) do
		if not adv_spawning.quota_enter() then
			return false
		end
		
		local continue = false
		
		if runindex >= self.initialized_spawners then
			self.initialized_spawners = self.initialized_spawners + 1
		else
			continue = true
		end
		
		
		if not continue then
			runindex = runindex + 1
			if not adv_spawning.init_spawner(self, pos, key, value) then
				return false
			end
		end
		
		adv_spawning.quota_leave()
	end
	
	return self.initialized_spawners == #adv_spawning.spawner_definitions
end