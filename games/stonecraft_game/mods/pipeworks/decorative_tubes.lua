local S = minetest.get_translator("pipeworks")

local straight = function(pos, node, velocity, stack) return {velocity} end

minetest.register_node("pipeworks:steel_block_embedded_tube", {
	description = S("Airtight steelblock embedded tube"),
	tiles = {
		"default_steel_block.png", "default_steel_block.png",
		"default_steel_block.png", "default_steel_block.png",
		"default_steel_block.png^pipeworks_tube_connection_metallic.png",
		"default_steel_block.png^pipeworks_tube_connection_metallic.png",
		},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1, oddly_breakable_by_hand = 1, tubedevice = 1},
	legacy_facedir_simple = true,
	sounds = default.node_sound_stone_defaults(),
	tube = {
		connect_sides = {front = 1, back = 1,},
		priority = 50,
		can_go = straight,
		can_insert = function(pos, node, stack, direction)
			local dir = minetest.facedir_to_dir(node.param2)
			return vector.equals(dir, direction) or vector.equals(vector.multiply(dir, -1), direction)
		end,
	},
	after_place_node = pipeworks.after_place,
	after_dig_node = pipeworks.after_dig,
	on_rotate = pipeworks.on_rotate,
})

minetest.register_craft( {
	output = "pipeworks:steel_block_embedded_tube 1",
	recipe = {
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" },
		{ "default:steel_ingot", "pipeworks:tube_1", "default:steel_ingot" },
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" }
	},
})

local pane_box = {
	type = "fixed",
	fixed = {
		{ -9/64, -9/64, -8/16, 9/64, 9/64, 8/16 }, -- tube
		{ -8/16, -8/16, -1/16, 8/16, 8/16, 1/16 } -- pane
	}
}

local texture_alpha_mode = minetest.features.use_texture_alpha_string_modes
	and "clip" or true

minetest.register_node("pipeworks:steel_pane_embedded_tube", {
	drawtype = "nodebox",
	description = S("Airtight panel embedded tube"),
	tiles = {
		"pipeworks_pane_embedded_tube_sides.png^[transformR90",
		"pipeworks_pane_embedded_tube_sides.png^[transformR90",
		"pipeworks_pane_embedded_tube_sides.png",
		"pipeworks_pane_embedded_tube_sides.png",
		"pipeworks_pane_embedded_tube_ends.png", "pipeworks_pane_embedded_tube_ends.png",
		},
	use_texture_alpha = texture_alpha_mode,
	node_box = pane_box,
	selection_box = pane_box,
	collision_box = pane_box,
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1, oddly_breakable_by_hand = 1, tubedevice = 1},
	legacy_facedir_simple = true,
	sounds = default.node_sound_stone_defaults(),
	tube = {
		connect_sides = {front = 1, back = 1,},
		priority = 50,
		can_go = straight,
		can_insert = function(pos, node, stack, direction)
			local dir = minetest.facedir_to_dir(node.param2)
			return vector.equals(dir, direction) or vector.equals(vector.multiply(dir, -1), direction)
		end,
	},
	after_place_node = pipeworks.after_place,
	after_dig_node = pipeworks.after_dig,
	on_rotate = pipeworks.on_rotate,
})

minetest.register_craft( {
	output = "pipeworks:steel_pane_embedded_tube 1",
	recipe = {
		{ "", "default:steel_ingot", "" },
		{ "", "pipeworks:tube_1", "" },
		{ "", "default:steel_ingot", "" }
	},
})
