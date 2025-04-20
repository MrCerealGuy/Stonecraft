
local S = minetest.get_translator("farming")

-- item/seed

minetest.register_craftitem("farming:melon_slice", {
	description = S("Melon Slice"),
	inventory_image = "farming_melon_slice.png",
	groups = {compostability = 48, seed = 2, food_melon_slice = 1},
	on_use = minetest.item_eat(2),

	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:melon_1")
	end
})

farming.add_eatable("farming:melon_slice", 2)

-- crop definition

local def = {
	description = S("Melon") .. S(" Crop"),
	drawtype = "plantlike",
	tiles = {"farming_melon_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = farming.select,
	groups = {
		handy = 1, snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	_mcl_hardness = farming.mcl_hardness,
	is_ground_content = false,
	sounds = farming.node_sound_leaves_defaults()
}

-- stage 1

minetest.register_node("farming:melon_1", table.copy(def))

-- stage 2

def.tiles = {"farming_melon_2.png"}
minetest.register_node("farming:melon_2", table.copy(def))

-- stage 3

def.tiles = {"farming_melon_3.png"}
minetest.register_node("farming:melon_3", table.copy(def))

-- stage 4

def.tiles = {"farming_melon_4.png"}
minetest.register_node("farming:melon_4", table.copy(def))

-- stage 5

def.tiles = {"farming_melon_5.png"}
minetest.register_node("farming:melon_5", table.copy(def))

-- stage 6

def.tiles = {"farming_melon_6.png"}
minetest.register_node("farming:melon_6", table.copy(def))

-- stage 7

def.tiles = {"farming_melon_7.png"}
minetest.register_node("farming:melon_7", table.copy(def))

-- stage 8 (final)

minetest.register_node("farming:melon_8", {
	description = S("Melon"),
	tiles = {
		"farming_melon_top.png",
		"farming_melon_bottom.png",
		"farming_melon_side.png"
	},
	groups = {
		food_melon = 1, handy = 1, snappy = 3, choppy = 3, oddly_breakable_by_hand = 2,
		flammable = 2, plant = 1, compostability = 65
	},
	is_ground_content = false,
	drop = "farming:melon_8",
	sounds = farming.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
	_mcl_hardness = 0.8,
	_mcl_blast_resistance = 1
})

-- add to registered_plants

farming.registered_plants["farming:melon"] = {
	crop = "farming:melon",
	seed = "farming:melon_slice",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 8
}

-- mapgen

minetest.register_decoration({
	deco_type = "simple",
	place_on = {
		"default:dirt_with_grass", "default:dirt_with_dry_grass",
		"default:dirt_with_rainforest_litter", "mcl_core:dirt_with_grass"
	},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = farming.melon,
		spread = {x = 100, y = 100, z = 100},
		seed = 790,
		octaves = 3,
		persist = 0.6
	},
	y_min = 1, y_max = 3,
	decoration = "farming:melon_8",
	spawn_by = {"group:water", "group:sand"}, num_spawn_by = 1
})
