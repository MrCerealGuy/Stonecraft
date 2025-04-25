local S = minetest.get_translator("livingdesert")

-- Yurt Building Parts

minetest.register_node("livingdesert:yurt_outside", {
	description = S("Yurt lower outside part"),
	tiles = {
		"livingdesert_yurt_outside.png",
		"livingdesert_yurt_outside.png",
		"livingdesert_yurt_outside_top.png"
	},
groups = {snappy = 2, choppy = 2, oddly_breakable_by_hand = 3,
				flammable = 3, wool = 1},
		sounds = default.node_sound_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

minetest.register_node("livingdesert:yurt_outsidesecond", {
	description = S("Yurt second lower outside part"),
	tiles = {
		"livingdesert_yurt_outside_top.png",
		"livingdesert_yurt_outside_top.png",
		"livingdesert_yurt_outside.png"
	},
groups = {snappy = 2, choppy = 2, oddly_breakable_by_hand = 3,
				flammable = 3, wool = 1},
		sounds = default.node_sound_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

minetest.register_node("livingdesert:yurt_outside2", {
	description = S("Yurt upper outside part"),
	tiles = {
		"livingdesert_yurt_outside2_top.png",
		"livingdesert_yurt_outside2_top.png",
		"livingdesert_yurt_outside2.png"
	},
groups = {snappy = 2, choppy = 2, oddly_breakable_by_hand = 3,
				flammable = 3, wool = 1},
		sounds = default.node_sound_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

minetest.register_node("livingdesert:yurt_inside", {
	description = S("Yurt lower inside part"),
	tiles = {"livingdesert_yurt_inside.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("livingdesert:yurt_inside2", {
	description = S("Yurt upper inside part"),
	tiles = {"livingdesert_yurt_inside2.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "livingdesert:yurt_outside 4",
	recipe = {{"default:stick", "livingdesert:pine_trunk", "default:stone", "livingdesert:pine_wood"}}
})

minetest.register_craft({
	output = "livingdesert:yurt_outside2 4",
	recipe = {{"default:stick", "wool:white", "livingdesert:pine_wood", "default:stone"}}
})

minetest.register_craft({
	output = "livingdesert:yurt_outsidesecond 4",
	recipe = {{"default:stick", "wool:white", "livingdesert:pine_wood"}}
})

minetest.register_craft({
	output = "livingdesert:yurt_inside 4",
	recipe = {{"default:stick", "livingdesert:pine_wood"}}
})

minetest.register_craft({
	output = "livingdesert:yurt_inside2 4",
	recipe = {{"default:stick", "wool:white"}}
})
