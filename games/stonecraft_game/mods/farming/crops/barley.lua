
local S = minetest.get_translator("farming")

-- seed

minetest.register_node("farming:seed_barley", {
	description = S("Barley Seed"),
	tiles = {"farming_barley_seed.png"},
	inventory_image = "farming_barley_seed.png",
	wield_image = "farming_barley_seed.png",
	drawtype = "signlike",
	groups = {
		handy = 1, compostability = 48, seed = 1, snappy = 3, attached_node = 1,
		growing = 1
	},
	_mcl_hardness = farming.mcl_hardness,
	is_ground_content = false,
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	sunlight_propagates = true,
	next_plant = "farming:barley_1",
	selection_box = farming.select,

	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:seed_barley")
	end,

	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name = "farming:barley_1", param2 = 3})
	end
})

-- item

minetest.register_craftitem("farming:barley", {
	description = S("Barley"),
	inventory_image = "farming_barley.png",
	groups = {food_barley = 1, flammable = 2, compostability = 65}
})

-- crop definition

local def = {
	description = S("Barley") .. S(" Crop"),
	drawtype = "plantlike",
	tiles = {"farming_barley_1.png"},
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
		handy = 1, snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	_mcl_hardness = farming.mcl_hardness,
	is_ground_content = false,
	sounds = farming.node_sound_leaves_defaults()
}

-- stage 1

minetest.register_node("farming:barley_1", table.copy(def))

-- stage 2

def.tiles = {"farming_barley_2.png"}
minetest.register_node("farming:barley_2", table.copy(def))

-- stage 3

def.tiles = {"farming_barley_3.png"}
minetest.register_node("farming:barley_3", table.copy(def))

-- stage 4

def.tiles = {"farming_barley_4.png"}
minetest.register_node("farming:barley_4", table.copy(def))

-- stage 5

def.tiles = {"farming_barley_5.png"}
minetest.register_node("farming:barley_5", table.copy(def))

-- stage 6

def.tiles = {"farming_barley_6.png"}
def.drop = {
	items = {
		{items = {"farming:barley"}, rarity = 2},
		{items = {"farming:seed_barley"}, rarity = 2}
	}
}
minetest.register_node("farming:barley_6", table.copy(def))

-- stage 7

def.tiles = {"farming_barley_7.png"}
def.drop = {
	items = {
		{items = {"farming:barley"}, rarity = 2},
		{items = {"farming:seed_barley"}, rarity = 1}
	}
}
minetest.register_node("farming:barley_7", table.copy(def))

-- stage 8 (final)

def.tiles = {"farming_barley_8.png"}
def.groups.growing = nil
def.selection_box = farming.select_final
def.drop = {
	items = {
		{items = {"farming:barley 2"}, rarity = 1},
		{items = {"farming:barley"}, rarity = 2},
		{items = {"farming:seed_barley 2"}, rarity = 1},
		{items = {"farming:seed_barley"}, rarity = 2}
	}
}
minetest.register_node("farming:barley_8", table.copy(def))

-- add to registered_plants

farming.registered_plants["farming:barley"] = {
	crop = "farming:barley",
	seed = "farming:seed_barley",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 8
}
