local time_scale = ...

-- The growing ABM

function biome_lib.check_surface(name, nodes)
	if not nodes then return true end
	if type(nodes) == "string" then return nodes == name end
	if nodes.set and nodes[name] then
		return true
	else
		for _, n in ipairs(nodes) do
			if name == n then return true end
		end
	end
	return false
end

function biome_lib:grow_plants(opts)

	local options = opts

	options.height_limit = options.height_limit or 5
	options.ground_nodes = options.ground_nodes or { "default:dirt_with_grass" }
	options.grow_nodes = options.grow_nodes or { "default:dirt_with_grass" }
	options.seed_diff = options.seed_diff or 0

	local n

	if type(options.grow_plant) == "table" then
		n = "multi: "..options.grow_plant[1]..", ..."
	else
		n = options.grow_plant
	end

	options.label = options.label or "biome_lib grow_plants(): "..n

	if options.grow_delay*time_scale >= 1 then
		options.interval = options.grow_delay*time_scale
	else
		options.interval = 1
	end

	minetest.register_abm({
		nodenames = { options.grow_plant },
		interval = options.interval,
		chance = options.grow_chance,
		label = options.label,
		action = function(pos, node, active_object_count, active_object_count_wider)
			local p_top = {x=pos.x, y=pos.y+1, z=pos.z}
			local p_bot = {x=pos.x, y=pos.y-1, z=pos.z}
			local n_top = minetest.get_node(p_top)
			local n_bot = minetest.get_node(p_bot)
			local root_node = minetest.get_node({x=pos.x, y=pos.y-options.height_limit, z=pos.z})
			local walldir = nil
			if options.need_wall and options.verticals_list then
				walldir = biome_lib:find_adjacent_wall(p_top, options.verticals_list, options.choose_random_wall)
			end
			if (n_top.name == "air" or n_top.name == "default:snow")
			  and (not options.need_wall or (options.need_wall and walldir)) then
				if options.grow_vertically and walldir then
					if biome_lib:search_downward(pos, options.height_limit, options.ground_nodes) then
						minetest.swap_node(p_top, { name = options.grow_plant, param2 = walldir})
					end

				elseif biome_lib.check_surface(n_bot.name, options.grow_nodes) then
					if not options.grow_result and not options.grow_function then
						minetest.swap_node(pos, biome_lib.air)

					else
						biome_lib:replace_object(pos, options.grow_result, options.grow_function, options.facedir, options.seed_diff)
					end
				end
			end
		end
	})
end


-- spawn_tree() on generate is routed through here so that other mods can hook
-- into it.

function biome_lib:generate_tree(pos, nodes_or_function_or_model)
	minetest.spawn_tree(pos, nodes_or_function_or_model)
end

-- and this one's for the call used in the growing code

function biome_lib:grow_tree(pos, nodes_or_function_or_model)
	minetest.spawn_tree(pos, nodes_or_function_or_model)
end
