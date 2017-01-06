-------------------------------------------------------------------------------
-- advanced spawning mod
--
--@license WTFP
--@copyright Sapier
--@author Sapier
--@date 2013-12-05
--
-------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] register
-- @param spawn_definition a definition to use for spawning
--------------------------------------------------------------------------------
function adv_spawning.register(spawner_name,spawning_def)
	if adv_spawning.spawner_definitions[spawner_name] == nil then


		if not adv_spawning.verify_check_entities_around(spawning_def.entities_around) then
			return false
		end

		if not adv_spawning.verify_check_nodes_around(spawning_def.nodes_around) then
			return false
		end

		adv_spawning.spawner_definitions[spawner_name] = spawning_def
		adv_spawning.dbg_log(0, "registering spawner \"" .. spawner_name .. "\"")
		adv_spawning.dbg_log(0, "now handling: " ..
			adv_spawning.table_count(adv_spawning.spawner_definitions) ..
			" spawner definitions")
		return true
	else
		return false
	end
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] get_statistics
-- @return get snapshot of statistics
--------------------------------------------------------------------------------
function adv_spawning.get_statistics()
	return minetest.deserialize(minetest.serialize(adv_spawning.statistics))
end


--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] get_spawner_density
-- @return get snapshot of statistics
--------------------------------------------------------------------------------
function adv_spawning.get_spawner_density()
	return adv_spawning.spawner_distance,adv_spawning.spawner_y_offset
end