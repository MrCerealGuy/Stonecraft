---------------------------------------------------------------------------------------
-- decoration and building material
---------------------------------------------------------------------------------------
-- * includes a wagon wheel that can be used as decoration on walls or to build (stationary) wagons
-- * dirt road - those are more natural in small old villages than cobble roads
-- * loam - no, old buildings are usually not built out of clay; loam was used
-- * straw - useful material for roofs
-- * glass pane - an improvement compared to fence posts as windows :-)
---------------------------------------------------------------------------------------

--[[

2018-01-28 added intllib support

--]]

-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

-- supported modes:
-- * simple: only a straight dirt road; no curves, junctions etc.
-- * flat: each node is a full node; junction, t-junction and corner are included
-- * nodebox: like flat - except that each node has a nodebox that fits to that road node
-- * mesh: like nodebox - except that it uses a nice roundish model
if( not( cottages_feldweg_mode )) then
	cottages_feldweg_mode = "mesh";
end

--- a nice dirt road for small villages or paths to fields
if( cottages_feldweg_mode == "simple" or cottages_feldweg_mode == "flat" ) then
	minetest.register_node("cottages:feldweg", {
		description = S("Dirt road"),
		tiles = {"cottages_feldweg.png","default_dirt.png", "default_dirt.png^default_grass_side.png"},
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults,
		is_ground_content = false,
	})
end

-- add crossing, t-junction and corner

--
-- flat - just textures, full blocks
--
if( cottages_feldweg_mode == "flat" ) then

	minetest.register_node("cottages:feldweg_crossing", {
		description = S("Dirt road crossing"),
		tiles = {"cottages_feldweg_kreuzung.png","default_dirt.png", "default_dirt.png^default_grass_side.png"},
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults,
		is_ground_content = false,
	})

	minetest.register_node("cottages:feldweg_t_junction", {
		description = S("Dirt road t junction"),
		tiles = {"cottages_feldweg_t-kreuzung.png^[transform2","default_dirt.png", "default_dirt.png^default_grass_side.png"},
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults,
		is_ground_content = false,
	})

	minetest.register_node("cottages:feldweg_curve", {
		description = S("Dirt road curve"),
		tiles = {"cottages_feldweg_ecke.png^[transform2","default_dirt.png", "default_dirt.png^default_grass_side.png"},
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults,
		is_ground_content = false,
	})

--
-- cube-style nodebox version
--
elseif( cottages_feldweg_mode == "nodebox" ) then
	minetest.register_node("cottages:feldweg", {
	        description = S("Dirt road"),
		tiles = {"cottages_feldweg_orig.png","default_dirt.png", "default_dirt.png^default_grass_side.png"},
		paramtype2 = "facedir",
		roups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults,
		is_ground_content = false,
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.5,  0.5, 0.5-2/16,  0.5},
				-- Rasenkanten
				{ -0.5,      0.5-2/16, -0.5,  -0.5+3/16, 0.5,  0.5},
				{  0.5-3/16, 0.5-2/16, -0.5,   0.5,      0.5,  0.5},
				-- uebergang zwischen Wagenspur und Rasenkante
				{ -0.5+3/16, 0.5-2/16, -0.5,  -0.5+4/16, 0.5-1/16,  0.5},
				{  0.5-4/16, 0.5-2/16, -0.5,   0.5-3/16, 0.5-1/16,  0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.5,  0.5, 0.5,  0.5},
			},
		},
	})

	minetest.register_node("cottages:feldweg_crossing", {
		description = S("Dirt road crossing"),
		tiles = {"cottages_feldweg_kreuzung.png","default_dirt.png", "default_dirt.png^default_grass_side.png"},
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults,
		is_ground_content = false,

		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.5,  0.5, 0.5-2/16,  0.5},
				-- Rasenkanten
				{ -0.5,      0.5-2/16, -0.5,  -0.5+3/16, 0.5, -0.5+3/16},
				{  0.5-3/16, 0.5-2/16, -0.5,   0.5,      0.5, -0.5+3/16},

				{ -0.5,      0.5-2/16, 0.5-3/16,  -0.5+3/16, 0.5,  0.5},
				{  0.5-3/16, 0.5-2/16, 0.5-3/16,   0.5,      0.5,  0.5},
				-- uebergang zwischen Wagenspur und Rasenkante
				{ -0.5+3/16, 0.5-2/16, -0.5,  -0.5+4/16, 0.5-1/16, -0.5+4/16},
				{  0.5-4/16, 0.5-2/16, -0.5,   0.5-3/16, 0.5-1/16, -0.5+4/16},

				{ -0.5+3/16, 0.5-2/16, 0.5-4/16,  -0.5+4/16, 0.5-1/16,  0.5},
				{  0.5-4/16, 0.5-2/16, 0.5-4/16,   0.5-3/16, 0.5-1/16,  0.5},


				{ -0.5,      0.5-2/16, -0.5+3/16, -0.5+3/16, 0.5-1/16, -0.5+4/16},
				{  0.5-3/16, 0.5-2/16, -0.5+3/16,  0.5,      0.5-1/16, -0.5+4/16},

				{ -0.5,      0.5-2/16, 0.5-4/16,  -0.5+3/16, 0.5-1/16,  0.5-3/16},
				{  0.5-3/16, 0.5-2/16, 0.5-4/16,   0.5,      0.5-1/16,  0.5-3/16},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.5,  0.5, 0.5,  0.5},
			},
		},
	})

	minetest.register_node("cottages:feldweg_t_junction", {
		description = S("Dirt road t junction"),
		tiles = {"cottages_feldweg_t-kreuzung.png^[transform2","default_dirt.png", "default_dirt.png^default_grass_side.png"},
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults,
		is_ground_content = false,

		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.5,  0.5, 0.5-2/16,  0.5},
				-- Rasenkanten
				{ -0.5,      0.5-2/16, -0.5,  -0.5+3/16, 0.5, -0.5+3/16},

				{ -0.5,      0.5-2/16, 0.5-3/16,  -0.5+3/16, 0.5,  0.5},
				-- Rasenkante seitlich durchgehend
				{  0.5-3/16, 0.5-2/16, -0.5,   0.5,      0.5,  0.5},
				-- uebergang zwischen Wagenspur und Rasenkante
				{ -0.5+3/16, 0.5-2/16, -0.5,  -0.5+4/16, 0.5-1/16, -0.5+4/16},

				{ -0.5+3/16, 0.5-2/16, 0.5-4/16,  -0.5+4/16, 0.5-1/16,  0.5},


				{ -0.5,      0.5-2/16, -0.5+3/16, -0.5+3/16, 0.5-1/16, -0.5+4/16},

				{ -0.5,      0.5-2/16, 0.5-4/16,  -0.5+3/16, 0.5-1/16,  0.5-3/16},
				-- Ueberganng seitlich durchgehend
				{  0.5-4/16, 0.5-2/16, -0.5,   0.5-3/16, 0.5-1/16,  0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.5,  0.5, 0.5,  0.5},
			},
		},
	})

	minetest.register_node("cottages:feldweg_curve", {
		description = S("Dirt road curve"),
		tiles = {"cottages_feldweg_ecke.png^[transform2","default_dirt.png", "default_dirt.png^default_grass_side.png"},
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults,
		is_ground_content = false,

		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.5,  0.5, 0.5-2/16,  0.5},
				-- Rasenkante vorne durchgehend
				{ -0.5,      0.5-2/16, -0.5,  0.5-3/16, 0.5, -0.5+3/16},

				-- Rasenkanten
				{ -0.5,      0.5-2/16, 0.5-3/16,  -0.5+3/16, 0.5,  0.5},
				-- Rasenkante seitlich durchgehend
				{  0.5-3/16, 0.5-2/16, -0.5,   0.5,      0.5,  0.5},
				-- uebergang zwischen Wagenspur und Rasenkante
				{ -0.5+3/16, 0.5-2/16, 0.5-4/16,  -0.5+4/16, 0.5-1/16,  0.5},


				-- Uebergang vorne durchgehend
				{ -0.5,      0.5-2/16, -0.5+3/16, 0.5-3/16, 0.5-1/16, -0.5+4/16},

				{ -0.5,      0.5-2/16, 0.5-4/16,  -0.5+3/16, 0.5-1/16,  0.5-3/16},
				-- Ueberganng seitlich durchgehend
				{  0.5-4/16, 0.5-2/16, -0.5,   0.5-3/16, 0.5-1/16,  0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.5,  0.5, 0.5,  0.5},
			},
		},
	})


--
-- the mesh version (rounded); provided and created by VanessaE
--
elseif( cottages_feldweg_mode == "mesh" ) then

	-- a nice dirt road for small villages or paths to fields
	minetest.register_node("cottages:feldweg", {
		description = S("Dirt road"),
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults,
		is_ground_content = false,
		tiles = {"cottages_feldweg_end.png","default_dirt.png^default_grass_side.png",
			"default_dirt.png", "default_grass.png",
			"cottages_feldweg_surface.png",
			"cottages_feldweg_surface.png^cottages_feldweg_edges.png"},
		paramtype = "light",
		drawtype = "mesh",
		mesh = "feldweg.obj",
	})


	minetest.register_node("cottages:feldweg_crossing", {
		description = S("Dirt road crossing"),
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults,
		is_ground_content = false,
		tiles = {"cottages_feldweg_end.png","default_dirt.png",
			"default_grass.png","cottages_feldweg_surface.png",
			"cottages_feldweg_surface.png^cottages_feldweg_edges.png"},
		paramtype = "light",
		drawtype = "mesh",
		mesh = "feldweg-crossing.obj",
	})

	minetest.register_node("cottages:feldweg_t_junction", {
		description = S("Dirt road t junction"),
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults,
		is_ground_content = false,
		tiles = {"cottages_feldweg_end.png","default_dirt.png^default_grass_side.png", "default_dirt.png",
			"default_grass.png","cottages_feldweg_surface.png",
			"cottages_feldweg_surface.png^cottages_feldweg_edges.png"},
		paramtype = "light",
		drawtype = "mesh",
		mesh = "feldweg-T-junction.obj",
	})

	minetest.register_node("cottages:feldweg_curve", {
		description = S("Dirt road curve"),
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults,
		is_ground_content = false,
		tiles = {"default_dirt.png^default_grass_side.png","default_grass.png",
			"default_dirt.png^default_grass_side.png","cottages_feldweg_surface.png",
			"default_dirt.png","cottages_feldweg_surface.png^cottages_feldweg_edges.png"},
		paramtype = "light",
		drawtype = "mesh",
		mesh = "feldweg-curve.obj",
	})

	minetest.register_node("cottages:feldweg_end", {
		description = S("Dirt road end"),
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults,
		is_ground_content = false,
		tiles = {"cottages_feldweg_end.png","default_dirt.png^default_grass_side.png",
			"default_dirt.png", "default_grass.png",
			"cottages_feldweg_surface.png^cottages_feldweg_edges.png",
			"cottages_feldweg_surface.png"},
		paramtype = "light",
		drawtype = "mesh",
		mesh = "feldweg_end.obj",
	})
end


-- create stairs if possible
if( minetest.get_modpath("stairs") and stairs and stairs.register_stair_and_slab) then
   stairs.register_stair_and_slab("feldweg", "cottages:feldweg",
		{snappy=2,choppy=2,oddly_breakable_by_hand=2},
		{"cottages_feldweg.png","default_dirt.png", "default_grass.png","default_grass.png","cottages_feldweg.png","cottages_feldweg.png"},
		S("Dirt Road Stairs"),
		S("Dirt Road, half height"),
		default.node_sound_dirt_defaults())
end

if( cottages_feldweg_mode == "nodebox" or cottages_feldweg_mode == "mesh" ) then
        local box_slope = {
			type = "fixed",
			fixed = {
				{-0.5,  -0.5,  -0.5, 0.5, -0.25, 0.5},
				{-0.5, -0.25, -0.25, 0.5,     0, 0.5},
				{-0.5,     0,     0, 0.5,  0.25, 0.5},
				{-0.5,  0.25,  0.25, 0.5,   0.5, 0.5}
			}};

	local box_slope_long = {
			type = "fixed",
			fixed = {
				{-0.5,  -0.5,  -1.5, 0.5, -0.10, 0.5},
				{-0.5, -0.25,  -1.3, 0.5, -0.25, 0.5},
				{-0.5, -0.25,  -1.0, 0.5,     0, 0.5},
				{-0.5,     0,  -0.5, 0.5,  0.25, 0.5},
				{-0.5,  0.25,     0, 0.5,   0.5, 0.5}
			}};

	minetest.register_node("cottages:feldweg_slope", {
		description = S("Dirt road slope"),
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults,
		is_ground_content = false,
		tiles = {"cottages_feldweg_end.png","default_dirt.png^default_grass_side.png",
			"default_dirt.png", "default_grass.png",
			"cottages_feldweg_surface.png",
			"cottages_feldweg_surface.png^cottages_feldweg_edges.png"},
		paramtype = "light",
		drawtype = "mesh",
		mesh = "feldweg_slope.obj",

                collision_box = box_slope,
		selection_box = box_slope,
	})

	minetest.register_node("cottages:feldweg_slope_long", {
		description = S("Dirt road slope long"),
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		legacy_facedir_simple = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults,
		is_ground_content = false,
		tiles = {"cottages_feldweg_end.png","default_dirt.png^default_grass_side.png",
			"default_dirt.png", "default_grass.png",
			"cottages_feldweg_surface.png",
			"cottages_feldweg_surface.png^cottages_feldweg_edges.png"},
		paramtype = "light",
		drawtype = "mesh",
		mesh = "feldweg_slope_long.obj",
                collision_box = box_slope_long,
		selection_box = box_slope_long,
	})
end
