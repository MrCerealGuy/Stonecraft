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
-- @function [parent=#adv_spawning] verify_check_entities_around
-- @param entities_around a spawndef entities_around config
-- @return true/false
--------------------------------------------------------------------------------
function adv_spawning.verify_check_entities_around(entities_around)
	if entities_around ~= nil then

		for i=1,#entities_around,1 do

			if type(entities_around[i].distance) ~= "number" then
				adv_spawning.dbg_log(0, "missing distance in entities_around definition")
				return false
			end

			if entities_around[i].type ~= "MIN" and
				entities_around[i].type ~= "MAX" then
				adv_spawning.dbg_log(0, "invalid type \"" ..
					dump(entities_around[i].type) ..
					"\" in entities_around definition")
				return false
			end
		end
	end

	return true
end

--------------------------------------------------------------------------------
-- @function [parent=#adv_spawning] verify_check_nodes_around
-- @param nodes_around a spawndef entities_around config
-- @return true/false
--------------------------------------------------------------------------------
function adv_spawning.verify_check_nodes_around(nodes_around)
	if nodes_around ~= nil then
		for i=1,#nodes_around,1 do

			if type(nodes_around[i].distance) ~= "number" then
				adv_spawning.dbg_log(0, "missing distance in entities_around definition")
				return false
			end

			if nodes_around[i].type ~= "MIN" and
				nodes_around[i].type ~= "MAX" then
				adv_spawning.dbg_log(0, "invalid type \"" ..
					dump(nodes_around[i].type) ..
					"\" in entities_around definition")
				return false
			end

			if nodes_around[i].name == nil or
				type(nodes_around[i].name) ~= "table" then
				adv_spawning.dbg_log(0, "invalid type of name \"" ..
					type(nodes_around[i].name) .. "\"" .. " Data: " ..
					dump(nodes_around[i].name) ..
					" in nodes_around definition")
				return false
			end
		end
	end

	return true
end