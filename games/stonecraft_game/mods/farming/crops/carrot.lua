
-- Original textures from PixelBox texture pack
-- https://forum.minetest.net/viewtopic.php?id=4990

local S = minetest.get_translator("farming")
local a = farming.recipe_items

-- item/seed

minetest.register_craftitem("farming:carrot", {
	description = S("Carrot"),
	inventory_image = "farming_carrot.png",
	groups = {compostability = 48, seed = 2, food_carrot = 1},
	on_use = minetest.item_eat(4),

	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:carrot_1")
	end
})

farming.add_eatable("farming:carrot", 4)

-- crop definition

local def = {
	description = S("Carrot") .. S(" Crop"),
	drawtype = "plantlike",
	tiles = {"farming_carrot_1.png"},
	paramtype = "light",
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

minetest.register_node("farming:carrot_1", table.copy(def))

-- stage 2

def.tiles = {"farming_carrot_2.png"}
minetest.register_node("farming:carrot_2", table.copy(def))

-- stage 3

def.tiles = {"farming_carrot_3.png"}
minetest.register_node("farming:carrot_3", table.copy(def))

-- stage 4

def.tiles = {"farming_carrot_4.png"}
minetest.register_node("farming:carrot_4", table.copy(def))

-- stage 5

def.tiles = {"farming_carrot_5.png"}
minetest.register_node("farming:carrot_5", table.copy(def))

-- stage 6

def.tiles = {"farming_carrot_6.png"}
minetest.register_node("farming:carrot_6", table.copy(def))

-- stage 7

def.tiles = {"farming_carrot_7.png"}
def.drop = {
	items = {
		{items = {"farming:carrot"}, rarity = 1},
		{items = {"farming:carrot"}, rarity = 3}
	}
}
minetest.register_node("farming:carrot_7", table.copy(def))

-- stage 8 (final)

def.tiles = {"farming_carrot_8.png"}
def.groups.growing = nil
def.selection_box = farming.select_final
def.drop = {
	items = {
		{items = {"farming:carrot 2"}, rarity = 1},
		{items = {"farming:carrot"}, rarity = 2},
		{items = {"farming:carrot"}, rarity = 3},
	}
}
minetest.register_node("farming:carrot_8", table.copy(def))

-- add to registered_plants

farming.registered_plants["farming:carrot"] = {
	crop = "farming:carrot",
	seed = "farming:carrot",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 8
}

-- mapgen

minetest.register_decoration({
	deco_type = "simple",
	place_on = {
		"default:dirt_with_grass", "mcl_core:dirt_with_grass", "ethereal:prairie_dirt"
	},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = farming.carrot,
		spread = {x = 100, y = 100, z = 100},
		seed = 890,
		octaves = 3,
		persist = 0.6
	},
	y_min = 1, y_max = 30,
	decoration = "farming:carrot_7"
})
