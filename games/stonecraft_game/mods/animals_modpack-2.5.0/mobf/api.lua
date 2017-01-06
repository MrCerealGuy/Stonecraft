-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file api.lua
--! @brief api functions to be used by other mods
--! @copyright Sapier
--! @author Sapier
--! @date 2012-12-27
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- @function mobf_register_on_death_callback(callback)
--
--! @brief get version of mob framework
--! @ingroup framework_mob
--
--! @param callback callback to register
--! @return true/false
-------------------------------------------------------------------------------
function mobf_register_on_death_callback(callback)
	return fighting.register_on_death_callback(callback)
end

-------------------------------------------------------------------------------
-- @function mobf_get_mob_definition(mobname)
--
--! @brief get COPY of mob definition
--! @ingroup framework_mob
--
--! @return mobf version
-------------------------------------------------------------------------------
function mobf_get_mob_definition(mobname)

	if mobf_rtd.registred_mob_data[mobname] ~= nil then
		local copy = minetest.serialize(mobf_rtd.registred_mob_data[mobname])
		return minetest.deserialize(copy)
	end
	return nil
end

-------------------------------------------------------------------------------
-- @function mobf_get_version()
--
--! @brief get version of mob framework
--! @ingroup framework_mob
--
--! @return mobf version
-------------------------------------------------------------------------------
function mobf_get_version()
	return mobf_version
end

------------------------------------------------------------------------------
-- @function mobf_add_mob(mob)
--
--! @brief register a mob within mob framework
--! @ingroup framework_mob
--
--! @param mob a mob declaration
-------------------------------------------------------------------------------
function mobf_add_mob(mob)

	if not mobf.check_definition(mob) then
		minetest.log(LOGLEVEL_ERROR,"MOBF: mob definition is invalid!")
		return
	end

	--check if mob is blacklisted
	--mobs from the blacklist are pre-registered at startup
	if mobf_contains(mobf_rtd.registred_mob,mob.modname.. ":"..mob.name) then
		mobf.blacklisthandling(mob)
		return false
	end

	--if a random drop is specified for this mob register it
	if mob.random_drop ~= nil then
		random_drop.register(mob.random_drop)
	end

	--create default entity
	minetest.log(LOGLEVEL_INFO,"MOBF: adding: " .. mob.name)
	mob_state.prepare_states(mob)

	mobf.register_entity(":" .. mob.modname .. ":"..mob.name,
							graphics.graphics_by_statename(mob,"default"), mob)

	--add compatibility entity to replace old __default entities by new ones
	minetest.log(LOGLEVEL_INFO,"MOBF: registering compatibility entity: >" ..
					":" .. mob.modname .. ":"..mob.name .. "__default" .. "<")
	minetest.register_entity(":" .. mob.modname .. ":"..mob.name .. "__default",
			{
			replacement_name = mob.modname .. ":"..mob.name,
			on_activate = function(self,staticdata)

					local pos = self.object:getpos()

					if pos ~= nil then
						local newobject = minetest.add_entity(pos,self.replacement_name)
						local spawned_entity = mobf_find_entity(newobject)

						if spawned_entity ~= nil then
						spawned_entity.dynamic_data.initialized = false
						if (staticdata ~= "") then
							spawned_entity.dynamic_data.last_static_data = staticdata
						end
						end
					end
					self.object:remove()
				end,
			})

	mobf.register_mob_item(mob.name,mob.modname,mob.generic.description, mob.generic.itemimage)

	--check if a movement pattern was specified
	if mobf_rtd.movement_patterns[mob.movement.pattern] == nil then
		minetest.log(LOGLEVEL_WARNING,"MOBF: no movement pattern specified!")
	end

	if mob.spawning ~= nil then
		minetest.log(LOGLEVEL_WARNING,"MOBF: \"" .. mob.name ..
			"\" is still using mob internal spawning," ..
			" this is DEPRECATED and going to be removed soon!")
		spawning.register_mob(mob)
	end

	--register factions required by mob
	mobf_factions.setupmob(mob.factions)

	if mob.generic.stepheight == nil then
		mob.generic.stepheight = 0
	end

	--register mob name to internal data structures
	table.insert(mobf_rtd.registred_mob,mob.modname.. ":"..mob.name)
	mobf_rtd.registred_mob_data[mob.modname.. ":"..mob.name] = mob;

	return true
end

------------------------------------------------------------------------------
-- @function mobf_is_known_mob(name)
--
--! @brief check if mob of name is known
--! @ingroup framework_mob
--
--! @param name name to check if it's a mob
--! @return true/false
-------------------------------------------------------------------------------
function mobf_is_known_mob(name)
	for i,val in ipairs(mobf_rtd.registred_mob) do
		if name == val then
			return true
		end
	end

	return false
end

------------------------------------------------------------------------------
-- @function mobf_register_environment(name,environment)
--
--! @brief register an environment to mob framework
--! @ingroup framework_mob
--
--! @param name of environment
--! @param environment specification
--! @return true/false
-------------------------------------------------------------------------------
function mobf_register_environment(name,environment)
	return environment.register(name,environment)
end

------------------------------------------------------------------------------
-- @function mobf_environment_by_name(name)
--
--! @brief get environment by name
--! @ingroup framework_mob
--
--! @param name of environment
--! @return environment definition
-------------------------------------------------------------------------------
function mobf_environment_by_name(name)
	if environment_list[name] ~= nil then
		return minetest.deserialize(minetest.serialize(environment_list[name]))
	else
		return nil
	end
end

------------------------------------------------------------------------------
-- @function mobf_probab_movgen_register_pattern(pattern)
--
--! @brief register an movement pattern for probabilistic movement gen
--! @ingroup framework_mob
--
--! @param pattern to register (see pattern specification)
--! @return true/false
-------------------------------------------------------------------------------
function mobf_probab_movgen_register_pattern(pattern)
	return movement_gen.register_pattern(pattern)
end

------------------------------------------------------------------------------
-- @function mobf_spawner_register(name,spawndef)
--
--! @brief register a spawndef to adv_spawning
--! @ingroup framework_mob
--
--! @param name of spawner
--! @param mobname name of mob to register spawner for
--! @param spawndef defintion of spawner
--! @return true/false
-------------------------------------------------------------------------------
function mobf_spawner_register(name,mobname,spawndef)

	--check if spawning is enabled
	if minetest.world_setting_get("mobf_disable_animal_spawning") then
		return false
	end

	--check if mob is blacklisted
	if mobf_contains(mobf_rtd.registred_mob,mobname) then
		minetest.log(LOGLEVEL_NOTICE,"MOBF: " .. mobname .. " is blacklisted, not adding spawner")
		return false
	end

	local customcheck = spawndef.custom_check


	spawndef.custom_check = function(pos,spawndef)
			local entities_around = spawndef.entities_around

			if entities_around ~= nil then
				for i=1,#entities_around,1 do

					--only do this check if relevant area is larger then activity range
					if entities_around[i].distance > adv_spawning.active_range then
						local count = spawning.count_deactivated_mobs(
												mobname,
												pos,
												entities_around[i].distance)

						local entity_active =
							minetest.get_objects_inside_radius(pos,
												entities_around[i].distance)

						for j=1,#entity_active,1 do
							local entity = entity_active[j]:get_luaentity()

							if entity ~= nil then
								if entity.name == entities_around[i].entityname then
									count = count +1
								end

								if count + count > entities_around[i].threshold then
									break
								end
							end
						end

						if entities_around[i].type == "MIN" and
							count < entities_around[i].threshold then
							dbg_mobf.mobf_core_lvl3(
								"MOBF: MIN around not met: already: " .. count ..
								" relevant entities around")
							return false, "not enough entities around, only: " .. count .. " < " .. entities_around[i].threshold
						end

						if entities_around[i].type == "MAX" and
							count > entities_around[i].threshold then
							dbg_mobf.mobf_core_lvl3(
								"MOBF: MAX around not met: already: " .. count ..
								" relevant entities around")
								
							return false, "too many entities around, " .. count .. " > " .. entities_around[i].threshold
						end
					end
				end
			end

			if type(customcheck) == "function" and not customcheck(pos,spawndef) then
				return false, "customcheck failed"
			end

			return true, "entities around and customcheck ok"
		end

	--register
	adv_spawning.register(name,spawndef)
end
