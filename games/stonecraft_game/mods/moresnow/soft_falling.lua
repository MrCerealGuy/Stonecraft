
-- moresnow shall not crush plants (buildable_to is set) when falling
-- on them - snow is not like sand or gravel (at least when falling slowly)
local old_try_place = minetest.registered_entities["__builtin:falling_node"].try_place
minetest.registered_entities["__builtin:falling_node"].try_place = function(self, bcp, bcn)
	if core.get_item_group(self.node.name, "soft_falling") == 0 then
		return old_try_place(self, bcp, bcn)
	end
	return moresnow.new_try_place(self, bcp, bcn)
end


-- avoid cascades of dropping moresnow nodes that are actually sitting
-- perfectly well on buildable_to plants
local old_check_single_for_falling = core.check_single_for_falling
core.check_single_for_falling = function(p)
	return moresnow.check_single_for_falling(p)
end


-- this is a only minimally modified copy of the function in builtin/game/falling.lua:
moresnow.new_try_place = function(self, bcp, bcn)
		local bcd = core.registered_nodes[bcn.name]
		-- Add levels if dropped on same leveled node
		if bcd and bcd.paramtype2 == "leveled" and
				bcn.name == self.node.name then
			local addlevel = self.node.level
			if (addlevel or 0) <= 0 then
				addlevel = bcd.leveled
			end
			if core.add_node_level(bcp, addlevel) < addlevel then
				return true
			elseif bcd.buildable_to then
				-- Node level has already reached max, don't place anything
				return true
			end
		end

		-- Decide if we're replacing the node or placing on top
		local np = vector.copy(bcp)
		if bcd and bcd.buildable_to and
				(not self.floats or bcd.liquidtype == "none") then
			core.remove_node(bcp)
		else
			np.y = np.y + 1
		end

		-- Check what's here
		local n2 = core.get_node(np)
		local nd = core.registered_nodes[n2.name]
		-- If it's not air or liquid, remove node and replace it with
		-- it's drops
		if n2.name ~= "air" and (not nd or nd.liquidtype == "none") then
			if nd and nd.buildable_to == false then
				nd.on_dig(np, n2, nil)
				-- If it's still there, it might be protected
				if core.get_node(np).name == n2.name then
					return false
				end
			else
				if core.get_item_group(self.node.name, "soft_falling") == 0 then
					core.remove_node(np)
				else
					-- do not crush the plant below!
					np.y = np.y + 1
				end
			end
		end

		-- Create node
		local def = core.registered_nodes[self.node.name]
		if def then
			core.add_node(np, self.node)
			if self.meta then
				core.get_meta(np):from_table(self.meta)
			end
			if def.sounds and def.sounds.place then
				core.sound_play(def.sounds.place, {pos = np}, true)
			end
		end
		core.check_for_falling(np)
		return true
end


-- this is a only minimally modified copy of the function in builtin/game/falling.lua:
moresnow.check_single_for_falling = function(p)
	local n = core.get_node(p)
	if core.get_item_group(n.name, "falling_node") ~= 0 then
		local p_bottom = vector.offset(p, 0, -1, 0)
		-- Only spawn falling node if node below is loaded
		local n_bottom = core.get_node_or_nil(p_bottom)
		local d_bottom = n_bottom and core.registered_nodes[n_bottom.name]
		if d_bottom then
			-- do not trigger a cascade of falling nodes when it's just
			-- moresnow nodes that rest perfectly well on top of plants (buildable_to)
			if(d_bottom.name and d_bottom.name ~= "air"
			  and core.get_item_group(n.name, "soft_falling") > 0) then
				return false
			end
		end
	end
	-- makes use of local builtin_shared variable which we don't have available here - so
	-- we need to call the original
	return old_check_single_for_falling(p)
end
