
local S = minetest.get_translator("farming")

-- item/seed

minetest.register_craftitem("farming:vanilla", {
	description = S("Vanilla"),
	inventory_image = "farming_vanilla.png",
	groups = {compostability = 48, seed = 2, food_vanilla = 1},
	on_use = minetest.item_eat(1),

	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:vanilla_1")
	end
})

farming.add_eatable("farming:vanilla", 1)

-- crop definition

local def = {
	description = S("Vanilla") .. S(" Crop"),
	drawtype = "plantlike",
	tiles = {"farming_vanilla_1.png"},
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

minetest.register_node("farming:vanilla_1", table.copy(def))

-- stage 2

def.tiles = {"farming_vanilla_2.png"}
minetest.register_node("farming:vanilla_2", table.copy(def))

-- stage 3

def.tiles = {"farming_vanilla_3.png"}
minetest.register_node("farming:vanilla_3", table.copy(def))

-- stage 4

def.tiles = {"farming_vanilla_4.png"}
minetest.register_node("farming:vanilla_4", table.copy(def))

-- stage 5

def.tiles = {"farming_vanilla_5.png"}
minetest.register_node("farming:vanilla_5", table.copy(def))

-- stage 6

def.tiles = {"farming_vanilla_6.png"}
def.visual_scale = 1.9
minetest.register_node("farming:vanilla_6", table.copy(def))

-- stage 7

def.tiles = {"farming_vanilla_7.png"}
def.drop = {
	items = {
		{items = {"farming:vanilla"}, rarity = 1},
		{items = {"farming:vanilla"}, rarity = 3}
	}
}
minetest.register_node("farming:vanilla_7", table.copy(def))

-- stage 8 (final)

def.tiles = {"farming_vanilla_8.png"}
def.groups.growing = nil
def.selection_box = farming.select_final
def.drop = {
	items = {
		{items = {"farming:vanilla 2"}, rarity = 1},
		{items = {"farming:vanilla"}, rarity = 2},
		{items = {"farming:vanilla"}, rarity = 3},
		{items = {"farming:vanilla"}, rarity = 4}
	}
}
minetest.register_node("farming:vanilla_8", table.copy(def))

-- add to registered_plants

farming.registered_plants["farming:vanilla"] = {
	crop = "farming:vanilla",
	seed = "farming:vanilla",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 8
}

-- mapgen

minetest.register_decoration({
	deco_type = "simple",
	place_on = {
		"default:dirt_with_grass", "mcl_core:dirt_with_grass", "ethereal:grove_dirt"
	},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = farming.vanilla,
		spread = {x = 100, y = 100, z = 100},
		seed = 476,
		octaves = 3,
		persist = 0.6
	},
	y_min = 5, y_max = 35,
	decoration = "farming:vanilla_7"
})
