
local S = minetest.get_translator("ethereal")

-- register wood and placement helper

local function add_wood(name, def)

	if ethereal.wood_rotate then
		def.on_place = minetest.rotate_node
	else
		def.place_param2 = 0
	end

	minetest.register_node(name, def)
end

-- basandra

add_wood("ethereal:basandra_wood", {
	description = S("Basandra Wood"),
	tiles = {"ethereal_basandra_bush_wood.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_craft({
	output = "ethereal:basandra_wood 2",
	recipe = {{"ethereal:basandra_bush_stem"}}
})

-- sakura

local tmp = "ethereal:sakura_trunk"

minetest.register_node(tmp, {
	description = S("Sakura Trunk"),
	tiles = {
		"ethereal_sakura_trunk_top.png",
		"ethereal_sakura_trunk_top.png",
		"ethereal_sakura_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

add_wood("ethereal:sakura_wood", {
	description = S("Sakura Wood"),
	tiles = {"ethereal_sakura_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir"
})

minetest.register_craft({
	output = "ethereal:sakura_wood 4", recipe = {{tmp}}
})

minetest.register_node("ethereal:all_faces_sakura_trunk", {
	description = S("All-faces") .. " " .. S("Sakura Trunk"),
	tiles = {"ethereal_sakura_trunk_top.png"},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_craft({
	output = "ethereal:all_faces_sakura_trunk 8",
	recipe = { {tmp, tmp, tmp}, {tmp, "", tmp}, {tmp, tmp, tmp} }
})

-- willow

tmp = "ethereal:willow_trunk"

minetest.register_node(tmp, {
	description = S("Willow Trunk"),
	tiles = {
		"ethereal_willow_trunk_top.png",
		"ethereal_willow_trunk_top.png",
		"ethereal_willow_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

add_wood("ethereal:willow_wood", {
	description = S("Willow Wood"),
	tiles = {"ethereal_willow_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir"
})

minetest.register_craft({
	output = "ethereal:willow_wood 4", recipe = {{tmp}}
})

minetest.register_node("ethereal:all_faces_willow_trunk", {
	description = S("All-faces") .. " " .. S("Willow Trunk"),
	tiles = {"ethereal_willow_trunk_top.png"},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_craft({
	output = "ethereal:all_faces_willow_trunk 8",
	recipe = { {tmp, tmp, tmp}, {tmp, "", tmp}, {tmp, tmp, tmp} }
})

-- redwood

tmp = "ethereal:redwood_trunk"

minetest.register_node(tmp, {
	description = S("Redwood Trunk"),
	tiles = {
		"ethereal_redwood_trunk_top.png",
		"ethereal_redwood_trunk_top.png",
		"ethereal_redwood_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

add_wood("ethereal:redwood_wood", {
	description = S("Redwood Wood"),
	tiles = {"ethereal_redwood_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir"
})

minetest.register_craft({
	output = "ethereal:redwood_wood 4", recipe = {{tmp}}
})

minetest.register_node("ethereal:all_faces_redwood_trunk", {
	description = S("All-faces") .. " " .. S("Redwood Trunk"),
	tiles = {"ethereal_redwood_trunk_top.png"},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_craft({
	output = "ethereal:all_faces_redwood_trunk 8",
	recipe = { {tmp, tmp, tmp}, {tmp, "", tmp}, {tmp, tmp, tmp} }
})

-- frost

tmp = "ethereal:frost_tree"

minetest.register_node(tmp, {
	description = S("Frost Tree"),
	tiles = {
		"ethereal_frost_tree_top.png",
		"ethereal_frost_tree_top.png",
		"ethereal_frost_tree.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, puts_out_fire = 1},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

add_wood("ethereal:frost_wood", {
	description = S("Frost Wood"),
	tiles = {"ethereal_frost_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir"
})

minetest.register_craft({
	output = "ethereal:frost_wood 4", recipe = {{tmp}}
})

minetest.register_node("ethereal:all_faces_frost_tree", {
	description = S("All-faces") .. " " .. S("Frost Tree"),
	tiles = {"ethereal_frost_tree_top.png"},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, puts_out_fire = 2},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_craft({
	output = "ethereal:all_faces_frost_tree 8",
	recipe = { {tmp, tmp, tmp}, {tmp, "", tmp}, {tmp, tmp, tmp} }
})

-- healing

tmp = "ethereal:yellow_trunk"

minetest.register_node(tmp, {
	description = S("Healing Tree Trunk"),
	tiles = {
		"ethereal_yellow_tree_top.png",
		"ethereal_yellow_tree_top.png",
		"ethereal_yellow_tree.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, puts_out_fire = 1},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

add_wood("ethereal:yellow_wood", {
	description = S("Healing Tree Wood"),
	tiles = {"ethereal_yellow_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir"
})

minetest.register_craft({
	output = "ethereal:yellow_wood 4", recipe = {{tmp}}
})

minetest.register_node("ethereal:all_faces_yellow_trunk", {
	description = S("All-faces") .. " " .. S("Healing Trunk"),
	tiles = {"ethereal_yellow_tree_top.png"},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, puts_out_fire = 1},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_craft({
	output = "ethereal:all_faces_yellow_trunk 8",
	recipe = { {tmp, tmp, tmp}, {tmp, "", tmp}, {tmp, tmp, tmp} }
})

-- palm (thanks to VanessaE for palm textures)

tmp = "ethereal:palm_trunk"

minetest.register_node(tmp, {
	description = S("Palm Trunk"),
	tiles = {
		"moretrees_palm_trunk_top.png",
		"moretrees_palm_trunk_top.png",
		"moretrees_palm_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

add_wood("ethereal:palm_wood", {
	description = S("Palm Wood"),
	tiles = {"moretrees_palm_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir"
})

minetest.register_craft({
	output = "ethereal:palm_wood 4", recipe = {{tmp}}
})

minetest.register_node("ethereal:all_faces_palm_trunk", {
	description = S("All-faces") .. " " .. S("Palm Trunk"),
	tiles = {"moretrees_palm_trunk_top.png"},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_craft({
	output = "ethereal:all_faces_palm_trunk 8",
	recipe = { {tmp, tmp, tmp}, {tmp, "", tmp}, {tmp, tmp, tmp} }
})

-- banana

local tmp = "ethereal:banana_trunk"

minetest.register_node(tmp, {
	description = S("Banana Trunk"),
	tiles = {
		"ethereal_banana_trunk_top.png",
		"ethereal_banana_trunk_top.png",
		"ethereal_banana_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

add_wood("ethereal:banana_wood", {
	description = S("Banana Wood"),
	tiles = {"ethereal_banana_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir"
})

minetest.register_craft({
	output = "ethereal:banana_wood 4", recipe = {{tmp}}
})

minetest.register_node("ethereal:all_faces_banana_trunk", {
	description = S("All-faces") .. " " .. S("Banana Trunk"),
	tiles = {"ethereal_banana_trunk_top.png"},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_craft({
	output = "ethereal:all_faces_banana_trunk 8",
	recipe = { {tmp, tmp, tmp}, {tmp, "", tmp}, {tmp, tmp, tmp} }
})

-- scorched

tmp = "ethereal:scorched_tree"

minetest.register_node(tmp, {
	description = S("Scorched Tree"),
	tiles = {
		"ethereal_scorched_tree_top.png",
		"ethereal_scorched_tree_top.png",
		"ethereal_scorched_tree.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 1},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

minetest.register_craft({
	output = tmp .. " 8",
	recipe = {
		{"group:tree", "group:tree", "group:tree"},
		{"group:tree", "default:torch", "group:tree"},
		{"group:tree", "group:tree", "group:tree"}
	}
})

minetest.register_node("ethereal:all_faces_scorched_tree", {
	description = S("All-faces") .. " " .. S("Scorched Tree"),
	tiles = {"ethereal_scorched_tree_top.png"},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 1},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_craft({
	output = "ethereal:all_faces_scorched_tree 8",
	recipe = { {tmp, tmp, tmp}, {tmp, "", tmp}, {tmp, tmp, tmp} }
})

-- mushroom

tmp = "ethereal:mushroom_trunk"

minetest.register_node(tmp, {
	description = S("Mushroom Trunk"),
	tiles = {
		"ethereal_mushroom_trunk_top.png",
		"ethereal_mushroom_trunk_top.png",
		"ethereal_mushroom_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

minetest.register_node("ethereal:all_faces_mushroom_trunk", {
	description = S("All-faces") .. " " .. S("Mushroom Trunk"),
	tiles = {"ethereal_mushroom_trunk_top.png"},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_craft({
	output = "ethereal:all_faces_mushroom_trunk 8",
	recipe = { {tmp, tmp, tmp}, {tmp, "", tmp}, {tmp, tmp, tmp} }
})

-- birch (thanks to VanessaE for birch textures)

tmp = "ethereal:birch_trunk"

minetest.register_node(tmp, {
	description = S("Birch Trunk"),
	tiles = {
		"moretrees_birch_trunk_top.png",
		"moretrees_birch_trunk_top.png",
		"moretrees_birch_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

add_wood("ethereal:birch_wood", {
	description = S("Birch Wood"),
	tiles = {"moretrees_birch_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir"
})

minetest.register_craft({
	output = "ethereal:birch_wood 4", recipe = {{tmp}}
})

minetest.register_node("ethereal:all_faces_birch_trunk", {
	description = S("All-faces") .. " " .. S("Birch Trunk"),
	tiles = {"moretrees_birch_trunk_top.png"},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_craft({
	output = "ethereal:all_faces_birch_trunk 8",
	recipe = { {tmp, tmp, tmp}, {tmp, "", tmp}, {tmp, tmp, tmp} }
})

-- Bamboo

minetest.register_node("ethereal:bamboo", {
	description = S("Bamboo"),
	drawtype = "plantlike",
	tiles = {"ethereal_bamboo_trunk.png"},
	inventory_image = "ethereal_bamboo_trunk.png",
	wield_image = "ethereal_bamboo_trunk.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	selection_box = {
		type = "fixed", fixed = {-0.15, -0.5, -0.15, 0.15, 0.5, 0.15}
	},
	collision_box = {
		type = "fixed", fixed = {-0.15, -0.5, -0.15, 0.15, 0.5, 0.15}
	},
	groups = {choppy = 3, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),

	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
	end
})

minetest.register_craft({
	type = "fuel",
	recipe = "ethereal:bamboo",
	burntime = 2
})

-- olive

tmp = "ethereal:olive_trunk"

minetest.register_node(tmp, {
	description = S("Olive Trunk"),
	tiles = {
		"ethereal_olive_trunk_top.png",
		"ethereal_olive_trunk_top.png",
		"ethereal_olive_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

add_wood("ethereal:olive_wood", {
	description = S("Olive Wood"),
	tiles = {"ethereal_olive_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir"
})

minetest.register_craft({
	output = "ethereal:olive_wood 4", recipe = {{tmp}}
})

minetest.register_node("ethereal:all_faces_olive_trunk", {
	description = S("All-faces") .. " " .. S("Olive Trunk"),
	tiles = {"ethereal_olive_trunk_top.png"},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_craft({
	output = "ethereal:all_faces_olive_trunk 8",
	recipe = { {tmp, tmp, tmp}, {tmp, "", tmp}, {tmp, tmp, tmp} }
})
