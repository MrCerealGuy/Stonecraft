
local S = minetest.get_translator("farming")

-- item/seed

minetest.register_craftitem(":ethereal:strawberry", {
	description = S("Strawberry"),
	inventory_image = "ethereal_strawberry.png",
	groups = {compostability = 48, seed = 2, food_strawberry = 1, food_berry = 1},
	on_use = minetest.item_eat(1),

	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "ethereal:strawberry_1")
	end,
})

farming.add_eatable("ethereal:strawberry", 1)

-- crop definition

local def = {
	description = S("Strawberry") .. S(" Crop"),
	drawtype = "plantlike",
	tiles = {"ethereal_strawberry_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}
	},
	groups = {
		handy = 1, snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	_mcl_hardness = farming.mcl_hardness,
	is_ground_content = false,
	sounds = farming.node_sound_leaves_defaults()
}

--stage 1

minetest.register_node(":ethereal:strawberry_1", table.copy(def))

-- stage 2

def.tiles = {"ethereal_strawberry_2.png"}
minetest.register_node(":ethereal:strawberry_2", table.copy(def))

-- stage 3

def.tiles = {"ethereal_strawberry_3.png"}
minetest.register_node(":ethereal:strawberry_3", table.copy(def))

-- stage 4

def.tiles = {"ethereal_strawberry_4.png"}
minetest.register_node(":ethereal:strawberry_4", table.copy(def))

-- stage 5

def.tiles = {"ethereal_strawberry_5.png"}
minetest.register_node(":ethereal:strawberry_5", table.copy(def))

-- stage 6

def.tiles = {"ethereal_strawberry_6.png"}
minetest.register_node(":ethereal:strawberry_6", table.copy(def))

-- stage 7

def.tiles = {"ethereal_strawberry_7.png"}
def.drop = {
	items = {
		{items = {"ethereal:strawberry"}, rarity = 1},
		{items = {"ethereal:strawberry"}, rarity = 3}
	}
}
minetest.register_node(":ethereal:strawberry_7", table.copy(def))

-- stage 8 (final)

def.tiles = {"ethereal_strawberry_8.png"}
def.groups.growing = nil
def.selection_box = farming.select_final
def.drop = {
	items = {
		{items = {"ethereal:strawberry 2"}, rarity = 1},
		{items = {"ethereal:strawberry"}, rarity = 2},
		{items = {"ethereal:strawberry"}, rarity = 3},
		{items = {"ethereal:strawberry"}, rarity = 4},
	}
}
minetest.register_node(":ethereal:strawberry_8", table.copy(def))

-- add to registered_plants

farming.registered_plants["ethereal:strawberry"] = {
	crop = "ethereal:strawberry",
	seed = "ethereal:strawberry",
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
		scale = farming.strawberry,
		spread = {x = 100, y = 100, z = 100},
		seed = 143,
		octaves = 3,
		persist = 0.6
	},
	y_min = 15, y_max = 55,
	decoration = "ethereal:strawberry_7"
})
