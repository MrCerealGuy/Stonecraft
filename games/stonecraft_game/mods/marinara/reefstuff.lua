local S = minetest.get_translator("marinara")

-- soft corals

minetest.register_node("marinara:softcoral_yellow", {
	description = S("Yellow Soft Coral"),
	drawtype = "plantlike_rooted",
	waving = 1,
        visual_scale = 2.0,
	paramtype = "light",
	tiles = {"marinara_hardcoral.png"},
special_tiles = {{name = "marinara_softcoral_yellow.png", tileable_vertical = true, waving = 1, animation = {type="vertical_frames", length = 2}}},
	inventory_image = "marinara_softcoral_yellow_inv.png",
	wield_image = "marinara_softcoral_yellow_inv.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "marinara:hardcoral",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),


	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "marinara:hardcoral"})
	end,
})

minetest.register_node("marinara:softcoral_white", {
	description = S("White Soft Coral"),
	drawtype = "plantlike_rooted",
	waving = 1,
        visual_scale = 2.0,
	paramtype = "light",
	tiles = {"marinara_hardcoral.png"},
special_tiles = {{name = "marinara_softcoral_white.png", tileable_vertical = true, waving = 1, animation = {type="vertical_frames", length = 2}}},
	inventory_image = "marinara_softcoral_white_inv.png",
	wield_image = "marinara_softcoral_white_inv.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "marinara:hardcoral",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),


	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "marinara:hardcoral"})
	end,
})

minetest.register_node("marinara:softcoral_red", {
	description = S("Red Soft Coral"),
	drawtype = "plantlike_rooted",
	waving = 1,
        visual_scale = 2.0,
	paramtype = "light",
	tiles = {"marinara_hardcoral.png"},
special_tiles = {{name = "marinara_softcoral_red.png", tileable_vertical = true, waving = 1}},
	inventory_image = "marinara_softcoral_red.png",
	wield_image = "marinara_softcoral_red.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "marinara:hardcoral",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),


	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "marinara:hardcoral"})
	end,
})

minetest.register_node("marinara:softcoral_green", {
	description = S("Green Soft Coral"),
	drawtype = "plantlike_rooted",
	waving = 1,
        visual_scale = 1.0,
	paramtype = "light",
	tiles = {"marinara_hardcoral.png"},
special_tiles = {{name = "marinara_softcoral_green.png", tileable_vertical = true, waving = 1}},
	inventory_image = "marinara_softcoral_green.png",
	wield_image = "marinara_softcoral_green.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "marinara:hardcoral",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),


	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "marinara:hardcoral"})
	end,
})

minetest.register_node("marinara:softcoral", {
	description = S("Soft Coral"),
	drawtype = "plantlike_rooted",
	waving = 1,
        visual_scale = 1.0,
	paramtype = "light",
	tiles = {"marinara_hardcoral.png"},
special_tiles = {{name = "marinara_softcoral.png", tileable_vertical = true, waving = 1}},
	inventory_image = "marinara_softcoral.png",
	wield_image = "marinara_softcoral_green.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "marinara:hardcoral",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),


	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "marinara:hardcoral"})
	end,
})

minetest.register_node("marinara:softcoral_brown", {
	description = S("Brown Soft Coral"),
	drawtype = "plantlike_rooted",
	waving = 1,
        visual_scale = 2.0,
	paramtype = "light",
	tiles = {"marinara_hardcoral.png"},
special_tiles = {{name = "marinara_softcoral_brown.png", tileable_vertical = true, waving = 1, animation = {type="vertical_frames", length = 2}}},
	inventory_image = "marinara_softcoral_brown_inv.png",
	wield_image = "marinara_softcoral_brown_inv.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "marinara:hardcoral",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),


	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "marinara:hardcoral"})
	end,
})

--- sea anemones

minetest.register_node("marinara:seaanemone_tentacle", {
	description = S("Sea Anemone"),
	drawtype = "plantlike_rooted",
	waving = 1,
        visual_scale = 1.0,
	paramtype = "light",
	tiles = {"marinara_coastrock.png"},
special_tiles = {{name = "marinara_seaanemone_tentacle.png", tileable_vertical = true, waving = 1, animation = {type="vertical_frames", length = 3}}},
	inventory_image = "marinara_seaanemone_tentacle_inv.png",
	wield_image = "marinara_seaanemone_tentacle_inv.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "marinara:coastrock",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),


	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "marinara:coastrock"})
	end,
})

minetest.register_node("marinara:seaanemone_tentacle2", {
	description = S("Sea Anemone"),
	drawtype = "plantlike_rooted",
	waving = 1,
        visual_scale = 1.0,
	paramtype = "light",
	tiles = {"marinara_coastrock.png"},
special_tiles = {{name = "marinara_seaanemone_tentacle2.png", tileable_vertical = true, waving = 1, animation = {type="vertical_frames", length = 3}}},
	inventory_image = "marinara_seaanemone_tentacle2_inv.png",
	wield_image = "marinara_seaanemone_tentacle2_inv.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "marinara:coastrock",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),


	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "marinara:coastrock"})
	end,
})

minetest.register_node("marinara:seaanemone_tentacle3", {
	description = S("Sea Anemone"),
	drawtype = "plantlike_rooted",
	waving = 1,
        visual_scale = 1.0,
	paramtype = "light",
	tiles = {"marinara_coastrock.png"},
special_tiles = {{name = "marinara_seaanemone_tentacle3.png", tileable_vertical = true, waving = 1, animation = {type="vertical_frames", length = 3}}},
	inventory_image = "marinara_seaanemone_tentacle3_inv.png",
	wield_image = "marinara_seaanemone_tentacle3_inv.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "marinara:coastrock",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),


	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "marinara:coastrock"})
	end,
})

minetest.register_node("marinara:seaanemone_tentacle4", {
	description = S("Sea Anemone"),
	drawtype = "plantlike_rooted",
	waving = 1,
        visual_scale = 1.0,
	paramtype = "light",
	tiles = {"marinara_coastrock.png"},
special_tiles = {{name = "marinara_seaanemone_tentacle4.png", tileable_vertical = true, waving = 1, animation = {type="vertical_frames", length = 3}}},
	inventory_image = "marinara_seaanemone_tentacle4_inv.png",
	wield_image = "marinara_seaanemone_tentacle4_inv.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "marinara:coastrock",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),


	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "marinara:coastrock"})
	end,
})

--- fan worms

minetest.register_node("marinara:seaworm", {
	description = S("Sea Worm"),
	drawtype = "plantlike_rooted",
	waving = 1,
        visual_scale = 1.0,
	paramtype = "light",
	tiles = {"marinara_seapocks.png"},
special_tiles = {{name = "marinara_seaworm.png", tileable_vertical = true, waving = 1, animation = {type="vertical_frames", length = 3}}},
	inventory_image = "marinara_seaworm_inv.png",
	wield_image = "marinara_seaworm_inv.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "marinara:seapocks",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),


	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "marinara:seapocks"})
	end,
})

minetest.register_node("marinara:seaworm2", {
	description = S("Sea Worm"),
	drawtype = "plantlike_rooted",
	waving = 1,
        visual_scale = 1.0,
	paramtype = "light",
	tiles = {"marinara_seapocks.png"},
special_tiles = {{name = "marinara_seaworm2.png", tileable_vertical = true, waving = 1, animation = {type="vertical_frames", length = 3}}},
	inventory_image = "marinara_seaworm2_inv.png",
	wield_image = "marinara_seaworm2_inv.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "marinara:seapocks",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),


	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "marinara:seapocks"})
	end,
})

minetest.register_node("marinara:seaworm3", {
	description = S("Sea Worm"),
	drawtype = "plantlike_rooted",
	waving = 1,
        visual_scale = 2.0,
	paramtype = "light",
	tiles = {"marinara_seapocks.png"},
special_tiles = {{name = "marinara_seaworm3.png", tileable_vertical = true, waving = 1, animation = {type="vertical_frames", length = 12}}},
	inventory_image = "marinara_seaworm3_inv.png",
	wield_image = "marinara_seaworm3_inv.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "marinara:seapocks",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),


	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "marinara:seapocks"})
	end,
})

-- mussels and oisters

minetest.register_node("marinara:mussels", {
	description = S("Mussel Node"),
tiles = {
		{
			name = "marinara_mussles.png",
			animation = {type="vertical_frames", length = 4}
		}
	},
inventory_image = "marinara_mussles_inv.png",
	wield_image = "marinara_mussles_inv.png",
	groups = {cracky = 2},
	drop = "marinara:mussels",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	type = "cooking",
	output = "marinara:mussels_cooked",
	recipe = "marinara:mussels",
	cooktime = 5
})

minetest.register_craftitem("marinara:mussels_cooked", {
	description = S("Cooked Mussels"),
	inventory_image = "marinara_mussles_cooked.png",
	on_use = minetest.item_eat(8),
	groups = {food_meat = 1, flammable = 2}
})

minetest.register_node("marinara:oisterbank", {
	description = S("Oister Bank"),
	drawtype = "plantlike_rooted",
	waving = 0,
        visual_scale = 2.0,
	paramtype = "light",
	tiles = {"marinara_seapocks.png"},
special_tiles = {{name = "marinara_oisterbank.png", tileable_vertical = true}},
	inventory_image = "marinara_oisterbank.png",
	wield_image = "marinara_oisterbank.png",
	groups = {cracky = 2},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "marinara:seapocks",
	node_placement_prediction = "",
        drop = "marinara:raw_oisters",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_choppy", gain = 0.2},
		dug = {name = "default_dig_choppy", gain = 0.25},
	}),


	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "marinara:raw_oisters"})
	end,
})

minetest.register_node("marinara:raw_oisters", {
	description = S("Raw Oisters"),
	drawtype = "plantlike",
	tiles = {"marinara_rawoisters.png"},
	inventory_image = "marinara_rawoisters.png",
	wield_image = "marinara_rawoisters.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.31, -0.5, -0.31, 0.31, 0.5, 0.31}
	},
	groups = {food = 1, flammable = 2, fleshy = 3, dig_immediate = 3},
        drop = "marinara:raw_oisters",
	on_use = minetest.item_eat(6),
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = function(pos, placer)
		if placer:is_player() then
			minetest.set_node(pos, {name = "marinara:raw_oisters", param2 = 1})
		end
	end
})