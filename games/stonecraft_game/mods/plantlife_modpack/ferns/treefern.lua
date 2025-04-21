-----------------------------------------------------------------------------------------------
-- Ferns - Tree Fern 0.1.1
-----------------------------------------------------------------------------------------------
-- by Mossmanikin
-- Contains code from:		biome_lib
-- Looked at code from:		default	, trees
-----------------------------------------------------------------------------------------------

-- support for i18n
local S = minetest.get_translator("ferns")

assert(abstract_ferns.config.enable_treefern == true)

function abstract_ferns.can_grow_tree_fern(pos)
	local node_name = minetest.get_node(pos).name
	if node_name ~= "air" and node_name ~= "ferns:sapling_tree_fern" and node_name ~= "default:junglegrass" then
		return false
	end

	local below_name = minetest.get_node(vector.new(pos.x, pos.y - 1, pos.z)).name
	if minetest.get_item_group(below_name, "soil") == 0 and minetest.get_item_group(below_name, "sand") == 0 then
		return false
	end

	local light = minetest.get_node_light(pos, 0.5)
	if light <= 8 then
		return false
	end

	return true
end

abstract_ferns.grow_tree_fern = function(pos)

	local pos_aux = {x = pos.x, y = pos.y + 1, z = pos.z}
	local name = minetest.get_node(pos_aux).name
	if name ~= "air" and name ~= "ferns:sapling_tree_fern"
			and name ~= "default:junglegrass" then
		return
	end

	local size = math.random(1, 4) + math.random(1, 4)
	if (size > 5) then
		size = 10 - size
	end
	size = size + 1
	local crown = ({ "ferns:tree_fern_leaves", "ferns:tree_fern_leaves_02" })[math.random(1, 2)]

	local i = 1
	local brk = false
	while (i < size) do
		pos_aux.y = pos.y + i
		name = minetest.get_node(pos_aux).name
		if not (name == "air" or (i == 1 and name == "ferns:sapling_tree_fern")) then
			brk = true
			break
		end
		minetest.swap_node({x = pos.x, y = pos.y + i, z = pos.z}, { name = "ferns:fern_trunk" })
		i = i + 1
	end
	if not brk then
		minetest.swap_node({x = pos.x, y = pos.y + i - 1, z = pos.z}, { name = crown })
	end
end

-----------------------------------------------------------------------------------------------
-- TREE FERN LEAVES
-----------------------------------------------------------------------------------------------

-- TODO: Both of these nodes look the same?

minetest.register_node("ferns:tree_fern_leaves", {
	description = S("Tree Fern Crown (Dicksonia)"),
	drawtype = "plantlike",
	visual_scale = math.sqrt(8),
	paramtype = "light",
	paramtype2 = "facedir",
	--tiles = {"[combine:32x32:0,0=top_left.png:0,16=bottom_left.png:16,0=top_right.png:16,16=bottom_right.png"},
	tiles = {"ferns_fern_tree.png"},
	inventory_image = "ferns_fern_tree_inv.png",
	walkable = false,
	groups = {snappy=3,flammable=2,attached_node=1},
	is_ground_content = false,
	drop = {
		max_items = 2,
		items = {
			{
				-- occasionally, drop a second sapling instead of leaves
				-- (extra saplings can also be obtained by replanting and
				--  reharvesting leaves)
				items = {"ferns:sapling_tree_fern"},
				rarity = 10,
			},
			{
				items = {"ferns:sapling_tree_fern"},
			},
			{
				items = {"ferns:tree_fern_leaves"},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
	},
})
minetest.register_node("ferns:tree_fern_leaves_02", {
	drawtype = "plantlike",
	visual_scale = math.sqrt(8),
	paramtype = "light",
	tiles = {"ferns_fern_big.png"},
	walkable = false,
	groups = {snappy=3,flammable=2,attached_node=1,not_in_creative_inventory=1},
	is_ground_content = false,
	drop = {
		max_items = 2,
		items = {
			{
				-- occasionally, drop a second sapling instead of leaves
				-- (extra saplings can also be obtained by replanting and
				--  reharvesting leaves)
				items = {"ferns:sapling_tree_fern"},
				rarity = 10,
			},
			{
				items = {"ferns:sapling_tree_fern"},
			},
			{
				items = {"ferns:tree_fern_leaves"},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
	},
})
-----------------------------------------------------------------------------------------------
-- FERN TRUNK
-----------------------------------------------------------------------------------------------
minetest.register_node("ferns:fern_trunk", {
	description = S("Fern Trunk (Dicksonia)"),
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {
		"ferns_fern_trunk_top.png",
		"ferns_fern_trunk_top.png",
		"ferns_fern_trunk.png"
	},
	use_texture_alpha = "clip",
	node_box = {
		type = "fixed",
		fixed = {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},
	},
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {tree=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	is_ground_content = false,
	sounds = default.node_sound_wood_defaults(),
	after_destruct = function(pos,oldnode)
        local node = minetest.get_node({x=pos.x,y=pos.y+1,z=pos.z})
        if node.name == "ferns:fern_trunk" then
            minetest.dig_node({x=pos.x,y=pos.y+1,z=pos.z})
            minetest.add_item(pos,"ferns:fern_trunk")
        end
    end,
})

-----------------------------------------------------------------------------------------------
-- TREE FERN SAPLING
-----------------------------------------------------------------------------------------------
minetest.register_node("ferns:sapling_tree_fern", {
	description = S("Tree Fern Sapling (Dicksonia)"),
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"ferns_sapling_tree_fern.png"},
	inventory_image = "ferns_sapling_tree_fern.png",
	walkable = false,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1,sapling=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
	},
})
-- abm
minetest.register_abm({
	nodenames = "ferns:sapling_tree_fern",
	interval = 1000,
	chance = 4,
	action = function(pos, node, _, _)
		if abstract_ferns.can_grow_tree_fern(pos) then
			abstract_ferns.grow_tree_fern({x = pos.x, y = pos.y-1, z = pos.z})
		end
    end
})

-----------------------------------------------------------------------------------------------
-- GENERATE TREE FERN
-----------------------------------------------------------------------------------------------

-- in jungles
if abstract_ferns.config.enable_treeferns_in_jungle == true then
	biome_lib.register_on_generate({
		surface = {
			"default:dirt_with_grass",
			"default:dirt_with_rainforest_litter", -- minetest >= 0.4.16
			"default:sand",
			"default:desert_sand",
		},
		max_count = 35,--27,
		avoid_nodes = {"default:tree"},
		avoid_radius = 4,
		rarity = 50,
		seed_diff = 329,
		min_elevation = -10,
		near_nodes = {"default:jungletree"},
		near_nodes_size = 6,
		near_nodes_vertical = 2,--4,
		near_nodes_count = 1,
		plantlife_limit = -0.9,
		humidity_max = -1.0,
		humidity_min = 0.4,
		temp_max = -0.5,
		temp_min = 0.13,
	},
	abstract_ferns.grow_tree_fern
	)
end

-- for oases & tropical beaches
if abstract_ferns.config.enable_treeferns_in_oases == true then
	biome_lib.register_on_generate({
		surface = {
			"default:sand"--,
			--"default:desert_sand"
		},
		max_count = 35,
		rarity = 50,
		seed_diff = 329,
		neighbors = {"default:desert_sand"},
		ncount = 1,
		min_elevation = 1,
		near_nodes = {"default:water_source","default:river_water_source"},
		near_nodes_size = 2,
		near_nodes_vertical = 1,
		near_nodes_count = 1,
		plantlife_limit = -0.9,
		humidity_max = -1.0,
		humidity_min = 1.0,
		temp_max = -1.0,
		temp_min = 1.0,
	},
	abstract_ferns.grow_tree_fern
)
end
