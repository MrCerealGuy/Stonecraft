
local S = minetest.get_translator("farming")

-- seed

minetest.register_node("farming:seed_hemp", {
	description = S("Hemp Seed"),
	tiles = {"farming_hemp_seed.png"},
	inventory_image = "farming_hemp_seed.png",
	wield_image = "farming_hemp_seed.png",
	drawtype = "signlike",
	groups = {
		handy = 1, compostability = 38, seed = 1, snappy = 3, attached_node = 1,
		growing = 1
	},
	_mcl_hardness = farming.mcl_hardness,
	is_ground_content = false,
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	sunlight_propagates = true,
	selection_box = farming.select,
	next_plant = "farming:hemp_1",

	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:seed_hemp")
	end,

	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name = "farming:hemp_1", param2 = 1})
	end
})

-- item

minetest.register_craftitem("farming:hemp_leaf", {
	description = S("Hemp Leaf"),
	inventory_image = "farming_hemp_leaf.png",
	groups = {compostability = 35}
})

-- crop definition

local def = {
	description = S("Hemp") .. S(" Crop"),
	drawtype = "plantlike",
	tiles = {"farming_hemp_1.png"},
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

minetest.register_node("farming:hemp_1", table.copy(def))

-- stage 2

def.tiles = {"farming_hemp_2.png"}
minetest.register_node("farming:hemp_2", table.copy(def))

-- stage 3

def.tiles = {"farming_hemp_3.png"}
minetest.register_node("farming:hemp_3", table.copy(def))

-- stage 4

def.tiles = {"farming_hemp_4.png"}
minetest.register_node("farming:hemp_4", table.copy(def))

-- stage 5

def.tiles = {"farming_hemp_5.png"}
minetest.register_node("farming:hemp_5", table.copy(def))

-- stage 6

def.tiles = {"farming_hemp_6.png"}
def.drop = {
	items = {
		{items = {"farming:hemp_leaf"}, rarity = 2},
		{items = {"farming:seed_hemp"}, rarity = 1}
	}
}
minetest.register_node("farming:hemp_6", table.copy(def))

-- stage 7

def.tiles = {"farming_hemp_7.png"}
def.drop = {
	items = {
		{items = {"farming:hemp_leaf"}, rarity = 1},
		{items = {"farming:hemp_leaf"}, rarity = 3},
		{items = {"farming:seed_hemp"}, rarity = 1},
		{items = {"farming:seed_hemp"}, rarity = 3}
	}
}
minetest.register_node("farming:hemp_7", table.copy(def))

-- stage 8 (final)

def.tiles = {"farming_hemp_8.png"}
def.groups.growing = nil
def.selection_box = farming.select_final
def.drop = {
	items = {
		{items = {"farming:hemp_leaf 2"}, rarity = 1},
		{items = {"farming:hemp_leaf"}, rarity = 2},
		{items = {"farming:seed_hemp 2"}, rarity = 1},
		{items = {"farming:seed_hemp"}, rarity = 2}
	}
}
minetest.register_node("farming:hemp_8", table.copy(def))

-- add to registered_plants

farming.registered_plants["farming:hemp"] = {
	crop = "farming:hemp",
	seed = "farming:seed_hemp",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 8
}

-- mapgen

minetest.register_decoration({
	deco_type = "simple",
	place_on = {
		"default:dirt_with_grass", "default:dirt_with_rainforest_litter",
		"mcl_core:dirt_with_grass", "ethereal:prairie_dirt"
	},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = farming.hemp,
		spread = {x = 100, y = 100, z = 100},
		seed = 420,
		octaves = 3,
		persist = 0.6
	},
	y_min = 3, y_max = 45,
	decoration = "farming:hemp_7",
	spawn_by = "group:tree", num_spawn_by = 1
})
