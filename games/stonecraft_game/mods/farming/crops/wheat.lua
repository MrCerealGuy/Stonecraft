
local S = minetest.get_translator("farming")

-- seed

minetest.register_node("farming:seed_wheat", {
	description = S("Wheat Seed"),
	tiles = {"farming_wheat_seed.png"},
	inventory_image = "farming_wheat_seed.png",
	wield_image = "farming_wheat_seed.png",
	drawtype = "signlike",
	groups = {
		handy = 1, seed = 1, snappy = 3, attached_node = 1, flammable = 4, growing = 1
	},
	_mcl_hardness = farming.mcl_hardness,
	is_ground_content = false,
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	sunlight_propagates = true,
	selection_box = farming.select,
	next_plant = "farming:wheat_1",

	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:seed_wheat")
	end,

	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name = "farming:wheat_1", param2 = 3})
	end
})

-- item

minetest.register_craftitem("farming:wheat", {
	description = S("Wheat"),
	inventory_image = "farming_wheat.png",
	groups = {food_wheat = 1, flammable = 4}
})

-- crop definition

local def = {
	description = S("Wheat") .. S(" Crop"),
	drawtype = "plantlike",
	tiles = {"farming_wheat_1.png"},
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 3,
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop = "",
	waving = 1,
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 4, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	_mcl_hardness = farming.mcl_hardness,
	is_ground_content = false,
	sounds = farming.node_sound_leaves_defaults()
}

-- stage 1

minetest.register_node("farming:wheat_1", table.copy(def))

-- stage 2

def.tiles = {"farming_wheat_2.png"}
minetest.register_node("farming:wheat_2", table.copy(def))

-- stage 3

def.tiles = {"farming_wheat_3.png"}
minetest.register_node("farming:wheat_3", table.copy(def))

-- stage 4

def.tiles = {"farming_wheat_4.png"}
minetest.register_node("farming:wheat_4", table.copy(def))

-- stage 5

def.tiles = {"farming_wheat_5.png"}
minetest.register_node("farming:wheat_5", table.copy(def))

-- stage 6

def.tiles = {"farming_wheat_6.png"}
def.drop = {
	items = {
		{items = {"farming:wheat"}, rarity = 2},
		{items = {"farming:seed_wheat"}, rarity = 2}
	}
}
minetest.register_node("farming:wheat_6", table.copy(def))

-- stage 7

def.tiles = {"farming_wheat_7.png"}
def.drop = {
	items = {
		{items = {"farming:wheat"}, rarity = 2},
		{items = {"farming:seed_wheat"}, rarity = 1}
	}
}
minetest.register_node("farming:wheat_7", table.copy(def))

-- stage 8 (final)

def.tiles = {"farming_wheat_8.png"}
def.groups.growing = nil
def.selection_box = farming.select_final
def.drop = {
	items = {
		{items = {"farming:wheat 2"}, rarity = 1},
		{items = {"farming:wheat"}, rarity = 2},
		{items = {"farming:seed_wheat 2"}, rarity = 1},
		{items = {"farming:seed_wheat"}, rarity = 2}
	}
}
minetest.register_node("farming:wheat_8", table.copy(def))

-- add to registered_plants

farming.registered_plants["farming:wheat"] = {
	crop = "farming:wheat",
	seed = "farming:seed_wheat",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 8
}
