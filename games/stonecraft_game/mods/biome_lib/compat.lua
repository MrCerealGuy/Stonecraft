-- compatibility shims for old mods

function biome_lib:register_generate_plant(b, n)
	biome_lib.dbg("Warning: biome_lib:register_generate_plant() is deprecated!", 2)
	biome_lib.dbg("Use biome_lib.register_on_generate() instead", 2)
	biome_lib.dbg("Item: "..dump(n), 2)
	biome_lib.register_on_generate(b, n)
end

function biome_lib:spawn_on_surfaces(sd, sp, sr, sc, ss, sa)
	biome_lib.dbg("Warning: biome_lib:spawn_on_surfaces() is deprecated!", 2)
	biome_lib.dbg("Use biome_lib.register_active_spawner() instead.", 2)
	biome_lib.dbg("Item: "..dump(sd.spawn_plants or sp[1] or sp), 2)
	biome_lib.register_active_spawner(sd, sp, sr, sc, ss, sa)
end

function biome_lib:replace_object(p, r, f, w, d)
	biome_lib.dbg("Warning: biome_lib:replace_object() is deprecated!", 2)
	biome_lib.dbg("Use biome_lib.replace_plant() instead.", 2)
	biome_lib.dbg("Item: "..dump(r), 2)
	biome_lib.replace_plant(p, r, f, w, d)
end

function biome_lib:grow_plants(o)
	biome_lib.dbg("Warning: biome_lib:grow_plants() is deprecated!", 2)
	biome_lib.dbg("Use biome_lib.update_plant() instead.", 2)
	biome_lib.dbg("Item: "..dump(o.grow_nodes), 2)
	biome_lib.update_plant(o)
end

function biome_lib.generate_ltree(p, n)
	minetest.spawn_tree(p, n)
end

function biome_lib.grow_ltree(p, n)
	minetest.spawn_tree(p, n)
end

function biome_lib:generate_tree(p, n)
	biome_lib.dbg("Warning: biome_lib:generate_tree() is deprecated!", 2)
	biome_lib.dbg("Use biome_lib.generate_ltree() instead.", 2)
	biome_lib.dbg("Item: "..dump(n), 2)
	biome_lib.generate_ltree(p, n)
end

function biome_lib:grow_tree(p, n)
	biome_lib.dbg("Warning: biome_lib:grow_tree() is deprecated!", 2)
	biome_lib.dbg("Use biome_lib.grow_ltree() instead.", 2)
	biome_lib.dbg("Item: "..dump(n), 2)
	biome_lib.grow_ltree(p, n)
end

function biome_lib.can_use_decorations(b, nodes_or_function_or_treedef)
	if not b or not nodes_or_function_or_treedef
	  or b.below_nodes
	  or b.avoid_nodes
	  or b.avoid_radius
	  or b.neighbors
	  or b.ncount
	  or b.depth
	  or b.near_nodes_size
	  or b.near_nodes_vertical
	  or b.temp_min
	  or b.temp_max
	  or b.verticals_list
	  or b.delete_above
	  or b.delete_above_surround
	  or ( type(nodes_or_function_or_treedef) == "string" and not minetest.registered_nodes[nodes_or_function_or_treedef] )
	  or ( type(nodes_or_function_or_treedef) == "table" and nodes_or_function_or_treedef.axiom )
	  or type(nodes_or_function_or_treedef) == "function"
		then return false
	end

	local biome = biome_lib.set_defaults(b)

	local decor_def = {
		["deco_type"] = "simple",
		["flags"] = "all_floors",
		["decoration"] = nodes_or_function_or_treedef,
		["place_on"] = biome.surface,
		["y_min"] = biome.min_elevation,
		["y_max"] = biome.max_elevation,
		["spawn_by"] = biome.near_nodes,
		["num_spawn_by"] = biome.near_nodes and biome.near_nodes_count,
	}

	local r = (100-biome.rarity)/100
	local mc = math.min(biome.max_count, 6400)/6400

	decor_def.noise_params = {
		octaves = biome_lib.fertile_perlin_octaves,
		persist = biome_lib.fertile_perlin_persistence * (100/biome_lib.fertile_perlin_scale),
		scale = math.min(r, mc),
		seed = biome.seed_diff,
		offset = 0,
		spread = {x = 100, y = 100, z = 100},
		lacunarity = 2,
		flags = "absvalue"
	}

	if not b.check_air then
		decor_def.flags = decor_def.flags..",force_placement"
	end

	if b.spawn_replace_node then
		decor_def.place_offset_y = -1
	end

	if b.random_facedir then
		decor_def.param2 =     math.min(b.random_facedir[1], b.random_facedir[2])
		decor_def.param2_max = math.max(b.random_facedir[1], b.random_facedir[2])
	end

	return decor_def
end
