-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file spawning.lua
--! @brief component containing spawning features
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--

--! @defgroup spawning Spawn mechanisms
--! @brief all functions and variables required for automatic mob spawning
--! @ingroup framework_int
--! @{
--
--! @defgroup spawn_algorithms (DEPRECATED) Spawn algorithms
--! @brief spawn algorithms provided by previous mob framework versions. New
--! mobs are strongly encouraged to use advanced spawning mob as spawning will
--! be removed from mobf as of version 2.5
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------
mobf_assert_backtrace(not core.global_exists("spawning"))
--! @class spawning
--! @brief spawning features
spawning = {}

--!@}

mobf_assert_backtrace(not core.global_exists("mobf_spawn_algorithms"))
--! @brief registry for spawn algorithms
--! @memberof spawning
--! @private
mobf_spawn_algorithms = {}

-------------------------------------------------------------------------------
-- name: init()
-- @function [parent=#spawning] init
--
--! @brief initialize spawning data
--! @memberof spawning
--
-------------------------------------------------------------------------------
function spawning.init()
	--read from file
	local world_path = minetest.get_worldpath()

	local file,error = io.open(world_path .. "/mobf_spawning_data","r")

	if file ~= nil then
		local data_raw = file:read("*a")
		file:close()

		if data_raw ~= nil then
			spawning.mob_spawn_data = minetest.deserialize(data_raw)
		end
	end

	if spawning.mob_spawn_data == nil then
		spawning.mob_spawn_data = {}
	end

	--register spawndata persistent storer to globalstep
	minetest.after(300,spawning.preserve_spawn_data,true)

	--register cleanup handler
	minetest.register_on_shutdown(function(dstep) spawning.preserve_spawn_data(false) end)
end

-------------------------------------------------------------------------------
-- name: preserve_spawn_data()
-- @function [parent=#spawning] preserve_spawn_data
--
--! @brief save data on regular base
--! @memberof spawning
--
--! @param cyclic if this is true spawn data is saved in cyclic intervals
-------------------------------------------------------------------------------
function spawning.preserve_spawn_data(cyclic)

	local world_path = minetest.get_worldpath()
	local file,error = io.open(world_path .. "/mobf_spawning_data","w")

	if error ~= nil then
		minetest.log(LOGLEVEL_ERROR,"MOBF: failed to spawning preserve file")
	end
	mobf_assert_backtrace(file ~= nil)

	local serialized_data = minetest.serialize(spawning.mob_spawn_data)

	file:write(serialized_data)

	if cyclic then
		minetest.after(300,spawning.preserve_spawn_data,cyclic)
	end
end

-------------------------------------------------------------------------------
-- name: total_offline_mobs()
-- @function [parent=#spawning] total_offline_mobs
--
--! @brief count total number of offline mobs
--! @memberof spawning
--
--! @return number of mobs
-------------------------------------------------------------------------------
function spawning.total_offline_mobs()
	local count = 0
	for key,value in pairs(spawning.mob_spawn_data) do
		for hash,v in pairs(value) do
			count = count +1
		end
	end

	return count
end

-------------------------------------------------------------------------------
-- name: count_deactivated_mobs(name,pos,range)
-- @function [parent=#spawning] count_deactivated_mobs
--
--! @brief count number of mobs of specific type within a certain range
--! @memberof spawning
--
--! @param name name of mob to count
--! @param pos to check distance to
--! @param range to check
--
--! @return number of mobs
-------------------------------------------------------------------------------
function spawning.count_deactivated_mobs(name,pos,range)
	local count = 0
	if spawning.mob_spawn_data[name] ~= nil then
		for hash,v in pairs(spawning.mob_spawn_data[name]) do
			local mobpos = mobf_hash_to_pos(hash)
			local distance = vector.distance(pos,mobpos)
			if distance < range then
				local node = core.get_node(mobpos)
				local notfound = true
				-- if we are within active object range and
				-- that position is loaded check if there's really a mob at that location
				if node.name ~= "ignore" and distance < 32 then
					local found = false
					local objects_around = core.get_objects_inside_radius(mobpos, 1)
					if objects_around and #objects_around > 0 then
						for i,v in ipairs(objects_around) do
							local luaentity = v:get_luaentity()
							if luaentity ~= nil then
								if luaentity.data ~= nil and
									luaentity.data.name == name then
									found = true
									break
								end
							end
						end
					end
					if not found then
						dbg_mobf.spawning_lvl2(
							"MOBF: clearing stall deactivated entry at: " ..
							core.pos_to_string(mobpos))
						notfound = false
						spawning.mob_spawn_data[name][hash] = nil
					end
				end
				
				if notfound then
					count = count +1
				end
			end
		end
	end
	return count
end

-------------------------------------------------------------------------------
-- name: deactivate_mob(entity)
-- @function [parent=#spawning] deactivate_mob
--
--! @brief add mob to deactivated list
--! @memberof spawning
--
--! @param name name of mob to be deactivated
--! @param pos position to deactivate mob at
-------------------------------------------------------------------------------
function spawning.deactivate_mob(name,pos)
	if spawning.mob_spawn_data[name] == nil then
		spawning.mob_spawn_data[name] = {}
	end

	local rounded_pos = vector.round(pos)
	local hash = minetest.hash_node_position(rounded_pos)
	--assert (mobf_pos_is_same(mobf_hash_to_pos(hash),rounded_pos))
	spawning.mob_spawn_data[name][hash] = true
end

-------------------------------------------------------------------------------
-- name: activate_mob(name,pos)
-- @function [parent=#spawning] preserve_spawn_data
--
--! @brief save data on regular base
--! @memberof spawning
--
--! @param name name of mob to be activated
--! @param pos position to activate mob at
-------------------------------------------------------------------------------
function spawning.activate_mob(name,pos)
	if spawning.mob_spawn_data[name] ~= nil then
		local rounded_pos = vector.round(pos)
		local hash = minetest.hash_node_position(rounded_pos)
		--assert(mobf_pos_is_same(mobf_hash_to_pos(hash),rounded_pos))
		spawning.mob_spawn_data[name][hash] = nil
	end
end


-------------------------------------------------------------------------------
-- name: remove_uninitialized(entity,staticdata)
-- @function [parent=#spawning] remove_uninitialized
--
--! @brief remove a spawn point based uppon staticdata supplied
--! @memberof spawning
--
--! @param entity to remove
--! @param staticdata of mob
-------------------------------------------------------------------------------
function spawning.remove_uninitialized(entity, staticdata)
	--entity may be known in spawnlist
	if staticdata ~= nil then
		local permanent_data = mobf_deserialize_permanent_entity_data(staticdata)
		if (permanent_data.spawnpoint ~= nil) then

			--prepare information required to remove entity
			entity.dynamic_data = {}
			entity.dynamic_data.spawning = {}
			entity.dynamic_data.spawning.spawnpoint = permanent_data.spawnpoint
			entity.dynamic_data.spawning.player_spawned = permanent_data.playerspawned
			entity.dynamic_data.spawning.spawner = permanent_data.spawner

			spawning.remove(entity,"remove uninitialized")
		end
	else
		dbg_mobf.spawning_lvl1("MOBF: remove uninitialized entity=" .. tostring(entity))
		--directly remove it can't be known to spawnlist
		entity.object:remove()
	end
end

-------------------------------------------------------------------------------
-- name: remove(entity)
-- @function [parent=#spawning] remove
--
--! @brief remove a mob
--! @memberof spawning
--
--! @param entity mob to remove
--! @param reason text to log as reason for removal
-------------------------------------------------------------------------------
function spawning.remove(entity,reason)
	local pos = entity.object:getpos()
	dbg_mobf.spawning_lvl3("MOBF: --> remove " .. printpos(pos))
	if entity ~= nil then
		entity.removed = true
		dbg_mobf.spawning_lvl1("MOBF: remove entity=" .. tostring(entity))
		if minetest.world_setting_get("mobf_log_removed_entities") then
			if reason == nil then
				reason = "unknown"
			end
			minetest.log(LOGLEVEL_NOTICE,"MOBF: removing " .. entity.data.name ..
				" at " .. printpos(pos) .. " due to: " .. reason)
		end
		mobf.preserve_removed(entity,reason)
		if entity.lifebar ~= nil then
			mobf_lifebar.del(entity.lifebar)
		end
		entity.object:remove()
	else
		minetest.log(LOGLEVEL_ERROR,"Trying to delete an an non existant mob")
	end

	dbg_mobf.spawning_lvl3("MOBF: <-- remove")
end

-------------------------------------------------------------------------------
-- name: init_dynamic_data(entity)
-- @function [parent=#spawning] init_dynamic_data
--
--! @brief initialize dynamic data required for spawning
--! @memberof spawning
--
--! @param entity mob to initialize dynamic data
--! @param now current time
-------------------------------------------------------------------------------
function spawning.init_dynamic_data(entity,now)

	local player_spawned = false

	if entity.dynamic_data.spawning ~= nil and
		entity.dynamic_data.spawning.player_spawned then
		player_spawned = true
	end

	local data = {
		player_spawned     = player_spawned,
		ts_dense_check     = now,
		spawnpoint         = entity.object:getpos(),
		original_spawntime = now,
		spawner            = nil,
		density            = spawning.population_density_get_min(entity),
	}

	entity.removed = false
	entity.dynamic_data.spawning = data
end

-------------------------------------------------------------------------------
-- name: population_density_check(mob)
-- @function [parent=#spawning] population_density_check
--
--! @brief check and fix if there are too many mobs within a specific range
--! @memberof spawning
--
--! @param entity mob to check
--! @param now current time
-------------------------------------------------------------------------------
function spawning.population_density_check(entity,now)

	if entity == nil or
		entity.dynamic_data == nil or
		entity.dynamic_data.spawning == nil then
		mobf_bug_warning(LOGLEVEL_ERROR,"MOBF BUG!!! " .. entity.data.name ..
			" pop dense check called for entity with missing spawn data entity=" ..
			tostring(entity))
		return false
	end


	--only check every 5 seconds
	if entity.dynamic_data.spawning.ts_dense_check + 5 > now then
		return true
	end

	-- don't check if mob is player spawned
	if entity.dynamic_data.spawning.player_spawned == true then
		dbg_mobf.spawning_lvl1("MOBF: mob is player spawned skipping pop dense check")
		return true
	end

	--don't do population check while fighting
	if entity.dynamic_data.combat ~= nil and
		entity.dynamic_data.combat.target ~= nil and
		entity.dynamic_data.combat.target ~= "" then
		dbg_mobf.spawning_lvl1(
			"MOBF: fighting right now skipping pop dense check: " ..
			dump(entity.dynamic_data.combat.target))
		return true
	end

	entity.dynamic_data.spawning.ts_dense_check = now

	local entitypos = mobf_round_pos(entity.object:getpos())

	--mob either not initialized completely or a bug
	if mobf_pos_is_zero(entitypos) then
		dbg_mobf.spawning_lvl1("MOBF: can't do a sane check")
		return true
	end

	local secondary_name = ""
	if entity.data.harvest ~= nil then
		secondary_name = entity.data.harvest.transform_to
	end

	local check_density = entity.dynamic_data.spawning.density

	if entity.data.generic.population_density ~= nil then
		check_density = entity.data.generic.population_density
	end

	mobf_assert_backtrace(check_density ~= nil)

	local mob_count = mobf_mob_around(entity.data.modname..":"..entity.data.name,
										secondary_name,
										entitypos,
										check_density,
										true)
	if  mob_count > 5 then
		dbg_mobf.spawning_lvl1("MOBF: " .. entity.data.name ..
			mob_count .. " mobs of same type around")
		entity.removed = true
		minetest.log(LOGLEVEL_INFO,"MOBF: Too many ".. mob_count .. " "..
			entity.data.name.." at one place dying: " ..
			tostring(entity.dynamic_data.spawning.player_spawned))
		spawning.remove(entity, "population density check")
		return false
	else
		dbg_mobf.spawning_lvl2("MOBF: " ..  entity.data.name ..
			" density ok only "..mob_count.." mobs around")
		return true
	end
end

-------------------------------------------------------------------------------
-- name: replace_entity(pos,name,spawnpos,health)
-- @function [parent=#spawning] replace_entity
--
--! @brief replace mob at a specific position by a new one
--! @memberof spawning
--
--! @param entity mob to replace
--! @param name of the mob to add
--! @param preserve preserve original spawntime
--! @return entity added or nil on error
-------------------------------------------------------------------------------
function spawning.replace_entity(entity,name,preserve)
	dbg_mobf.spawning_lvl3("MOBF: --> replace_entity("
		.. entity.data.name .. "|" .. name .. ")")

	if minetest.registered_entities[name] == nil then
		minetest.log(LOGLEVEL_ERROR,"MOBF: replace_entity: Bug no "
			..name.." is registred")
		return nil
	end

	-- avoid switching to same entity
	if entity.name == name then
		minetest.log(LOGLEVEL_INFO,"MOBF: not replacing " .. name ..
			" by entity of same type!")
		return nil
	end


	-- get data to be transfered to new entity
	local pos             = mobf.get_basepos(entity)
	local health          = entity.object:get_hp()
	local temporary_dynamic_data = entity.dynamic_data
	local entity_orientation = graphics.getyaw(entity)

	if preserve == nil or preserve == false then
		temporary_dynamic_data.spawning.original_spawntime = mobf_get_current_time()
	end

	--calculate new y pos
	if minetest.registered_entities[name].collisionbox ~= nil then
		pos.y = pos.y - minetest.registered_entities[name].collisionbox[2]
	end


	--delete current mob
	dbg_mobf.spawning_lvl2("MOBF: replace_entity: removing " ..  entity.data.name)

	--unlink dynamic data (this should work but doesn't due to other bugs)
	entity.dynamic_data = nil

	--removing is done after exiting lua!
	spawning.remove(entity,"replaced")

	--set marker to true to make sure activate handler knows it's replacing right now
	spawning.replacing_NOW = true
	local newobject = minetest.add_entity(pos,name)
	spawning.replacing_NOW = false
	local newentity = mobf_find_entity(newobject)

	if newentity ~= nil then
		if newentity.dynamic_data ~= nil then
			dbg_mobf.spawning_lvl2("MOBF: replace_entity: " ..  name)
			newentity.dynamic_data = temporary_dynamic_data
			newentity.object:set_hp(health)
			graphics.setyaw(newentity, entity_orientation)
		else
			minetest.log(LOGLEVEL_ERROR,
				"MOBF: replace_entity: dynamic data not set for "..name..
				" maybe delayed activation?")
			newentity.dyndata_delayed = {
				data = temporary_dynamic_data,
				health = health,
				orientation = entity_orientation
			}
		end
	else
		minetest.log(LOGLEVEL_ERROR,
			"MOBF: replace_entity 4 : Bug no "..name.." has been created")
	end
	dbg_mobf.spawning_lvl3("MOBF: <-- replace_entity")
	return newentity
end

------------------------------------------------------------------------------
-- name: lifecycle_callback()
-- @function [parent=#spawning] lifecycle_callback
--
--! @brief check mob lifecycle_callback
--! @memberof spawning
--
--! @return true/false still alive dead
-------------------------------------------------------------------------------
function spawning.lifecycle_callback(entity,now)

	if entity.dynamic_data.spawning.original_spawntime ~= nil then
		if entity.data.spawning ~= nil and
			entity.data.spawning.lifetime ~= nil then

			local lifetime = entity.data.spawning.lifetime

			local current_age = now - entity.dynamic_data.spawning.original_spawntime

			if current_age > 0 and
				current_age > lifetime then
				dbg_mobf.spawning_lvl1("MOBF: removing animal due to limited lifetime")
				spawning.remove(entity," limited mob lifetime")
				return false
			end
		end
	else
		entity.dynamic_data.spawning.original_spawntime = now
	end

	return true
end

------------------------------------------------------------------------------
-- name: spawn_and_check(name,pos,text)
-- @function [parent=#spawning] spawn_and_check
--
--! @brief spawn an entity and check for presence
--! @memberof spawning
--! @param name name of entity
--! @param pos position to spawn mob at
--! @param text message used for log messages
--
--! @return spawned mob entity
-------------------------------------------------------------------------------
function spawning.spawn_and_check(name,pos,text)
	mobf_assert_validpos(pos)
	mobf_assert_backtrace(name ~= nil)

	local newobject = minetest.add_entity(pos,name)

	if newobject then
		local newentity = mobf_find_entity(newobject)

		if newentity == nil then
			dbg_mobf.spawning_lvl3("MOBF BUG!!! no " .. name ..
				" entity has been created by " .. text .. "!")
			mobf_bug_warning(LOGLEVEL_ERROR,"BUG!!! no " .. name ..
				" entity has been created by " .. text .. "!")
		else
			dbg_mobf.spawning_lvl2("MOBF: spawning "..name ..
				" entity by " .. text .. " at position ".. printpos(pos))
			minetest.log(LOGLEVEL_INFO,"MOBF: spawning "..name ..
				" entity by " .. text .. " at position ".. printpos(pos))
			return newentity
		end
	else
		dbg_mobf.spawning_lvl3("MOBF BUG!!! no "..name..
			" object has been created by " .. text .. "!")
		mobf_bug_warning(LOGLEVEL_ERROR,"MOBF BUG!!! no "..name..
			" object has been created by " .. text .. "!")
	end

	return nil
end

------------------------------------------------------------------------------
-- name: population_density_get_min(entity)
-- @function [parent=#spawning] population_density_get_min
--
--! @brief get minimum density for this mob
--! @memberof spawning
--
--! @param entity the mob itself
--
--! @return minimum density over all spawners defined for this mob
-------------------------------------------------------------------------------
function spawning.population_density_get_min(entity)
	if entity.data.spawning == nil then
		return entity.data.generic.population_density
	end
	-- legacy code
	if type(entity.data.spawning.primary_algorithms) == "table" then
		local density = nil
		for i=1 , #entity.data.spawning.primary_algorithms , 1 do
			if density == nil or
				entity.data.spawning.primary_algorithms[i].density < density then

				density = entity.data.spawning.primary_algorithms[i].density
			end
		end
		return density
	else
		return entity.data.spawning.density
	end
end

-------------------------------------------------------------------------------
-- name: check_activation_overlap(entity,pos,preserved_data)
--
--! @brief check if a activating entity is spawned within some other entity
--
--! @param entity entity to check
--! @param pos position spawned at
--! @param preserved_data data loaded for entity
--! @return true
-------------------------------------------------------------------------------
function spawning.check_activation_overlap(entity,pos,preserved_data)

	local cleaned_objectcount = mobf_objects_around(pos,0.25,{ "mobf:lifebar" })

	--honor replaced marker
	if (entity.replaced ~= true and cleaned_objectcount > 1) or
		cleaned_objectcount > 2 then

		------------------------------
		-- debug output only
		-- ---------------------------
		local spawner = "unknown"
		if preserved_data ~= nil and
			preserved_data.spawner ~= nil then
			spawner = preserved_data.spawner

			mobf_bug_warning(LOGLEVEL_WARNING,
				"MOBF: trying to activate mob \"" ..entity.data.name ..
				" at " .. printpos(pos) .. " (" .. tostring(entity)
				.. ")"..
				"\" within something else!" ..
				" originaly spawned by: " .. spawner ..
				" --> removing")

			objectlist = minetest.get_objects_inside_radius(pos,0.25)

			for i=1,#objectlist,1 do
				local luaentity = objectlist[i]:get_luaentity()
				if luaentity ~= nil then
					if luaentity.data ~= nil and
						luaentity.data.name ~= nil then
						dbg_mobf.mobf_core_helper_lvl3(
							i .. " LE: " .. luaentity.name .. " (" .. tostring(luaentity) .. ") " ..
						luaentity.data.name .. " " ..
						printpos(objectlist[i]:getpos()))
					else
						dbg_mobf.mobf_core_helper_lvl3(
							i .. " LE: " .. luaentity.name .. " (" .. tostring(luaentity) .. ") " ..
							dump(luaentity))
					end
				else
					dbg_mobf.mobf_core_helper_lvl3(
						i .. " " .. tostring(objectlist[i]) ..
						printpos(objectlist[i]:getpos()))
				end
			end
			------------------------------
			-- end debug output
			-- ---------------------------
			return false
		end
	end
	return true
end
