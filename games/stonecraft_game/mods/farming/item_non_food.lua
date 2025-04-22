
local S = minetest.get_translator("farming")

-- saucepan

minetest.register_craftitem("farming:saucepan", {
	description = S("Saucepan"),
	inventory_image = "farming_saucepan.png",
	groups = {food_saucepan = 1, flammable = 2}
})

-- cooking pot

minetest.register_craftitem("farming:pot", {
	description = S("Cooking Pot"),
	inventory_image = "farming_pot.png",
	groups = {food_pot = 1, flammable = 2}
})

-- baking tray

minetest.register_craftitem("farming:baking_tray", {
	description = S("Baking Tray"),
	inventory_image = "farming_baking_tray.png",
	groups = {food_baking_tray = 1, flammable = 2}
})

-- skillet

minetest.register_craftitem("farming:skillet", {
	description = S("Skillet"),
	inventory_image = "farming_skillet.png",
	groups = {food_skillet = 1, flammable = 2}
})

-- mortar & pestle

minetest.register_craftitem("farming:mortar_pestle", {
	description = S("Mortar and Pestle"),
	inventory_image = "farming_mortar_pestle.png",
	groups = {food_mortar_pestle = 1, flammable = 2}
})

-- cutting board

minetest.register_craftitem("farming:cutting_board", {
	description = S("Cutting Board"),
	inventory_image = "farming_cutting_board.png",
	groups = {food_cutting_board = 1, flammable = 2}
})

-- juicer

minetest.register_craftitem("farming:juicer", {
	description = S("Juicer"),
	inventory_image = "farming_juicer.png",
	groups = {food_juicer = 1, flammable = 2}
})

-- glass mixing bowl

minetest.register_craftitem("farming:mixing_bowl", {
	description = S("Glass Mixing Bowl"),
	inventory_image = "farming_mixing_bowl.png",
	groups = {food_mixing_bowl = 1, flammable = 2}
})

-- Ethanol (thanks to JKMurray for this idea)

minetest.register_node("farming:bottle_ethanol", {
	description = S("Bottle of Ethanol"),
	drawtype = "plantlike",
	tiles = {"farming_bottle_ethanol.png"},
	inventory_image = "farming_bottle_ethanol.png",
	wield_image = "farming_bottle_ethanol.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1, handy = 1},
	sounds = farming.node_sound_glass_defaults()
})

-- straw

minetest.register_node("farming:straw", {
	description = S("Straw"),
	tiles = {"farming_straw.png"},
	is_ground_content = false,
	groups = {handy = 1, snappy = 3, flammable = 4, fall_damage_add_percent = -30},
	sounds = farming.node_sound_leaves_defaults(),
	_mcl_hardness = 0.8,
	_mcl_blast_resistance = 1
})

-- weed

minetest.register_node("farming:weed", {
	description = S("Weed"),
	drawtype = "plantlike",
	tiles = {"farming_weed.png"},
	inventory_image = "farming_weed.png",
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 2,
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	waving = 1,
	selection_box = farming.select,
	groups = {snappy = 3, flammable = 4, plant = 1, attached_node = 1},
	_mcl_hardness = farming.mcl_hardness,
	is_ground_content = false,
	sounds = farming.node_sound_leaves_defaults()
})

-- weed bale

minetest.register_node("farming:weed_bale", {
	description = S("Weed Bale"),
	tiles = {
		"farming_weed_bale_top.png", "farming_weed_bale_top.png",
		"farming_weed_bale_side.png"
	},
	paramtype2 = "facedir",
	groups = {handy = 1, snappy = 3, flammable = 4, fall_damage_add_percent = -30},
	sounds = farming.node_sound_leaves_defaults(),
	_mcl_hardness = 0.8,
	_mcl_blast_resistance = 1
})

-- hemp oil

minetest.register_node("farming:hemp_oil", {
	description = S("Bottle of Hemp Oil"),
	drawtype = "plantlike",
	tiles = {"farming_hemp_oil.png"},
	inventory_image = "farming_hemp_oil.png",
	wield_image = "farming_hemp_oil.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed", fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {
		food_oil = 1, vessel = 1, dig_immediate = 3, attached_node = 1,
		compostability = 45, handy = 1
	},
	sounds = farming.node_sound_glass_defaults()
})

-- hemp fibre

minetest.register_craftitem("farming:hemp_fibre", {
	description = S("Hemp Fibre"),
	inventory_image = "farming_hemp_fibre.png",
	groups = {compostability = 55}
})

-- hemp block

minetest.register_node("farming:hemp_block", {
	description = S("Hemp Block"),
	tiles = {"farming_hemp_block.png"},
	paramtype = "light",
	groups = {
		axey = 1, handy = 1, snappy = 2, oddly_breakable_by_hand = 1, flammable = 2,
		compostability = 85
	},
	is_ground_content = false,
	sounds =  farming.node_sound_leaves_defaults(),
	_mcl_hardness = 0.8,
	_mcl_blast_resistance = 1
})

-- hemp rope

minetest.register_node("farming:hemp_rope", {
	description = S("Hemp Rope"),
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
	tiles = {"farming_hemp_rope.png"},
	wield_image = "farming_hemp_rope.png",
	inventory_image = "farming_hemp_rope.png",
	drawtype = "plantlike",
	groups = {
		handy = 1, axey = 1, swordy = 1, flammable = 2, choppy = 3,
		oddly_breakable_by_hand = 3, compostability = 55
	},
	is_ground_content = false,
	sounds =  farming.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed", fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7}
	},
	_mcl_hardness = 0.8,
	_mcl_blast_resistance = 1
})

--- Wooden scarecrow base

minetest.register_node("farming:scarecrow_bottom", {
	description = S("Scarecrow Bottom"),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	tiles = {"default_wood.png"},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-1/16, -8/16, -1/16, 1/16, 8/16, 1/16},
			{-12/16, 4/16, -1/16, 12/16, 2/16, 1/16},
		}
	},
	groups = {axey = 1, handy = 1, snappy = 3, flammable = 2},
	is_ground_content = false,
	_mcl_hardness = 0.8,
	_mcl_blast_resistance = 1
})

--= Items we shouldn't add when using Mineclonia/VoxeLibre

if not farming.mcl then

	-- Wooden bowl

	minetest.register_craftitem("farming:bowl", {
		description = S("Wooden Bowl"),
		inventory_image = "farming_bowl.png",
		groups = {food_bowl = 1, flammable = 2}
	})

	-- String

	minetest.register_craftitem("farming:string", {
		description = S("String"),
		inventory_image = "farming_string.png",
		groups = {flammable = 2}
	})

	-- Jack 'O Lantern

	minetest.register_node("farming:jackolantern", {
		description = S("Jack 'O Lantern (punch to turn on and off)"),
		tiles = {
			"farming_pumpkin_bottom.png^farming_pumpkin_top.png",
			"farming_pumpkin_bottom.png",
			"farming_pumpkin_side.png",
			"farming_pumpkin_side.png",
			"farming_pumpkin_side.png",
			"farming_pumpkin_side.png^farming_pumpkin_face_off.png"
		},
		paramtype2 = "facedir",
		groups = {
			handy = 1, snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2
		},
		is_ground_content = false,
		sounds = farming.node_sound_wood_defaults(),

		on_punch = function(pos, node, puncher)
			local name = puncher:get_player_name() or ""
			if minetest.is_protected(pos, name) then return end
			node.name = "farming:jackolantern_on"
			minetest.swap_node(pos, node)
		end,
		_mcl_hardness = 0.8,
		_mcl_blast_resistance = 1
	})

	minetest.register_node("farming:jackolantern_on", {
		tiles = {
			"farming_pumpkin_bottom.png^farming_pumpkin_top.png",
			"farming_pumpkin_bottom.png",
			"farming_pumpkin_side.png",
			"farming_pumpkin_side.png",
			"farming_pumpkin_side.png",
			"farming_pumpkin_side.png^farming_pumpkin_face_on.png"
		},
		light_source = minetest.LIGHT_MAX - 1,
		paramtype2 = "facedir",
		groups = {
			handy = 1, snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2,
			not_in_creative_inventory = 1
		},
		is_ground_content = false,
		sounds = farming.node_sound_wood_defaults(),
		drop = "farming:jackolantern",

		on_punch = function(pos, node, puncher)
			local name = puncher:get_player_name() or ""
			if minetest.is_protected(pos, name) then return end
			node.name = "farming:jackolantern"
			minetest.swap_node(pos, node)
		end,
		_mcl_hardness = 0.8,
		_mcl_blast_resistance = 1
	})
end
